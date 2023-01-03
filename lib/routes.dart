import 'package:app_shipper/screens/add_confirm/add_confirm_screen.dart';
import 'package:app_shipper/screens/add_confirm_household_garbase/add_confirm_household_garbase_screen.dart';
import 'package:app_shipper/screens/confirm_recycle/components/confirm_success.dart';
import 'package:app_shipper/screens/confirm_recycle/organic/create_confirm_organic.dart';
import 'package:app_shipper/screens/confirm_recycle/plastic/create_confirm_plastic.dart';
import 'package:app_shipper/screens/dashboard/activities/components/filter_calendar.dart';
import 'package:app_shipper/screens/dashboard/dashboard_screen.dart';
import 'package:app_shipper/screens/dashboard/tracking/detail_tracking/detail_booking_screen.dart';
import 'package:app_shipper/screens/home/home_screen.dart';
import 'package:app_shipper/screens/learderboard/leaderboard_screen.dart';
import 'package:app_shipper/screens/otp/otp_screen.dart';
import 'package:app_shipper/screens/sign_in/sign_in_screen.dart';
import 'package:app_shipper/screens/splash/splash_screen.dart';
import 'package:flutter/widgets.dart';

// We use name route
// All our routes will be available here
final Map<String, WidgetBuilder> routes = {
  SplashScreen.routeName: (context) => const SplashScreen(),
  SignInScreen.routeName: (context) => const SignInScreen(),
  OtpScreen.routeName: (context) => const OtpScreen(),
  HomeScreen.routeName: (context) => const HomeScreen(),
  AddConfirm.routeName: (context) => const AddConfirm(),
  AddConfirmHousehold.routeName: (context) => const AddConfirmHousehold(),
  LeaderboardScreen.routeName: (context) => const LeaderboardScreen(),
  DashBoardScreen.routeName: (context) => const DashBoardScreen(),
  CreateConfirmPlastic.routeName: (context) => const CreateConfirmPlastic(),
  CreateConfirmOrganic.routeName: (context) => const CreateConfirmOrganic(),
  ConfirmSuccess.routeName: (context) => const ConfirmSuccess(),
  FilterCalendar.routeName: (context) => const FilterCalendar(),
  DetailBookingScreen.routeName: (context) => const DetailBookingScreen(),
};
