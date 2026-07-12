import 'package:flutter/material.dart';
import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/widgets/buttons/auth_flow_custom_button.dart';
import 'package:bible_journey/widgets/textField/custom_text_field.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../core/services/auth_service.dart';
import 'reset_successful_screen.dart';

class SetNewPasswordScreen extends StatefulWidget {
  const SetNewPasswordScreen({super.key});

  @override
  State<SetNewPasswordScreen> createState() => _SetNewPasswordScreenState();
}

class _SetNewPasswordScreenState extends State<SetNewPasswordScreen> {
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController = TextEditingController();

  late String email;
  bool isLoading = false;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final args = ModalRoute.of(context)?.settings.arguments;
    if (args == null || args is! String) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        _showMessage("Email missing. Please try again.");
        Navigator.pop(context);
      });
      return;
    }
    email = args;
  }

  Future<void> _resetPassword() async {
    final pass = passwordController.text.trim();
    final confirm = confirmPasswordController.text.trim();

    if (pass.length < 6) {
      _showMessage("Password too short");
      return;
    }
    if (pass != confirm) {
      _showMessage("Passwords do not match");
      return;
    }

    setState(() => isLoading = true);

    try {
      final result = await AuthService.resetPassword(
        email: email,
        new_password: pass,
      );

      if (result['message'] == "Your password has been reset successfully. You can now log in with your new password.") {
        ScaffoldMessenger.of(context)
            .showSnackBar(
          const SnackBar(content: Text("Password reset successful")),
        )
            .closed
            .then((_) {
          if (!mounted) return;
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
              builder: (context) => const ResetSuccessfulScreen(),
            ),
          );
        });
      } else {
        _showMessage(result['message'] ?? "Failed to reset password");
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
                  "set_password_button.title".tr(),
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 28,
                    color: Color(0xFF005493),
                    fontWeight: FontWeight.w700,
                  ),
                ),
                const SizedBox(height: 5),
                Text(
                  "set_new_password.subtitle".tr(),
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
                SizedBox(height: height * 0.05),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "set_new_password.new_password".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(73, 76, 79, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      label: "set_new_password.password_hint".tr(),
                      controller: passwordController,
                      obscureText: true,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.025),

                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "set_new_password.confirm_password".tr(),
                      style: const TextStyle(
                        color: Color.fromRGBO(73, 76, 79, 1),
                        fontSize: 16,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    const SizedBox(height: 8),
                    CustomTextField(
                      label: "set_new_password.password_hint".tr(),
                      controller: confirmPasswordController,
                      obscureText: true,
                    ),
                  ],
                ),
                SizedBox(height: height * 0.04),

                AuthCustomButton(
                  text: "set_new_password.set_password_button".tr(),
                  height: height * 0.06,
                  isLoading: isLoading,
                  onTap: _resetPassword,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
