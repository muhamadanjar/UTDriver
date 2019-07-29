import 'package:flutter/material.dart';
import 'package:ut_driver_app/routes.dart';
import 'package:ut_driver_app/utils/constans.dart';
import 'package:provider/provider.dart';
import 'provider_setup.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: MaterialApp(
        title: 'Driver Utama Trans',
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        initialRoute: RoutePaths.Login,
        onGenerateRoute: Router.generateRoute,

      ),
    );
  }
}
