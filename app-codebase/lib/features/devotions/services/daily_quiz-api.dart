import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../app/auth_utils.dart';
import '../../../core/services/local_storage_service.dart';
import 'package:bible_journey/app/Urls.dart';

class QuizApi {

  static Future<List<dynamic>> getDayQuiz({
    required int journeyId,
    required int dayId,
  }) async {
    final token = await LocalStorage.getToken();

    final url =
        "${Urls.baseUrl}/progress/today/quiz?journey_id=$journeyId&day_id=$dayId";

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
      return data['data'] ?? [];
    } else {
      throw Exception("Failed to load quiz");
    }
  }

  static Future<int> submitQuiz(List<Map<String, dynamic>> answers) async {
    final token = await LocalStorage.getToken();

    final url = Uri.parse("${Urls.baseUrl}/quiz/quiz_submit/");

    final response = await http.post(
      url,
      headers: {
        "Authorization": "Bearer $token",
        "Content-Type": "application/json",
      },
      body: jsonEncode({
        "answers": answers,
      }),
    );

    if (response.statusCode == 200) {
      final data = jsonDecode(response.body);

      return data['points_added'] ?? 0;
    } else {
      throw Exception("Failed to submit quiz");
    }
  }
}
