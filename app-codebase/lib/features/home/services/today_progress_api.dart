import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../app/Urls.dart';
import '../../../app/auth_utils.dart';
import '../../../core/services/local_storage_service.dart';

class TodayProgressApi {
  static Future<Map<String, dynamic>?> getTodayProgress() async {
    final token = await LocalStorage.getToken();

    final response = await http.get(
      Uri.parse("${Urls.baseUrl}/progress/today"),
      headers: {
        "Authorization": "Bearer $token",
        "Accept": "application/json",
      },
    );

    print("TODAY PROGRESS => ${response.body}");
    if (response.statusCode == 401 ||
        response.statusCode == 402 ||
        response.statusCode == 403) {
      await AuthUtils.handleUnauthorized();
      throw Exception("Unauthorized! Logging out...");
    }

    if (response.statusCode == 200) {
      final json = jsonDecode(response.body);
      return json["data"];
    }
    return null;
  }
}
