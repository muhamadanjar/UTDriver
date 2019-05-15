import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:local_auth/local_auth.dart';
import 'package:native_widgets/native_widgets.dart';
import 'package:scoped_model/scoped_model.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ut_driver_app/utils/webclient.dart';
import 'package:uuid/uuid.dart';

import 'package:ut_driver_app/utils/constans.dart';
import 'package:ut_driver_app/models/UserLogin.dart';
import 'package:ut_driver_app/utils/network_util.dart';

class AuthModel extends Model {
  String errorMessage = "";

  bool _rememberMe = false;
  bool _stayLoggedIn = true;
  bool _useBio = false;
  UserLogin _user;

  bool get rememberMe => _rememberMe;

  void handleRememberMe(bool value) {
    _rememberMe = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("remember_me", value);
    });
  }

  bool get isBioSetup => _useBio;

  void handleIsBioSetup(bool value) {
    _useBio = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("use_bio", value);
    });
  }

  bool get stayLoggedIn => _stayLoggedIn;

  void handleStayLoggedIn(bool value) {
    _stayLoggedIn = value;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setBool("stay_logged_in", value);
    });
  }

  void loadSettings() async {
    var _prefs = await SharedPreferences.getInstance();
    try {
      _useBio = _prefs.getBool("use_bio") ?? false;
    } catch (e) {
      print(e);
      _useBio = false;
    }
    try {
      _rememberMe = _prefs.getBool("remember_me") ?? false;
    } catch (e) {
      print(e);
      _rememberMe = false;
    }
    try {
      _stayLoggedIn = _prefs.getBool("stay_logged_in") ?? false;
    } catch (e) {
      print(e);
      _stayLoggedIn = false;
    }

    if (_stayLoggedIn) {
      UserLogin _savedUser;
      try {
        String _saved = _prefs.getString("user_data");
        print("Saved: $_saved");
        _savedUser = UserLogin.fromJson(json.decode(_saved));
      } catch (e) {
        print("User Not Found: $e");
      }
      if (_useBio) {
        if (await biometrics()) {
          _user = _savedUser;
        }
      } else {
        _user = _savedUser;
      }
    }
    notifyListeners();
  }

  Future<bool> biometrics() async {
    final LocalAuthentication auth = LocalAuthentication();
    bool authenticated = false;
    try {
      authenticated = await auth.authenticateWithBiometrics(
          localizedReason: 'Scan your fingerprint to authenticate',
          useErrorDialogs: true,
          stickyAuth: false);
    } catch (e) {
      print(e);
    }
    return authenticated;
  }

  UserLogin get user => _user;

  Future<UserLogin> getInfo(String token) async {
    try {
      var _data = await WebClient(UserLogin(token: token)).get(apiURL);
      // var _json = json.decode(json.encode(_data));
      var _newUser = UserLogin.fromJson(_data["data"]);
      _newUser?.token = token;
      return _newUser;
    } catch (e) {
      print("Could Not Load Data: $e");
      return null;
    }
  }

  Future<bool> login({
    @required String username,
    @required String password,
  }) async {
    var uuid = new Uuid();
    String _username = username;
    String _password = password;

    // TODO: API LOGIN CODE HERE
    await Future.delayed(Duration(seconds: 3));
    print("Logging In => $_username, $_password");

    if (_rememberMe) {
      SharedPreferences.getInstance().then((prefs) {
        prefs.setString("saved_username", _username);
      });
    }

    // Get Info For User
    UserLogin _newUser = await getInfo(uuid.v4().toString());
    if (_newUser != null) {
      _user = _newUser;
      notifyListeners();

      SharedPreferences.getInstance().then((prefs) {
        var _save = json.encode(_user.toJson());
        print("Data: $_save");
        prefs.setString("user_data", _save);
      });
    }

    if (_newUser?.token == null || _newUser.token.isEmpty) return false;
    return true;
  }

  Future<void> logout() async {
    _user = null;
    notifyListeners();
    SharedPreferences.getInstance().then((prefs) {
      prefs.setString("user_data", null);
    });
    return;
  }
}
