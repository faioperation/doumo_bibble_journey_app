import 'dart:convert';
import 'package:bible_journey/app/Urls.dart';
import 'package:http/http.dart' as http;
import '../../../app/auth_utils.dart';
import '../../../core/services/local_storage_service.dart';
import '../models/journey_model.dart';

class JourneyApi {
  static Future<List<Journey>> getJourneys() async {
    final token = await LocalStorage.getToken();
    final url = Uri.parse(Urls.journeyCardUrl);

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
      final journeyResponse = JourneyResponse.fromJson(data);
      return journeyResponse.journeys;
    } else {
      throw Exception("Failed to load journeys");
    }
  }
}

