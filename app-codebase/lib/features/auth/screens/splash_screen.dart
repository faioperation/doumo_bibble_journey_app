import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/app/routes.dart';
import 'package:bible_journey/features/auth/screens/signup_screen.dart';
import 'package:bible_journey/widgets/buttons/auth_flow_custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/services/local_storage_service.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    final token = await LocalStorage.getToken();
    final isFirstLaunch = await LocalStorage.isFirstLaunch();

    if (token != null && token.isNotEmpty) {
      // Has token, go to main screen
      Future.microtask(() {
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.mainBottomNavScreen,
          );
        }
      });
    } else if (!isFirstLaunch) {
      Future.microtask(() {
        if (mounted) {
          Navigator.pushReplacementNamed(
            context,
            AppRoutes.logIn,
          );
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;
    final width = size.width;

    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        SystemNavigator.pop();
      },
      child: Scaffold(
        backgroundColor: Color.fromRGBO(255, 251, 231, 1),
        body: Stack(
        children: [
          // Positioned.fill(
          //   child: Image.asset(
          //     AppImages.splashBg,
          //     fit: BoxFit.cover,
          //   ),
          // ),

          SafeArea(
            child: Align(
              alignment: Alignment.topCenter,
              child: Padding(
                padding: EdgeInsets.only(top: height * 0.07),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [

                    // SvgPicture.asset(
                    //   AppImages.appLogo,
                    //   height: height * 0.22,
                    //   width: width * 0.45,
                    //   fit: BoxFit.contain,
                    // ),
                    Image.asset(
                      AppImages.appLogo,
                      height: height * 0.22,
                      width: width * 0.45,
                      fit: BoxFit.contain,
                      errorBuilder: (context, error, stackTrace) {
                        // Fallback if image fails to load
                        return Icon(
                          Icons.image_not_supported,
                          size: height * 0.22,
                          color: Colors.grey,
                        );
                      },
                    ),

                    SizedBox(height: height * 0.025),

                    Text(
                      "splash.title".tr(),
                      style: TextStyle(
                        fontWeight: FontWeight.w700,
                        color: const Color.fromRGBO(3, 91, 143, 1),
                        fontSize: height * 0.045,
                      ),
                      textAlign: TextAlign.center,
                    ),

                    SizedBox(height: height * 0.015),

                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: width * 0.10),
                      child: Text(
                        "splash.subtitle".tr(),
                        // style: AppTextStyles.heading.copyWith(
                        //   fontSize: height * 0.022,
                        // ),
                        textAlign: TextAlign.center,
                        style: TextStyle(color: Color.fromRGBO(92, 92, 92, 1),fontSize: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          Positioned(
            bottom: height * 0.25,
            left: width * 0.07,
            right: width * 0.07,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                SizedBox(
                  width: double.infinity,
                  child: AuthCustomButton(
                    text: "get_started".tr(),
                    onTap: () async {
                      await LocalStorage.setFirstLaunchComplete();
                      //Navigator.pushNamed(context, AppRoutes.mainBottomNavScreen);
                      if (mounted) {
                        Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUpScreen()));
                      }
                    },
                    height: height * 0.055,
                  ),
                ),

                SizedBox(height: height * 0.02),

                GestureDetector(
                  onTap: () async {
                    await LocalStorage.setFirstLaunchComplete();
                    if (mounted) {
                      Navigator.pushNamed(context, AppRoutes.logIn);
                    }
                  },
                  child: Text.rich(
                    TextSpan(
                      text: "already_account".tr(),
                      style:TextStyle(color: Color.fromRGBO(92, 92, 92, 1),fontSize: 16),
                      // AppTextStyles.normal.copyWith(
                      //   fontSize: height * 0.022,
                      // ),
                      children: [
                        TextSpan(
                          text: "log_in".tr(),
                          style: TextStyle(color: Color(0xFF015093), fontWeight: FontWeight.w600),
                        ),
                      ],
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
}
