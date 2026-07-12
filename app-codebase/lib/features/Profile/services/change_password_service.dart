import 'dart:convert';
import 'package:bible_journey/app/Urls.dart';
import 'package:bible_journey/core/services/local_storage_service.dart';
import 'package:http/http.dart' as http;

import '../../../app/auth_utils.dart';

class ChangePasswordApi{
  static Future<bool>changePassword({
    required String oldPassword,
    required String newPassword,
    required String confirmPassword,
})async{
  try{
    final token = await LocalStorage.getToken();
    final response = await http.post(Uri.parse(Urls.changePasswordUrl),
    headers: {
      "Content-type":"application/json",
      "Authorization": "Bearer $token"
    },
      body: jsonEncode({
        "old_password" : oldPassword,
        "new_password" : newPassword,
        "confirm_password" : confirmPassword
      })
    );
    if (response.statusCode == 401 ||
        response.statusCode == 402 ||
        response.statusCode == 403) {
      await AuthUtils.handleUnauthorized();
      throw Exception("Unauthorized! Logging out...");
    }
    if(response.statusCode == 200){
      final data = jsonDecode(response.body);
      if(data["status"]=="password_changed"){
        return true;
      }
    }
    return false;
  }catch(e){
    print("Change Password API Error: $e");
    return false;
  }
  }
}