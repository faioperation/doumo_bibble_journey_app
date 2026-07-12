import 'dart:convert';
import 'dart:io';
import 'package:bible_journey/app/Urls.dart';
import 'package:http/http.dart' as http;
import '../../app/auth_utils.dart';
import 'local_storage_service.dart';

class ApiServices{

  static Future<Map<String, dynamic>?> getProfile() async {
    final token = await LocalStorage.getToken();

    final url = Uri.parse(Urls.profileUrl);

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
      return jsonDecode(response.body);
    } else {
      print("Profile Error: ${response.statusCode}");
      print(response.body);
      return null;
    }
  }


  static Future<bool> updateProfile({
    required String name,
    //required String email,
    required String phone,
    required String gender,
    required String dateOfBirth,
    File? avatar,
  }) async {
    final token = await LocalStorage.getToken();

    final url = Uri.parse(Urls.editProfileUrl);

    var request = http.MultipartRequest("PUT", url);

    request.headers["Authorization"] = "Bearer $token";

    request.fields["name"] = name;
    //request.fields["email"] = email;
    request.fields["phone"] = phone;
    request.fields["gender"] = gender;
    request.fields["date_of_birth"] = dateOfBirth;

    if (avatar != null) {
      request.files.add(await http.MultipartFile.fromPath("avatar", avatar.path));
    }

    final response = await request.send();
    final responseBody = await response.stream.bytesToString();

    print("PROFILE UPDATE RESPONSE: $responseBody");

    return response.statusCode == 200;
  }
}