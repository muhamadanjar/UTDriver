import 'package:flutter/material.dart';
// import 'package:ut_driver_app/screens/home/home_screen.dart';
import 'package:ut_driver_app/screens/home/splash_screen.dart';
import 'package:ut_driver_app/screens/login/login_screen.dart';
import 'package:ut_driver_app/screens/home/map_screen.dart';
import 'package:ut_driver_app/screens/home/index_screen.dart';
import 'package:ut_driver_app/screens/topup/topup_screen.dart';
import 'package:ut_driver_app/screens/home/notifications.dart';
import 'package:ut_driver_app/screens/home/earnings.dart';
import 'package:ut_driver_app/screens/home/earnings_details.dart';
import 'package:ut_driver_app/screens/home/recent_transactions.dart';
final routes = {
  '/notifications': (context) => NotificationsPage(),
  '/earnings': (context) => EarningsPage(),
  '/earnings_details': (context) => EarningsDetailsPage(),
  '/recent_transations': (context) => RecentTransactionsPage(),
  '/topup':         (BuildContext context) => new TopupScreen(),
  '/map':         (BuildContext context) => new MapScreen(),
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new IndexHome(),
  '/' :          (BuildContext context) => new SplashScreen(),
};
class Mynav {
  static void goToHome(BuildContext context) {
    Navigator.pushNamed(context, "/home");
  }

  static void goToIntro(BuildContext context) {
    Navigator.pushReplacementNamed(context, "/login");
  }

  static void goToMap(BuildContext context){
    Navigator.pushNamed(context, '/map');
  }
}