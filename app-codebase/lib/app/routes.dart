import 'package:bible_journey/app/route_args.dart';
import 'package:flutter/material.dart';
import 'package:bible_journey/features/auth/screens/forgot_password_screen.dart';
import 'package:bible_journey/features/auth/screens/login_screen.dart';
import 'package:bible_journey/features/auth/screens/set_new_password_screen.dart';
import 'package:bible_journey/features/auth/screens/splash_screen.dart';
import 'package:bible_journey/features/auth/screens/verify_otp_screen.dart';
import 'package:bible_journey/features/journeys/screens/journey_screen.dart';
import 'package:bible_journey/features/prayer/screens/prayer_screen.dart';
import 'package:bible_journey/main_bottom_nav_screen.dart';
import 'package:bible_journey/core/services/local_storage_service.dart';
import '../features/auth/screens/signup_screen.dart';
import '../features/questionnaire/screens/question_intro_screen.dart';
class AppRoutes {
  static const String splash = '/splash';
  static const String logIn = '/signIn';
  static const String signUp = '/signUp';
  static const String forgotPassword = '/forgotPassword';
  static const String otpScreen = '/otpScreen';
  static const String setPasswordScreen = '/setPasswordScreen';
  static const String mainBottomNavScreen = '/mainBottomNavScreen';
  static const String quizIntroScreen = '/quizIntroScreen';
  static const String prayerScreen = '/prayerScreen';
  static const String journeyScreen = '/journeyScreen';
  static const String dailyDevotionScreen = '/dailyDevotionScreen';

  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {

      case splash:
        return MaterialPageRoute(builder: (_) => const SplashScreen());

      case logIn:
        return MaterialPageRoute(builder: (_) => const LoginScreen());

      case signUp:
        return MaterialPageRoute(builder: (_) => const SignUpScreen());

      case forgotPassword:
        return MaterialPageRoute(builder: (_) => const ForgotPasswordScreen());

      case otpScreen:
        final email = settings.arguments as String;
        return MaterialPageRoute(
          builder: (_) => VerifyOtpScreen(email: email),
        );

      case setPasswordScreen:
        return MaterialPageRoute(builder: (_) => const SetNewPasswordScreen());

      case mainBottomNavScreen:
        return MaterialPageRoute(
          builder: (_) => FutureBuilder<String?>(
            future: LocalStorage.getToken(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              
              if (snapshot.data == null || snapshot.data!.isEmpty) {
                WidgetsBinding.instance.addPostFrameCallback((_) {
                  if (context.mounted) {
                    Navigator.pushReplacementNamed(context, splash);
                  }
                });
                return const Scaffold(
                  body: Center(child: CircularProgressIndicator()),
                );
              }
              
              return const MainBottomNavScreen();
            },
          ),
        );

      case quizIntroScreen:
        return MaterialPageRoute(builder: (_) => const QuizIntroScreen());

      case journeyScreen:
        return MaterialPageRoute(builder: (_) => const JourneyScreen());

      case prayerScreen:
        final args = settings.arguments as JourneyStepArgs;
        return MaterialPageRoute(
          builder: (_) => PrayerScreen(
            journeyId: args.journeyId,
            dayId: args.dayId,
          ),
        );

      default:
        return MaterialPageRoute(
          builder: (_) => const SplashScreen(),
        );

    }
  }
}

