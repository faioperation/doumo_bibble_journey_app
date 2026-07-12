import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/features/home/screen/home_screen.dart';
import 'package:bible_journey/main_bottom_nav_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import '../../../widgets/custom_nav_bar.dart';
import '../../Profile/screens/profile_screen.dart';
import '../../journeys/screens/journey_screen.dart';
import '../widgets/book_section.dart';
import '../widgets/old_new_testiment_section.dart';
import 'package:flutter/material.dart';

class BibleScreen extends StatefulWidget {
  const BibleScreen({super.key});

  @override
  State<BibleScreen> createState() => _BibleScreenState();
}

class _BibleScreenState extends State<BibleScreen> {
  bool isOld = true;

  @override
  void initState() {
    super.initState();
    debugPrint("OPENED: Bible Screen");
  }


  final Map<String, CollapseController> controllers = {};

  @override
  Widget build(BuildContext context) {
    int _selectedIndex = 1;
    final data = isOld ? oldTestamentSections : newTestamentSections;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      appBar: AppBar(
        backgroundColor: AppColors.bgColor,
        scrolledUnderElevation: 0,
        title: Text(isOld ? "testaments.old".tr() : "testaments.new".tr()),
        centerTitle: true,
        automaticallyImplyLeading: false,
        // leading: IconButton(
        //   icon: const Icon(Icons.arrow_back, color: Colors.black),
        //   onPressed: () {
        //     Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (context)=>HomeScreen()), (pred)=>false);
        //     // Navigator.push(
        //     //   context,
        //     //   MaterialPageRoute(builder: (context) => const HomeScreen()),
        //     //);
        //   },
        // ),
        elevation: 0,
      ),

      body: SingleChildScrollView(
        child: Column(
          children: [

            buildTestamentToggle(),

            for (var section in data.keys)
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(section,
                        style: const TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600)),
                    const SizedBox(height: 8),

                    ...data[section]!.map((book) {
                      controllers.putIfAbsent(section, () => CollapseController());
                      return BookSection(
                        book: book,
                        controller: controllers[section]!,
                      );
                    }).toList()
                  ],
                ),
              )
          ],
        ),
      ),
    );
  }

  Widget buildTestamentToggle() {
    return Container(
      margin: const EdgeInsets.all(20),
      padding: const EdgeInsets.all(5),
      height: 45,
      decoration: BoxDecoration(
        color: const Color(0xffE5EDE8),
        borderRadius: BorderRadius.circular(30),
      ),
      child: Row(
        children: [
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() {
                isOld = true;
                controllers.clear();
              }),
              child: Container(
                decoration: BoxDecoration(
                  color: isOld ? const Color(0xff83BF8B) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text("testaments.old".tr(),
                    style: TextStyle(
                        color: isOld ? Colors.white : Colors.black)),
              ),
            ),
          ),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() {
                isOld = false;
                controllers.clear();
              }),
              child: Container(
                decoration: BoxDecoration(
                  color: !isOld ? const Color(0xff83BF8B) : Colors.transparent,
                  borderRadius: BorderRadius.circular(30),
                ),
                alignment: Alignment.center,
                child: Text("testaments.new".tr(),
                    style: TextStyle(
                        color: !isOld ? Colors.white : Colors.black)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
