
import 'package:flutter/material.dart';
import 'package:bible_journey/features/home/screen/home_screen.dart';
import 'package:bible_journey/features/bible/screens/bible_screen.dart';
import 'package:bible_journey/features/journeys/screens/journey_screen.dart';
import 'package:bible_journey/features/Profile/screens/profile_screen.dart';
import 'package:bible_journey/widgets/custom_nav_bar.dart';
import 'package:flutter/services.dart';
import 'package:bible_journey/core/services/local_storage_service.dart';
import 'package:bible_journey/app/routes.dart';

class MainBottomNavScreen extends StatefulWidget {
  const MainBottomNavScreen({super.key});

  @override
  State<MainBottomNavScreen> createState() => MainBottomNavScreenState();
}

class MainBottomNavScreenState extends State<MainBottomNavScreen> {
  int currentIndex = 0;

  final GlobalKey<NavigatorState> _journeyNavigatorKey =
  GlobalKey<NavigatorState>();

  @override
  void initState() {
    super.initState();
    _checkAuthentication();
  }

  void _checkAuthentication() async {
    final token = await LocalStorage.getToken();
    if (token == null || token.isEmpty) {
      if (mounted) {
        Navigator.pushReplacementNamed(context, AppRoutes.splash);
      }
    }
  }

  void goToTab(int index) {
    setState(() => currentIndex = index);
  }

  NavigatorState? get journeyNavigator =>
      _journeyNavigatorKey.currentState;

  void _onTap(int index) {
    if (index == currentIndex) return;
    setState(() => currentIndex = index);
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String?>(
      future: LocalStorage.getToken(),
      builder: (context, snapshot) {
        if (snapshot.hasData && (snapshot.data == null || snapshot.data!.isEmpty)) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              Navigator.pushReplacementNamed(context, AppRoutes.splash);
            }
          });
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }
        
        return _buildMainScreen();
      },
    );
  }

  Widget _buildMainScreen() {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) {
        if (didPop) return;

        if (currentIndex == 2 &&
            _journeyNavigatorKey.currentState!.canPop()) {
          _journeyNavigatorKey.currentState!.pop();
          return;
        }

        if (currentIndex != 0) {
          setState(() => currentIndex = 0);
          return;
        }

        SystemNavigator.pop();
      },
      child: Scaffold(
        body: IndexedStack(
          index: currentIndex,
          children: [
            const HomeScreen(),
            const BibleScreen(),

            Navigator(
              key: _journeyNavigatorKey,
              onGenerateRoute: (_) =>
                  MaterialPageRoute(builder: (_) => const JourneyScreen()),
            ),

            const ProfileScreen(),
          ],
        ),
        bottomNavigationBar: CustomNavbar(
          currentIndex: currentIndex,
          onItemPressed: _onTap,
        ),
      ),
    );
  }
}
