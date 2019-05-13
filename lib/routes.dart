import 'package:flutter/material.dart';
import 'package:ut_driver_app/screens/home/home_screen.dart';
import 'package:ut_driver_app/screens/home/splash_screen.dart';
import 'package:ut_driver_app/screens/login/login_screen.dart';
import 'package:ut_driver_app/screens/home/map_screen.dart';
final routes = {
  '/map':         (BuildContext context) => new MapScreen(),
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new HomeScreen(),
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