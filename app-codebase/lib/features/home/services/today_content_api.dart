import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../app/Urls.dart';
import '../../../app/auth_utils.dart';
import '../../../core/services/local_storage_service.dart';

class TodayContentApi {
  static Future<List<dynamic>> getContent({
    required String type,
    required int dayId,
  }) async {
    final token = await LocalStorage.getToken();

    final response = await http.get(
      Uri.parse("${Urls.baseUrl}/progress/today/$type?day_id=$dayId"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    print("$type => ${response.body}");
    if (response.statusCode == 401 ||
        response.statusCode == 402 ||
        response.statusCode == 403) {
      await AuthUtils.handleUnauthorized();
      throw Exception("Unauthorized! Logging out...");
    }

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["data"] ?? [];
    } else {
      return [];
    }
  }
}
