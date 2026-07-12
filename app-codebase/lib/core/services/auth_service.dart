import 'dart:convert';
import 'package:bible_journey/app/Urls.dart';
import 'package:http/http.dart' as http;

import '../../app/auth_utils.dart';
import 'local_storage_service.dart';

class AuthService {
  Future<Map<String, dynamic>> signup({
    required String fullName,
    required String email,
    String? phone,
    required String password,
    required String confirmPassword,
  }) async {
    final url = Uri.parse(Urls.signUpUrl);
    final body = jsonEncode({
      "full_name": fullName,
      "email": email,
      "phone": phone?.isEmpty == true ? null : phone,
      "password": password,
      "confirm_password": confirmPassword,
    });

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: body,
    );

    if (response.statusCode == 200 || response.statusCode == 201) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Signup failed: ${response.body}');
    }
  }

  Future<Map<String, dynamic>> login({
    required String login_id,
    required String password,
  }) async {
    final url = Uri.parse(Urls.signInUrl);
    final body = jsonEncode({"login_id": login_id, "password": password});

    try {
      final response = await http.post(
        url,
        headers: {"Content-Type": "application/json"},
        body: body,
      );

      final data = jsonDecode(response.body);

      if (response.statusCode == 200 && data['status'] == 'success') {
        await LocalStorage.saveToken(data['token']);
        await LocalStorage.saveEmail(login_id);

        return {...data, "statusCode": 200};
      } else {
        return {
          "statusCode": response.statusCode,
          "error": data['error'] ?? data['message'] ?? "Login failed"
        };
      }
    } catch (e) {
      return {"statusCode": 500, "error": e.toString()};
    }
  }



  Future<Map<String, dynamic>> logOut({required String email}) async {
    final token = await LocalStorage.getToken();
    final url = Uri.parse(Urls.logOutUrl);
    final body = jsonEncode({"email": email});

    final response = await http.post(
      url,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $token",
      },
      body: body,
    );
    if (response.statusCode == 401 ||
        response.statusCode == 402 ||
        response.statusCode == 403) {
      await AuthUtils.handleUnauthorized();
      throw Exception("Unauthorized! Logging out...");
    }
    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception("LogOut Failed : ${response.body}");
    }
  }


  static Future<Map<String, dynamic>> forgotPassword(String email) async {
    final url = Uri.parse(Urls.forgotPasswordUrl);
    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({"email": email}),
    );

    if (response.statusCode == 200) {
      return jsonDecode(response.body);
    } else {
      throw Exception('Failed to send reset code');
    }
  }

  // static Future<bool> verifyForgotPasswordOtp(String email, String otp) async {
  //   final url = Uri.parse(Urls.otpVerifyUrl);
  //
  //   final response = await http.post(
  //     url,
  //     headers: {"Content-Type": "application/json"},
  //     body: jsonEncode({
  //       "email": email,
  //       "otp": otp,
  //     }),
  //   );
  //
  //   final data = jsonDecode(response.body);
  //
  //   // if (response.statusCode == 200 && data["status"] == "verified") {
  //   //   return true;
  //   // }
  //
  //   if (response.statusCode == 200) {
  //     if (data["status"] == "verified" || data["action"] == "reset_password") {
  //       return true;
  //     }
  //   }
  //   else {
  //     throw Exception(data["message"] ?? "Invalid OTP");
  //   }
  // }
  static Future<bool> verifyForgotPasswordOtp(
      String email, String otp) async {
    final url = Uri.parse(Urls.otpVerifyUrl);

    final response = await http.post(
      url,
      headers: {"Content-Type": "application/json"},
      body: jsonEncode({
        "email": email,
        "otp": otp,
      }),
    );

    final data = jsonDecode(response.body);

    if (response.statusCode == 200 ) {
      return true;
    }

    throw Exception(data["message"] ?? "Invalid OTP");
  }


  static Future<Map<String, dynamic>> resetPassword({
    required String email,
    required String new_password,
  }) async {
    final url = Uri.parse(Urls.resetPasswordUrl);

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode({
          'email': email,
          'new_password': new_password,
        }),
      );

      print("Status code: ${response.statusCode}");
      print("Response body: ${response.body}");

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        return data;
      } else {
        return {
          'success': false,
          'message': 'Failed to reset password. Status: ${response.statusCode}',
        };
      }
    } catch (e) {
      return {
        'success': false,
        'message': 'Error: ${e.toString()}',
      };
    }
  }
}
