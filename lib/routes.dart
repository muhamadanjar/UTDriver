import 'package:flutter/material.dart';
import 'package:ut_driver_app/screens/home/splash_screen.dart';
import 'package:ut_driver_app/screens/login/login_screen.dart';
import 'package:ut_driver_app/screens/home/map_screen.dart';
import 'package:ut_driver_app/screens/home/index_screen.dart';
import 'package:ut_driver_app/screens/topup/topup_screen.dart';
import 'package:ut_driver_app/screens/home/notifications.dart';
import 'package:ut_driver_app/screens/home/earnings.dart';
import 'package:ut_driver_app/screens/home/earnings_details.dart';
import 'package:ut_driver_app/screens/home/recent_transactions.dart';
import 'package:ut_driver_app/screens/global/notfound.dart';
import 'package:ut_driver_app/utils/constans.dart';



class Router {
  static Route<dynamic> generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case RoutePaths.Login:
        return MaterialPageRoute(builder: (_) => LoginScreen());
      case RoutePaths.Home:
        return MaterialPageRoute(builder: (_) => IndexHome());
      case RoutePaths.Notifications:
        return MaterialPageRoute(builder: (_) => NotificationsPage());
      case RoutePaths.RecentTransaction:
        return MaterialPageRoute(builder: (_) => RecentTransactionsPage());
      case RoutePaths.EarningDetail:
        return MaterialPageRoute(builder: (_) => EarningsDetailsPage());
      case RoutePaths.Earning:
        return MaterialPageRoute(builder: (_) => EarningsPage());
      case RoutePaths.Map:
        return MaterialPageRoute(builder: (_) => MapScreen());
      case RoutePaths.Splash:
        return MaterialPageRoute(builder: (_) => SplashScreen());
      case RoutePaths.Topup:
        return MaterialPageRoute(builder: (_) => TopupScreen());
      default:
        print(settings.name);
        return MaterialPageRoute(builder: (_) => NotFoundPage());
    }
  }
}