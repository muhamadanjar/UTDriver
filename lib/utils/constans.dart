import 'package:flutter/widgets.dart';

enum AlertAction {
  cancel,
  discard,
  disagree,
  agree,
}

const bool devMode = false;
const String apiURL = devMode == false ? "http://utama-trans.com/new/api":"http://192.168.43.110/api";
const double textScaleFactor = 1.0;

class SizeConfig{
  static MediaQueryData _mediaQueryData;
  static double screenWidth;
  static double screenHeight;
  static double blockWidth;
  static double blockHeight;

  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockWidth = screenWidth / 100;
    blockHeight = screenHeight / 100;

  }
}

class RoutePaths {
  static const String Login = 'login';
  static const String Register = 'register';
  static const String Home = 'home';
  static const String Settings = 'settings';
  static const String Forgot = 'forgot';
  static const String Legal = 'legal';
  static const String Profile = 'profile';
  static const String Notifications = 'notifications';
  static const String ChangePassword = 'change_password';
  static const String ChangeProfile = 'change_profile';
  static const String Splash = 'splash';
  static const String Map = 'map';
  static const String Earning = 'earning';
  static const String EarningDetail = 'earningdetail';
  static const String RecentTransaction = 'earningdetail';
  static const String Topup = 'topup';


}