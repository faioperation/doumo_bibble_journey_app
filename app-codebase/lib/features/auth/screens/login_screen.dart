import 'package:bible_journey/main_bottom_nav_screen.dart';
import 'package:flutter/material.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/app/routes.dart';
import 'package:bible_journey/widgets/buttons/auth_flow_custom_button.dart';
import '../../../widgets/textField/custom_text_field.dart';
import '../../../core/services/auth_service.dart';
import '../../../core/services/local_storage_service.dart';
import 'package:flutter/services.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final _formKey = GlobalKey<FormState>();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  bool rememberMe = false;
  bool _isLoading = false;

  void login() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _isLoading = true);

    try {
      final response = await AuthService().login(
        login_id: emailController.text.trim(),
        password: passwordController.text.trim(),
      );

      if (response['statusCode'] == 403 ||
          (response['error'] != null &&
              response['error'].toString().contains("Account disabled"))) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Your account is deactivated")),
        );
        return;
      }

      await LocalStorage.saveToken(response['token']);
      await LocalStorage.saveEmail(emailController.text.trim());

      // if (response['trial_expired'] != null &&
      //     response['trial_expired'].toString().toLowerCase().contains("expired")) {
      //   Navigator.push(
      //     context,
      //     MaterialPageRoute(builder: (context) => const TrialExpiredPaymentScreen()),
      //   );
      //   return;
      // }

      if (response['category'] == null || response['category'].toString().isEmpty) {
        Navigator.pushReplacementNamed(context, AppRoutes.quizIntroScreen);
      } else {
        // Navigator.pushReplacementNamed(context, AppRoutes.mainBottomNavScreen);
        Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (_)=>MainBottomNavScreen()), (route)=>false);
      }

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text(response['message'] ?? "Login successful")),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Email or Password is incorrect")),
      );
    } finally {
      setState(() => _isLoading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final keyboardHeight = MediaQuery.of(context).viewInsets.bottom;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        
        final token = await LocalStorage.getToken();
        if (token == null || token.isEmpty) {
          SystemNavigator.pop();
        } else {
          if (mounted) {
            Navigator.pop(context);
          }
        }
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 251, 231, 1),
        resizeToAvoidBottomInset: false,
        body: Stack(
        children: [
          /// 🔥 Background
          // Positioned.fill(
          //   child: Image.asset(AppImages.splashBg, fit: BoxFit.cover),
          // ),

          SafeArea(
            child: Column(
              children: [
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
                        children: [
                          Image.asset(AppImages.appLogo, height: 90),
                          const SizedBox(height: 12),

                          Text(
                            "login.begin_journey".tr(),
                            style: const TextStyle(
                              fontSize: 28,
                              fontWeight: FontWeight.w700,
                              color: Color(0xFF005493),
                            ),
                          ),
                          const SizedBox(height: 6),

                          Text(
                            "login.subtitle".tr(),
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: 15,
                              color: Colors.black.withOpacity(0.7),
                            ),
                          ),
                          const SizedBox(height: 30),

                          _label("login.email".tr()),
                          CustomTextField(
                            label: "login.email".tr(),
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
                          const SizedBox(height: 18),

                          _label("login.password".tr()),
                          CustomTextField(
                            label: "login.password".tr(),
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
                          const SizedBox(height: 14),

                          Row(
                            children: [
                              Checkbox(
                                value: rememberMe,
                                onChanged: (v) {
                                  setState(() => rememberMe = v ?? false);
                                },
                              ),
                              Text(
                                "login.remember_me".tr(),
                                style: const TextStyle(color: Color.fromRGBO(73, 76, 79, 1)),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pushNamed(context, AppRoutes.forgotPassword);
                                },
                                child: Text(
                                  "login.forgot_password".tr(),
                                  style: const TextStyle(color: Color.fromRGBO(73, 76, 79, 1)),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 24),

                          AuthCustomButton(
                            text: _isLoading ? "Loading..." : "log_in".tr(),
                            height: 48,
                            onTap: _isLoading ? () {} : login,
                          ),
                          const SizedBox(height: 18),

                          GestureDetector(
                            onTap: () {
                              Navigator.pushNamed(context, AppRoutes.signUp);
                            },
                            child: RichText(
                              text: TextSpan(
                                text: "login.no_account".tr(),
                                style: const TextStyle(color: Color.fromRGBO(73, 76, 79, 1),fontSize: 16),
                                children: [
                                  TextSpan(
                                    text: "login.sign_up".tr(),
                                    style: const TextStyle(fontWeight: FontWeight.w700),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
      ),
    );
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
}

