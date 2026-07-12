import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/features/auth/screens/login_screen.dart';
import 'package:bible_journey/widgets/buttons/custom_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ResetSuccessfulScreen extends StatefulWidget {
  const ResetSuccessfulScreen({super.key});

  @override
  State<ResetSuccessfulScreen> createState() => _ResetSuccessfulScreenState();
}

class _ResetSuccessfulScreenState extends State<ResetSuccessfulScreen> {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: Color.fromRGBO(255, 251, 231, 1),
      body: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            // decoration: BoxDecoration(
            //   image: DecorationImage(
            //     image: AssetImage(AppImages.splashBg),
            //     fit: BoxFit.cover,
            //   ),
            // ),
          ),

          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: SafeArea(
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 20),
                child: Column(
                  children: [
                    // Back button
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back, color: Color.fromRGBO(92, 92, 92, 1),),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),

                    const SizedBox(height: 20),

                    Image.asset(
                      'assets/images/check_circle.png',
                      height: 100,
                      width: 100,
                    ),

                    const SizedBox(height: 20),

                    const Text(
                      "Password Reset Successfully!",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w600,
                        color: Color.fromRGBO(92, 92, 92, 1),
                      ),
                    ),

                    const SizedBox(height: 12),

                    const Text(
                      "Your password has been successfully reset.\nYou can now log in with your new password.",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Color.fromRGBO(92, 92, 92, 1),
                      ),
                    ),

                    const SizedBox(height: 40),

                    CustomButton(text: "Log In", onTap: (){
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>LoginScreen()), (route)=>false);
                    }),
                    const SizedBox(height: 30),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
