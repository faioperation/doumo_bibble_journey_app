import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/app/routes.dart';
import 'package:bible_journey/widgets/buttons/auth_flow_custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/local_storage_service.dart';
import '../../../widgets/textField/custom_text_field.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  bool _isLoading = false;

  void signup() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await AuthService().signup(
        fullName: nameController.text.trim(),
        email: emailController.text.trim(),
        phone: phoneController.text.trim().isEmpty
            ? null
            : phoneController.text.trim(),
        password: passwordController.text.trim(),
        confirmPassword: confirmPasswordController.text.trim(),
      );

      if (response['token'] != null && response['token'].toString().isNotEmpty) {
        await LocalStorage.saveToken(response['token']);
        await LocalStorage.saveEmail(emailController.text.trim());

        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(response['message'] ?? 'Signup Successful')),
        );

        Navigator.pushReplacementNamed(context, AppRoutes.quizIntroScreen);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Signup failed. Token not received")),
        );
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Signup failed: ${e.toString()}")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  Widget _label(String text) {
    return Align(
      alignment: Alignment.centerLeft,
      child: Padding(
        padding: const EdgeInsets.only(bottom: 6),
        child: Text(
          text,
          style: const TextStyle(
            fontSize: 15,
            fontWeight: FontWeight.w600,
            color: Color(0xFF494C4F),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 231, 1),
      resizeToAvoidBottomInset: false,
      body: Stack(
        children: [
          // 🔒 Fixed background
          // Positioned.fill(
          //   child: Image.asset(
          //     AppImages.signUpBg,
          //     fit: BoxFit.cover,
          //   ),
          // ),

          SafeArea(
            child: Column(
              children: [
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    icon: const Icon(Icons.arrow_back),
                    onPressed: () => Navigator.pop(context),
                  ),
                ),

                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.fromLTRB(
                      18,
                      20,
                      18,
                      keyboardHeight > 0 ? keyboardHeight + 20 : 40,
                    ),
                    child: Form(
                      key: _formKey,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(AppImages.appLogo, height: 90),
                          const SizedBox(height: 12),

                          // Name
                          _label("sign_up.full_name".tr()),
                          CustomTextField(
                            label: "sign_up.full_name".tr(),
                            controller: nameController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Full name is required";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          _label("sign_up.email".tr()),
                          CustomTextField(
                            label: "sign_up.email".tr(),
                            controller: emailController,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Email is required";
                              }
                              if (!RegExp(r'\S+@\S+\.\S+').hasMatch(value.trim())) {
                                return "Enter a valid email";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          _label("sign_up.phone".tr()),
                          CustomTextField(
                            label: "sign_up.phone".tr(),
                            controller: phoneController,
                            validator: (value) {
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          _label("sign_up.password".tr()),
                          CustomTextField(
                            label: "sign_up.password".tr(),
                            controller: passwordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Password is required";
                              }
                              if (value.trim().length < 6) {
                                return "Password must be at least 6 characters";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 12),

                          _label("sign_up.confirm_password".tr()),
                          CustomTextField(
                            label: "sign_up.confirm_password".tr(),
                            controller: confirmPasswordController,
                            obscureText: true,
                            validator: (value) {
                              if (value == null || value.trim().isEmpty) {
                                return "Confirm password is required";
                              }
                              if (value != passwordController.text) {
                                return "Passwords do not match";
                              }
                              return null;
                            },
                          ),
                          const SizedBox(height: 20),

                          AuthCustomButton(
                            text: _isLoading ? "Loading..." : "login.sign_up".tr(),
                            height: 48,
                            onTap: _isLoading ? () {} : signup,
                          ),
                          const SizedBox(height: 18),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.logIn);
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "sign_up.already_account".tr(),
                                style: const TextStyle(color: Colors.white),
                                children: [
                                  TextSpan(
                                    text: "sign_up.sign_in".tr(),
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),

                          const SizedBox(height: 40),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
