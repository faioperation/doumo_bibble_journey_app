import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/core/services/auth_service.dart';
import 'package:bible_journey/features/Profile/screens/change_password_screen.dart';
import 'package:bible_journey/features/Profile/screens/deactivated_pop_up.dart';
import 'package:bible_journey/features/Profile/screens/language_screen.dart';
import 'package:bible_journey/features/Profile/screens/money_back_policy_screen.dart';
import 'package:bible_journey/features/Profile/screens/privacy_policy_screen.dart';
import 'package:bible_journey/features/Profile/screens/profile_details.dart';
import 'package:bible_journey/features/Profile/screens/subscription_terms_screen.dart';
import 'package:bible_journey/features/Profile/screens/terms_service_screen.dart';
import 'package:bible_journey/features/auth/screens/login_screen.dart';
import 'package:bible_journey/main_bottom_nav_screen.dart';
import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../../../core/services/local_storage_service.dart';
import '../services/deactivated_service.dart';
import '../services/delete_account_service.dart';
import '../widgets/custom_box.dart';
import 'delete_account_pop_up.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {

  @override
  void initState() {
    super.initState();
    debugPrint("OPENED: Profile Screen");
  }


  @override

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final h = size.height;
    final w = size.width;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: CustomAppBar(
        title: "Profile",
        showBackButton: false,
        onTap: () {
          Navigator.pushAndRemoveUntil(
            context,
            MaterialPageRoute(builder: (_) => MainBottomNavScreen()),
                (_) => false,
          );
        },
      ),

      body: ListView(
        padding: EdgeInsets.only(bottom: h * 0.04),
        children: [

          _sectionTitle("account".tr(), w),

          _card(
            w,
            child: Column(
              children: [
                CustomText(
                  textIconPath: 'assets/images/User.svg',
                  text: "profile_details".tr(),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ProfileDetails()),
                    );
                  },
                ),

                // _subText("username_email".tr()),
              ],
            ),
          ),

          _sectionTitle("account_settings".tr(), w),

          _card(
            w,
            child: Column(
              children: [

                CustomText(
                  textIconPath: 'assets/images/Globe.svg',
                  text: "change_language".tr(),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const LanguageScreen()),
                    );
                  },
                ),

                _divider(),

                CustomText(
                  textIconPath: 'assets/images/LockOpen.svg',
                  text: "change_password".tr(),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (_) => const ChangePasswordScreen()),
                    );
                  },
                ),

                _divider(),

                CustomText(
                  textIconPath: 'assets/images/ShieldSlash.svg',
                  text: "disabled_account".tr(),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    showDeactivatePopup(context, onConfirm: () async {
                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                      );

                      final success =
                      await DeactivateAccountService.deactivateAccount();

                      Navigator.pop(context);

                      if (success) {
                        await LocalStorage.clearAll();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                              (_) => false,
                        );
                      }
                    });
                  },
                ),
                _divider(),
                CustomText(
                  textIconPath: 'assets/images/deleteICon.svg',
                  text: "Delete Account".tr(),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    showDeletePopup(context, onConfirm: () async {

                      showDialog(
                        context: context,
                        barrierDismissible: false,
                        builder: (_) =>
                        const Center(child: CircularProgressIndicator()),
                      );

                      final success =
                      await DeleteAccountService.deleteAccount();

                      Navigator.pop(context);

                      if (success) {
                        await LocalStorage.clearAll();
                        Navigator.pushAndRemoveUntil(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginScreen()),
                              (_) => false,
                        );
                      }
                    });
                  },
                ),

              ],
            ),
          ),

          _sectionTitle("support_legal".tr(), w),

          _card(
            w,
            child: Column(
              children: [

                CustomText(
                  textIconPath: 'assets/images/money_back.svg',
                  text: "Money Back Policy",
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => MoneyBackPolicyScreen()),
                    );
                  },
                ),

                _divider(),

                CustomText(
                  textIconPath: 'assets/images/FileLock.svg',
                  text: "terms_of_service".tr(),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                          const TermsAndConditionsOfUseScreen()),
                    );
                  },
                ),

                _divider(),

                CustomText(
                  textIconPath: 'assets/images/subscription.svg',
                  text: "Subscription Terms",
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) =>
                          const SubscriptionTermsScreen()),
                    );
                  },
                ),

                _divider(),

                CustomText(
                  textIconPath: 'assets/images/Warning.svg',
                  text: "privacy_policy".tr(),
                  trailingIcon: Icons.arrow_forward_ios,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (_) => PrivacyPolicyScreen()),
                    );
                  },
                ),
              ],
            ),
          ),

          _card(
            w,
            child: GestureDetector(
              onTap: () async {
                final email = await LocalStorage.getEmail();
                final token = await LocalStorage.getToken();

                if (email != null && token != null) {
                  await AuthService().logOut(email: email);
                  await LocalStorage.clearAll();
                  Navigator.pushAndRemoveUntil(
                    context,
                    MaterialPageRoute(builder: (_) => const LoginScreen()),
                        (_) => false,
                  );
                }
              },
              child: Row(
                children: [
                  const Icon(Icons.logout, color: Color(0xff83BF8B)),
                  SizedBox(width: w * 0.03),
                  Text("logout".tr(), style: const TextStyle(fontSize: 14)),
                  const Spacer(),
                  const Icon(Icons.arrow_forward_ios,
                      size: 16, color: Color(0xff83BF8B)),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
  Widget _sectionTitle(String text, double w) {
    return Padding(
      padding: EdgeInsets.fromLTRB(w * 0.05, 20, 0, 10),
      child: Text(
        text,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _card(double w, {required Widget child}) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: w * 0.04, vertical: 6),
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: const Color(0xffFCFAF9),
        borderRadius: BorderRadius.circular(24),
        border: Border.all(color: const Color(0xffDAD6D6)),
      ),
      child: child,
    );
  }

  Widget _subText(String text) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, top: 4),
      child: Text(text,
          style: const TextStyle(fontSize: 12, color: Colors.grey)),
    );
  }

  Widget _divider() {
    return const Padding(
      padding: EdgeInsets.symmetric(vertical: 8),
      child: Divider(height: 1),
    );
  }

}