import 'package:app_shipper/core/auth_provider.dart';
import 'package:app_shipper/routes.dart';
import 'package:app_shipper/screens/add_confirm/provider/add_confirm_provider.dart';
import 'package:app_shipper/screens/add_confirm_household_garbase/provider/card_organic_provider.dart';
import 'package:app_shipper/screens/dashboard/activities/provider/activities_provider.dart';
import 'package:app_shipper/screens/dashboard/home/provider/home_page_provider.dart';
import 'package:app_shipper/screens/dashboard/tracking/provider/tracking_provider.dart';
import 'package:app_shipper/screens/home/provider/home_provider.dart';
import 'package:app_shipper/screens/learderboard/provider/leaderboard_provider.dart';
import 'package:app_shipper/screens/splash/splash_screen.dart';
import 'package:app_shipper/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

final FlutterLocalNotificationsPlugin localNotifications =
FlutterLocalNotificationsPlugin();
// Uses rxdart/subjects to trigger showing a different page in your app from an async handler
final StreamController<String> selectNotificationSubject =
StreamController<String>();

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print(message.data.toString());
  print(message.notification!.title);
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  await init();
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(create: (_) => AuthProvider()),
      ChangeNotifierProvider(create: (_) => HomeProvider()),
      ChangeNotifierProvider(create: (_) => AddConfirmProvider()),
      ChangeNotifierProvider(create: (_) => CardOrganicProvider()),
      ChangeNotifierProvider(create: (_) => LeaderBoardProvider()),
      ChangeNotifierProvider(create: (_) => HomePageProvider()),
      ChangeNotifierProvider(create: (_) => TrackingProvider()),
      ChangeNotifierProvider(create: (_) => ActivitiesProvider()),
    ],
    child: const MyApp(),
  ));
}

Future init() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // navigatorKey: navigatorKey,
      debugShowCheckedModeBanner: false,
      title: 'RecycleDriver',
      theme: theme(),
      initialRoute: SplashScreen.routeName,
      routes: routes,
    );
  }
}
