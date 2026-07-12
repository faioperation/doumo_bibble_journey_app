import 'package:flutter/material.dart';
import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/widgets/buttons/auth_flow_custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:pin_code_fields/pin_code_fields.dart';
import '../../../core/services/auth_service.dart';
import 'set_new_password_screen.dart';

class VerifyOtpScreen extends StatefulWidget {
  final String email;
  const VerifyOtpScreen({super.key, required this.email});

  @override
  State<VerifyOtpScreen> createState() => _VerifyOtpScreenState();
}



class _VerifyOtpScreenState extends State<VerifyOtpScreen> {
  final TextEditingController OTPController = TextEditingController();
  bool isLoading = false;

  //String get email => widget.email;
  String get email => widget.email.toLowerCase();


  Future<bool> verifyWithRetry(String email, String otp) async {
    for (int i = 0; i < 2; i++) {
      try {
        return await AuthService.verifyForgotPasswordOtp(email, otp);
      } catch (e) {
        if (i == 1) rethrow;
        await Future.delayed(const Duration(seconds: 2));
      }
    }
    throw Exception("Invalid OTP");
  }


  Future<void> _verifyOtp() async {
    await Future.delayed(const Duration(milliseconds: 600));
    final otp = OTPController.text.trim();
    if (otp.length < 6) {
      _showMessage("Enter valid OTP");
      return;
    }

    await Future.delayed(const Duration(seconds: 2));
    setState(() => isLoading = true);

    try {
      //final isVerified = await AuthService.verifyForgotPasswordOtp(email, otp);
      final isVerified = await verifyWithRetry(email, otp);

      if (isVerified) {
        _showMessage("OTP verified successfully");

        if (!mounted) return;
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (_) => SetNewPasswordScreen(),
            settings: RouteSettings(arguments: email),
          ),
        );
      } else {
        _showMessage("Invalid OTP. Try again.");
      }
    } catch (e) {
      _showMessage("Error: ${e.toString().replaceAll("Exception: ", "")}");
    }

    if (!mounted) return;
    setState(() => isLoading = false);
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
                  "otp.check_email".tr(),
                  style: const TextStyle(
                    fontSize: 28,
                    color: Color(0xFF005493),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "otp.verification_sent".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: height * 0.03),
                PinCodeTextField(
                  length: 6,
                  obscureText: false,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  keyboardType: TextInputType.number,
                  animationType: AnimationType.fade,
                  pinTheme: PinTheme(
                    shape: PinCodeFieldShape.box,
                    borderRadius: BorderRadius.circular(8),
                    fieldHeight: 50,
                    fieldWidth: 40,
                    activeColor: Colors.green,
                    selectedColor: Colors.grey,
                    inactiveColor: Color.fromRGBO(92, 92, 92, 1),
                  ),
                  animationDuration: const Duration(milliseconds: 300),
                  controller: OTPController,
                  appContext: context,
                ),
                SizedBox(height: height * 0.03),
                AuthCustomButton(
                  text: isLoading ? "Loading..." : "otp.verify_button".tr(),
                  height: height * 0.055,
                  isLoading: isLoading,
                  onTap: _verifyOtp,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
