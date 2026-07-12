import 'dart:convert';
import 'package:bible_journey/core/services/auth_service.dart';
import 'package:bible_journey/core/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

import '../../../app/auth_utils.dart';
import '../model/bible_model.dart';

class BibleApiService {
  static Future<List<Verse>> fetchChapter({
    required String bookName,
    required int chapter,
  }) async {
    final token = await LocalStorage.getToken();

    final url =
        //"https://bible-api.com/${bookName.toLowerCase()}:$chapter";
        "https://apps.biblejourney.pro/journey/bible/${bookName.toLowerCase()}:$chapter";

    //final response = await http.get(Uri.parse(url));
    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    if (response.statusCode == 401 ||
        response.statusCode == 402 ||
        response.statusCode == 403) {
      await AuthUtils.handleUnauthorized();
      throw Exception("Unauthorized! Logging out...");
    }

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      final List versesJson = data['verses'];

      return versesJson.map((e) => Verse.fromJson(e)).toList();
    } else {
      throw Exception("Failed to load chapter");
    }
  }
}
