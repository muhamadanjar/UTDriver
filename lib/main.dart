import 'package:flutter/material.dart';
import 'package:ut_driver_app/routes.dart';
import 'package:ut_driver_app/utils/constans.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Driver Utama Trans',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: RoutePaths.Login,
      onGenerateRoute: Router.generateRoute,

    );
  }
}
