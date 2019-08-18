import 'package:flutter/material.dart';
import 'package:ut_driver_app/routes.dart';
import 'package:ut_driver_app/screens/home/index_screen.dart';
import 'package:ut_driver_app/screens/home/splash_screen.dart';
import 'package:ut_driver_app/screens/login/login_screen.dart';
import 'package:ut_driver_app/utils/constans.dart';
import 'package:provider/provider.dart';
import 'data/bloc/auth_bloc.dart';
import 'provider_setup.dart';
void main() => runApp(MyApp());
class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: providers,
      child: Consumer<AuthBloc>(
          builder:(ctx,auth,_){ 
            return MaterialApp(
            title: 'Driver Utama Trans',
            theme: ThemeData(
              primarySwatch: Colors.blue,
              fontFamily: 'Montserrat'
            ),
            home: auth.isAuth ? IndexHome()
                  : FutureBuilder(
                      future: auth.tryAutoLogin(),
                      builder: (ctx, authResultSnapshot) => authResultSnapshot.connectionState == ConnectionState.waiting ? SplashScreen(): LoginScreen(),
                    ),
            onGenerateRoute: Router.generateRoute,
          );},
      ),
    );
  }
}
