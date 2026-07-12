import 'package:bible_journey/features/auth/screens/verify_otp_screen.dart';
import 'package:flutter/material.dart';
import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/widgets/buttons/auth_flow_custom_button.dart';
import 'package:bible_journey/widgets/textField/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/services/auth_service.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen({super.key});

  @override
  State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final TextEditingController emailController = TextEditingController();
  bool isLoading = false;

  // Future<void> _sendOtp() async {
  //   final email = emailController.text.trim();
  //   if (email.isEmpty || !email.contains("@")) {
  //     _showMessage("Enter a valid email");
  //     return;
  //   }
  //
  //   setState(() => isLoading = true);
  //
  //   try {
  //     final response = await AuthService.forgotPassword(email);
  //
  //     if (response['status'] == 'otp_sent') {
  //       if (!mounted) return;
  //       setState(() => isLoading = false);
  //       //await Future.delayed(const Duration(seconds: 10));
  //
  //       _showMessage("OTP sent to your email");
  //
  //       Navigator.push(
  //         context,
  //         MaterialPageRoute(
  //           builder: (_) => VerifyOtpScreen(email: email),
  //         ),
  //       );
  //     } else {
  //       if (!mounted) return;
  //       setState(() => isLoading = false);
  //
  //       _showMessage(response['message'] ?? "Failed to send OTP");
  //     }
  //   } catch (e) {
  //     if (!mounted) return;
  //     setState(() => isLoading = false);
  //
  //     _showMessage("Error: ${e.toString().replaceAll("Exception: ", "")}");
  //   }
  // }

  Future<void> _sendOtp() async {
    final email = emailController.text.trim().toLowerCase();

    if (email.isEmpty || !email.contains("@")) {
      _showMessage("Enter a valid email");
      return;
    }

    setState(() => isLoading = true);

    try {
      final response = await AuthService.forgotPassword(email);

      if (response['message'] == 'OTP sent') {
        if (!mounted) return;

        _showMessage("OTP sent to your email");

        await Future.delayed(const Duration(seconds: 2));

        if (!mounted) return;
        setState(() => isLoading = false);

        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => VerifyOtpScreen(email: email),
          ),
        );
      } else {
        setState(() => isLoading = false);
        _showMessage(response['message'] ?? "Failed to send OTP");
      }
    } catch (e) {
      if (!mounted) return;
      setState(() => isLoading = false);
      _showMessage(
        e.toString().replaceAll("Exception: ", ""),
      );
    }
  }


  void _showMessage(String msg) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text(msg)));
  }

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 231, 1),
      body: Container(
        width: double.infinity,
        height: double.infinity,
        // decoration: BoxDecoration(
        //   image: DecorationImage(
        //     image: AssetImage(AppImages.splashBg),
        //     fit: BoxFit.cover,
        //   ),
        // ),
        child: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.symmetric(horizontal: 18.0, vertical: 18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => Navigator.pop(context),
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                  ),
                ),
                SizedBox(height: height * 0.02),
                Image.asset(AppImages.appLogo, height: height * 0.13),
                SizedBox(height: height * 0.018),
                Text(
                  "forgot_password.title".tr(),
                  style: const TextStyle(
                    fontSize: 28,
                    color: Color(0xFF005493),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "forgot_password.subtitle".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: height * 0.03),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "sign_up.email".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(73, 76, 79, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      label: "forgot_password.email_hint".tr(),
                      controller: emailController,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.03),
                AuthCustomButton(
                  text: "forgot_password.send_code".tr(),
                  height: height * 0.055,
                  isLoading: isLoading,
                  onTap: _sendOtp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
