import 'dart:convert';
import 'package:bible_journey/app/constants.dart';
import 'package:bible_journey/features/devotions/screens/daily_devotion_screen.dart';
import 'package:bible_journey/features/home/screen/notification_screen.dart';
import 'package:bible_journey/features/prayer/screens/prayer_screen.dart';
import 'package:bible_journey/features/todays_actions/screens/todays_action_screen.dart';
import 'package:bible_journey/widgets/buttons/custom_button.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:http/http.dart' as http;
import '../../../app/Urls.dart';
import '../../../core/services/api_service.dart';
import '../../../core/services/local_storage_service.dart';
import '../widgets/home_box.dart';
import 'package:bible_journey/main_bottom_nav_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  Map<String, dynamic>? userData;
  bool isUserLoading = true;

  Map<String, dynamic>? todayPrayer;
  Map<String, dynamic>? todayDevotion;
  Map<String, dynamic>? todayAction;

  bool isTodayLoading = true;
  int unreadCount = 0;

  @override
  void initState() {
    super.initState();
    loadUser();
    loadHomeData();
    loadUnreadNotifications();
    debugPrint("OPENED: Home Screen");
  }

  Future<void> loadUser() async {
    try {
      final data = await ApiServices.getProfile();
      if (!mounted) return;
      setState(() {
        userData = data;
        isUserLoading = false;
      });
    } catch (_) {
      if (!mounted) return;
      setState(() => isUserLoading = false);
    }
  }

  Future<Map<String, dynamic>?> loadTodayStep(String step) async {
    try {
      final token = await LocalStorage.getToken();
      if (token == null || token.isEmpty) return null;

      final response = await http.get(
        Uri.parse("${Urls.baseUrl}/progress/today/$step"),
        headers: {
          "Authorization": "Bearer $token",
          "Accept": "application/json",
        },
      );

      if (response.statusCode == 200) {
        return jsonDecode(response.body);
      }
    } catch (_) {}
    return null;
  }

  Future<void> loadHomeData() async {
    final prayer = await loadTodayStep("prayer");
    final devotion = await loadTodayStep("devotion");
    final action = await loadTodayStep("action");

    if (!mounted) return;

    setState(() {
      todayPrayer = prayer;
      todayDevotion = devotion;
      todayAction = action;
      isTodayLoading = false;
    });
  }

  Future<void> loadUnreadNotifications() async {
    try {
      final token = await LocalStorage.getToken();
      final response = await http.get(
        Uri.parse('${Urls.baseUrl}/notifications/'),
        headers: {
          'Authorization': 'Bearer $token',
          'Content-Type': 'application/json',
        },
      );

      if (!mounted) return;

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() => unreadCount = data['unread_message'] ?? 0);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final bottomNavState =
    context.findAncestorStateOfType<MainBottomNavScreenState>();

    final width = MediaQuery.of(context).size.width;
    final height = MediaQuery.of(context).size.height;

    return Scaffold(
      backgroundColor: AppColors.bgColor,
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(width * .04),
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: Text(
                      isUserLoading
                          ? "Hello,"
                          : "Hello, ${userData?['name'] ?? ''}",
                      style: TextStyle(
                        fontSize: width * .045,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                  Stack(
                    children: [
                      IconButton(
                        icon: const Icon(Icons.notifications_none),
                        onPressed: () async {
                          await Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (_) => NotificationScreen(),
                            ),
                          );
                          loadUnreadNotifications();
                        },
                      ),
                      if (unreadCount > 0)
                        Positioned(
                          right: 6,
                          top: 6,
                          child: CircleAvatar(
                            radius: 9,
                            backgroundColor: Colors.red,
                            child: Text(
                              unreadCount.toString(),
                              style: const TextStyle(
                                fontSize: 11,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        ),
                    ],
                  ),
                ],
              ),

              SizedBox(height: height * .02),

              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      GridView.count(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        crossAxisCount: 2,
                        crossAxisSpacing: width * .05,
                        mainAxisSpacing: height * .015,
                        childAspectRatio: 1.1,
                        children: [
                          HomeBox(
                            icon: SvgPicture.asset(
                              "assets/images/Vector (3).svg",
                              color: Colors.green,
                            ),
                            title: "Daily Prayer",
                            subtitle: "Start your day with a guided prayer.",
                            onTap: () {
                              if (isTodayLoading || todayPrayer == null) return;

                              //bottomNavState?.goToTab(2);
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => PrayerScreen(
                                    journeyId:
                                    todayPrayer!['journey']['id'],
                                    dayId: todayPrayer!['day']['id'],
                                  ),
                                ),
                              );

                            },
                          ),

                          HomeBox(
                            icon: SvgPicture.asset(
                              "assets/images/Vector (1).svg",
                              color: Colors.green,
                            ),
                            title: "Daily Devotion",
                            subtitle: "Reflect on today's scripture.",
                            onTap: () {
                              if (isTodayLoading || todayDevotion == null) {
                                return;
                              }

                              //bottomNavState?.goToTab(2);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => DailyDevotionScreen(
                                    journeyId:
                                    todayDevotion!['journey']['id'],
                                    dayId: todayDevotion!['day']['id'],
                                  ),
                                ),
                              );
                            },
                          ),

                          HomeBox(
                            icon: SvgPicture.asset(
                              "assets/images/Vector (4).svg",
                              color: Colors.green,
                            ),
                            title: "Today's Actions",
                            subtitle: "Small tasks to grow faith.",
                            onTap: () {
                              if (isTodayLoading || todayAction == null) return;

                              //bottomNavState?.goToTab(2);

                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (_) => TodayActionScreen(
                                    journeyId:
                                    todayAction!['journey']['id'],
                                    dayId: todayAction!['day']['id'],
                                  ),
                                ),
                              );
                            },
                          ),

                          HomeBox(
                            icon: SvgPicture.asset(
                              "assets/images/Vector (3).svg",
                              color: Colors.green,
                            ),
                            title: "Begin a Journey",
                            subtitle: "Explore journeys",
                            onTap: () {
                              bottomNavState?.goToTab(2);
                            },
                          ),
                        ],
                      ),
                  Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(16),
                        ),
                        padding: EdgeInsets.all(width * 0.04),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.asset(
                                "assets/images/home_img.jpg",
                                height: height * 0.20,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                            ),
                            SizedBox(height: height * 0.02),
                            Text(
                              "Explore Life Journeys",
                              style: TextStyle(
                                fontSize: width * 0.055,
                                fontWeight: FontWeight.w600,
                              ),
                            ),
                            SizedBox(height: height * 0.01),
                            Text(
                              "Find guidance on topics like gratitude, patience, or purpose.",
                              style: TextStyle(
                                fontSize: width * 0.035,
                                color: Colors.grey.shade600,
                              ),
                            ),
                  ]
                        ),
                        ),

                      SizedBox(height: height * .03),

                      CustomButton(
                        text: "view_all_journeys".tr(),
                        onTap: () {
                          bottomNavState?.goToTab(2);
                        },
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
