import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../widgets/custom_language.dart';

class LanguageScreen extends StatefulWidget {
  const LanguageScreen({super.key});

  @override
  State<LanguageScreen> createState() => _LanguageScreenState();
}

class _LanguageScreenState extends State<LanguageScreen> {
  Locale selectedLocale = const Locale('en');

  @override
  void initState() {
    super.initState();
    loadLocale();
  }

  Future<void> saveLocale(Locale locale) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('language_code', locale.languageCode);
  }

  Future<void> loadLocale() async {
    final prefs = await SharedPreferences.getInstance();
    final code = prefs.getString('language_code') ?? 'en';
    setState(() {
      selectedLocale = Locale(code);
    });
    context.setLocale(selectedLocale);
  }

  void changeLanguage(Locale locale) {
    setState(() {
      selectedLocale = locale;
    });
    context.setLocale(locale);
    saveLocale(locale);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF8F5F2),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF8F5F2),
        title:  Text("change_language".tr()),
        centerTitle: true,
        elevation: 0,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 10),

            CustomLanguage(
              imagePath: "assets/images/US.svg",
              isSvg: true,
              title: "English (US)",
              isSelected: selectedLocale == const Locale('en'),
              onTap: () => changeLanguage(const Locale('en')),
            ),
            const SizedBox(height: 10),

            CustomLanguage(
              imagePath: "assets/images/spanish.png",
              //isSvg: true,
              title: "Spanish",
              isSelected: selectedLocale == const Locale('es'),
              onTap: () => changeLanguage(const Locale('es')),
            ),
            const SizedBox(height: 10),

            CustomLanguage(
              imagePath: "assets/images/Italian.png",
              //isSvg: true,
              title: "Italian",
              isSelected: selectedLocale == const Locale('it'),
              onTap: () => changeLanguage(const Locale('it')),
            ),
            const SizedBox(height: 10),

            CustomLanguage(
              //svgAssetPath: "assets/images/germanyflagsvg.svg",
              imagePath: "assets/images/germany flag svg.png",
              title: "German",
              isSelected: selectedLocale == const Locale('de'),
              onTap: () => changeLanguage(const Locale('de')),
            ),
            const SizedBox(height: 10),

            CustomLanguage(
              imagePath: "assets/images/French.png",
              //isSvg: true,
              title: "French",
              isSelected: selectedLocale == const Locale('fr'),
              onTap: () => changeLanguage(const Locale('fr')),
            ),
            const SizedBox(height: 10),

            CustomLanguage(
              //svgAssetPath: "assets/images/portugueseflag.svg",
              imagePath: "assets/images/portuguese flag.png",
              title: "Portuguese",
              isSelected: selectedLocale == const Locale('pt'),
              onTap: () => changeLanguage(const Locale('pt')),
            ),
            const SizedBox(height: 115),
          ],
        ),
      ),
    );
  }
}
