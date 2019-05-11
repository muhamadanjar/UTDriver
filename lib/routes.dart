import 'package:flutter/material.dart';
import 'package:ut_driver_app/screens/home/home_screen.dart';
import 'package:ut_driver_app/screens/login/login_screen.dart';

final routes = {
  '/login':         (BuildContext context) => new LoginScreen(),
  '/home':         (BuildContext context) => new HomeScreen(),
  '/' :          (BuildContext context) => new LoginScreen(),
};