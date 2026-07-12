import 'package:bible_journey/core/services/api_service.dart';
import 'package:bible_journey/features/Profile/screens/edit_profile.dart';
import 'package:bible_journey/widgets/appbars/custom_appbar.dart';
import 'package:bible_journey/widgets/buttons/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../widgets/custom_personal.dart';

class ProfileDetails extends StatefulWidget {
  const ProfileDetails({super.key});

  @override
  State<ProfileDetails> createState() => _ProfileDetailsState();
}

class _ProfileDetailsState extends State<ProfileDetails> {
  Map<String, dynamic>? userData;
  bool isLoading = true;

  @override
  void initState() {
    super.initState();
    loadProfile();
  }

  Future<void> loadProfile() async {
    final data = await ApiServices.getProfile();
    setState(() {
      userData = data;
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final padding = size.width * 0.05;

    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),
      appBar: CustomAppBar(
        title: "profile_details".tr(),
        onTap: () {
          Navigator.pop(context);
        },
      ),
      body: isLoading
          ? const Center(child: CircularProgressIndicator())
          : SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: padding, vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Optional: Title Section
              // Center(
              //   child: Text(
              //     userData?["name"] ?? "",
              //     style: TextStyle(
              //       fontSize: size.width * 0.06, // responsive font
              //       fontWeight: FontWeight.bold,
              //       color: const Color(0xff83BF8B),
              //     ),
              //     textAlign: TextAlign.center,
              //   ),
              // ),
              const SizedBox(height: 60),

              CustomPersonal(
                textIcon: Icons.person,
                text: "FULL NAME",
                subText: userData?["name"] ?? "",
              ),
              const SizedBox(height: 16),

              CustomPersonal(
                textIcon: Icons.email,
                text: "YOUR EMAIL",
                subText: userData?["email"] ?? "",
              ),
              const SizedBox(height: 16),

              CustomPersonal(
                textIcon: Icons.date_range,
                text: "DATE OF BIRTH",
                subText: userData?["date_of_birth"] ?? "",
              ),
              const SizedBox(height: 16),

              CustomPersonal(
                textIcon: Icons.phone,
                text: "PHONE",
                subText: userData?["phone"] ?? "",
              ),
              const SizedBox(height: 16),

              CustomPersonal(
                textIcon: Icons.accessibility,
                text: "GENDER",
                subText: userData?["gender"] ?? "",
              ),
              const SizedBox(height: 80),

              Center(
                child: SizedBox(
                  width: double.infinity,
                  child: CustomButton(
                    text: "Edit",
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => EditProfileScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ),
              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
