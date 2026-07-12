import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../app/Urls.dart';
import '../../../app/auth_utils.dart';
import '../../../core/services/local_storage_service.dart';
import '../models/notification_model.dart';

class NotificationService {
  static Future<Map<String, List<NotificationModel>>> fetchNotifications() async {
    final token = await LocalStorage.getToken();
    if (token == null || token.isEmpty) {
      throw Exception("Auth token not found");
    }

    final response = await http.get(
      Uri.parse('${Urls.baseUrl}/notifications/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
    if (response.statusCode == 401 ||
        response.statusCode == 402 ||
        response.statusCode == 403) {
      await AuthUtils.handleUnauthorized();
      throw Exception("Unauthorized! Logging out...");
    }

    if (response.statusCode != 200) {
      throw Exception("Failed to load notifications");
    }

    final decoded = jsonDecode(response.body);
    final List list = decoded['notifications'] ?? [];

    final all = list
        .map((e) => NotificationModel.fromJson(e))
        .toList();

    final today = <NotificationModel>[];
    final yesterday = <NotificationModel>[];
    final earlier = <NotificationModel>[];

    final now = DateTime.now();

    for (final n in all) {
      final diff = now.difference(n.createdAt);

      if (diff.inDays == 0) {
        today.add(n);
      } else if (diff.inDays == 1) {
        yesterday.add(n);
      } else {
        earlier.add(n);
      }
    }

    return {
      "today": today,
      "yesterday": yesterday,
      "earlier": earlier,
    };
  }


  static Future<void> markAsRead(int id) async {
    final token = await LocalStorage.getToken();
    if (token == null || token.isEmpty) return;

    await http.post(
      Uri.parse('${Urls.baseUrl}/notifications/read/$id/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }

  static Future<void> clearAll() async {
    final token = await LocalStorage.getToken();
    if (token == null || token.isEmpty) return;

    await http.post(
      Uri.parse('${Urls.baseUrl}/notifications/clear/'),
      headers: {
        'Content-Type': 'application/json',
        'Authorization': 'Bearer $token',
      },
    );
  }
}
