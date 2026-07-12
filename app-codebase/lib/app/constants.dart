import 'package:flutter/material.dart';

class AppColors {
  static const primary = Color(0xFF83BF8B);
  static const secondary = Color(0xFFE3E9E3);
  static const black = Colors.black;
  static const white = Colors.white;
  static const bgColor = Color(0xFFF8F5F2);
}

class AppImages{
    static const splashBg = "assets/images/Rectangle.jpg";
    static const signUpBg = "assets/images/registrationBg.jpg";
    static const appLogo = "assets/images/app_logo.png";
    static const maleImg = "assets/images/Male.png";
    static const femaleImg = "assets/images/Female.png";
}

class AppTextStyles{
  static const heading = TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.bold,
    color: Color.fromRGBO(84, 84, 84, 1)
  );

  static const normal = TextStyle(
    fontSize: 14,
    color: Colors.white,
  );
}

class AppSizes {
  static const double buttonHeight = 60;
  static const double textFieldHeight = 60;
  static const double borderRadius = 15;
  static const double padding = 16;
}
