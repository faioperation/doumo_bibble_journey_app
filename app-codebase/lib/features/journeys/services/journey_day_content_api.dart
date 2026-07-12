import 'dart:convert';
import 'package:bible_journey/app/Urls.dart';
import 'package:http/http.dart' as http;
import '../../../app/auth_utils.dart';
import '../../../core/services/local_storage_service.dart';
import '../models/journey_day_content_model.dart';

class JourneyDayContentApi {
  static Future<JourneyDayContentResponse> getDayContent(
      int journeyId,
      int dayId,
      ) async {
    final token = await LocalStorage.getToken();

    if (token == null || token.isEmpty) {
      throw Exception("Unauthorized: Token missing");
    }

    final url = Urls.journeyContentUrl(journeyId, dayId);

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );
    if (response.statusCode == 401 ||
        response.statusCode == 402 ||
        response.statusCode == 403) {
      await AuthUtils.handleUnauthorized();
      throw Exception("Unauthorized! Logging out...");
    }

    if (response.statusCode == 200) {
      return JourneyDayContentResponse.fromJson(
        jsonDecode(response.body),
      );
    } else {
      final error = jsonDecode(response.body);
      throw Exception(error['message'] ?? "Failed to load step progress");
    }
  }
}
