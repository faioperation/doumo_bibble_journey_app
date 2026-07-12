import 'dart:async';
import 'package:app_links/app_links.dart';
import 'package:bible_journey/app/routes.dart';
import 'package:bible_journey/features/Profile/screens/profile_screen.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import '../main.dart';
import '../core/services/local_storage_service.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final AppLinks _appLinks = AppLinks();
  StreamSubscription<Uri>? _linkSub;

  @override
  void initState() {
    super.initState();
    _listenDeepLinks();
  }

  void _listenDeepLinks() {
    _linkSub = _appLinks.uriLinkStream.listen(
          (Uri uri) {
        debugPrint('Deep link received: $uri');
        _handleDeepLink(uri);
      },
      onError: (error) {
        debugPrint('Deep link error: $error');
      },
    );
  }

  void _handleDeepLink(Uri uri) {
    if (uri.scheme == 'biblejourney' &&
        uri.host == 'payment-success') {

     // final String? orderId = uri.queryParameters['order_id'];

      Future.microtask(() {
        navigatorKey.currentState?.pushAndRemoveUntil(MaterialPageRoute(builder: (context)=>ProfileScreen()), (predicate)=>false);
      });
    }
  }

  @override
  void dispose() {
    _linkSub?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,

      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,

      // Routing
      onGenerateRoute: AppRoutes.generateRoute,
      initialRoute: AppRoutes.splash, // Splash screen will handle routing logic
    );
  }
}


