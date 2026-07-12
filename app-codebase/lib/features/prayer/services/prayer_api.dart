import 'dart:convert';
import 'package:bible_journey/app/Urls.dart';
import 'package:http/http.dart' as http;
import '../../../app/auth_utils.dart';
import '../../../core/services/local_storage_service.dart';
import '../models/prayer_model.dart';

class PrayerApi {
  static Future<PrayerResponse> getTodayPrayer(int journeyId, int dayId) async {
    final token = await LocalStorage.getToken();
    final url = "${Urls.baseUrl}/progress/today/prayer?journey_id=$journeyId&day_id=$dayId";

    final response = await http.get(
      Uri.parse(url),
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
    );

    print("Prayer API URL: $url");
    print("Prayer API Response: ${response.body}");
    if (response.statusCode == 401 ||
        response.statusCode == 402 ||
        response.statusCode == 403) {
      await AuthUtils.handleUnauthorized();
      throw Exception("Unauthorized! Logging out...");
    }

    if (response.statusCode == 200) {
      return PrayerResponse.fromJson(jsonDecode(response.body));
    } else {
      throw Exception("Failed to fetch prayer");
    }
  }
}
