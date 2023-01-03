import 'dart:async';

import 'package:app_shipper/components/loading_widget.dart';
import 'package:app_shipper/core/auth_provider.dart';
import 'package:app_shipper/core/constants/color_constants.dart';
import 'package:app_shipper/core/constants/size_constants.dart';
import 'package:app_shipper/screens/home/home_screen.dart';
import 'package:app_shipper/screens/sign_in/sign_in_screen.dart';
import 'package:app_shipper/services/local_notification_service.dart';
import 'package:app_shipper/services/notification.dart';
import 'package:app_shipper/services/share_preferences_service.dart';
import 'package:app_shipper/size_config.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  static String routeName = "/splash";

  const SplashScreen({Key? key}) : super(key: key);

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  bool _visible = false;
  late AnimationController animationController;
  Animation<double>? animation;
  final _prefs = PreferencesService();

  startTime() async {
    Duration _duration = const Duration(seconds: 2);
    return Timer(_duration, () => Navigator.pushReplacementNamed(context, SignInScreen.routeName));
  }

  @override
  void initState() {
    super.initState();
    animationController =
        AnimationController(vsync: this, duration: Duration(seconds: 1));
    animation =
        CurvedAnimation(parent: animationController, curve: Curves.easeOut);

    animation!.addListener(() => setState(() {}));
    animationController.forward();

    startTime();

    LocalNotificationService.initialize(context);

    final firebaseMessaging = FCM();
    firebaseMessaging.setNotifications();
    firebaseMessaging.getToken();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kWhiteColor,
      body: Stack(
        fit: StackFit.expand,
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.end,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              _visible
                  ? const LoadingWidget(color: kWhiteColor)
                  : const SizedBox(),
            ],
          ),
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Image.asset(
                'assets/images/logo_app.png',
                width: animation!.value * 250,
                height: animation!.value * 250,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
