import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../app/auth_utils.dart';
import '../models/daily_journey_details_model.dart';
import '../../../app/Urls.dart';
import '../../../core/services/local_storage_service.dart';

class DailyJourneyApi {
  static Future<DailyJourneyResponse> getDailyJourney(int journeyId) async {
    final token = await LocalStorage.getToken();
    final url = Uri.parse(Urls.dailyJourneyDetailsUrl(journeyId));

    final response = await http.get(
      url,
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
      final data = json.decode(response.body);
      return DailyJourneyResponse.fromJson(data);
    } else {
      throw Exception("Failed to load daily journey");
    }
  }
}
