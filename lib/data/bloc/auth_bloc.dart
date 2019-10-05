import 'dart:convert';
import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:http/http.dart' as http;
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ut_driver_app/models/job.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:ut_driver_app/utils/constans.dart';

import '../../models/http_exception.dart';

class AuthBloc with ChangeNotifier {
  String _token;
  DateTime _expiryDate;
  String _userId;
  Timer _authTimer;
  User _authenticatedUser;
  Position userPosition;
  Job job;
  PublishSubject<bool> _userSubject = PublishSubject();
  bool get isAuth {
    return token != null;
  }

  PublishSubject<bool> get userSubject {
    return _userSubject;
  }
  User get user{
    return _authenticatedUser;
  }

  String get token {
    if (_expiryDate != null &&
        _expiryDate.isAfter(DateTime.now()) &&
        _token != null) {
      return _token;
    }
    return null;
  }

  String get userId {
    return _userId;
  }
  // User get user{ return _authenticatedUser;}

  Future<void> _authenticate(String email, String password, String urlSegment) async {
    final url = '${apiURL}/login';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'username': email,
            'password': password,
            'returnSecureToken': true,
          },
        ),
        headers: {'Content-Type': 'application/json'},
      );
      final responseData = json.decode(response.body);
      print(responseData);
      if (responseData['status'] == false) {
        throw HttpException(responseData['message']);
      }
      _token = responseData['data']['token'];
      _userId = "responseData['localId']";
      _expiryDate = DateTime.now().add(
        Duration(
          seconds: responseData['expiresIn'] != null ? responseData['expiresIn']:int.parse("3600"),
        ),
      );
      _autoLogout();
      notifyListeners();
      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode(
        {
          'token': _token,
          'userId': _userId,
          'expiryDate': _expiryDate.toIso8601String(),
        },
      );
      prefs.setString('userData', userData);
    } catch (error) {
      throw error;
    }
  }

  Future<void> signup(String email, String password) async {
    return _authenticate(email, password, 'signupNewUser');
  }

  Future<void> login(String email, String password) async {
    return _authenticate(email, password, 'verifyPassword');
  }

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
    final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

    if (expiryDate.isBefore(DateTime.now())) {
      return false;
    }
    _token = extractedUserData['token'];
    _userId = extractedUserData['userId'];
    _expiryDate = expiryDate;
    notifyListeners();
    _autoLogout();
    return true;
  }

  Future<void> logout() async {
    _token = null;
    _userId = null;
    _expiryDate = null;
    if (_authTimer != null) {
      _authTimer.cancel();
      _authTimer = null;
    }
    
    final prefs = await SharedPreferences.getInstance();
    prefs.remove('userData');
    prefs.clear();
    notifyListeners();
  }

  void _autoLogout() {
    if (_authTimer != null) {
      _authTimer.cancel();
    }
    final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
    _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
  }

  Future getUser() async {
        final prefs = await SharedPreferences.getInstance();
        if (!prefs.containsKey('userData')) {
          return false;
        }
        final extractedUserData = json.decode(prefs.getString('userData')) as Map<String, Object>;
        final expiryDate = DateTime.parse(extractedUserData['expiryDate']);

        if (expiryDate.isBefore(DateTime.now())) {
          return false;
        }
        _token = extractedUserData['token'];
        _userId = extractedUserData['userId'];

        var data = {'token':token};
        var headers = {
          'Accept': 'application/json',
          'Authorization': 'Bearer ${_token}',
        };
        final response = await http.post("${apiURL}/user/details",body: json.encode(data),headers:headers);
        final responseData = json.decode(response.body);
        _authenticatedUser= User(name:responseData['data']['name'],email: responseData['data']['email'],photoUrl: responseData['data']['foto'],saldo: responseData['data']['wallet'],rating: responseData['data']['rate']);
        notifyListeners();
        print("print response data ${responseData['data']}");
  }
  Future updatePosition(Position position) async{
      try {
        var url = "${apiURL}/user/update_position";
        var formData = {
          'latitude': position.latitude.toString(),
          'longitude': position.longitude.toString(),
          'latest_update': new DateTime.now().toString()
        };
        var headers = {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',
        };
        final response = await http.post(url,
          body: json.encode(formData),
          headers: headers,
        );
        final responseData = json.decode(response.body);
        userPosition = position;
        notifyListeners();
      } catch (e) {
        print('Error Position :'+ e.toString());
      }
  }


  Future updateStatus(bool status) async{
    var data = status ? 1:0;
    try {
      final response = await http.post("${apiURL}/user/changeonline",body: json.encode({
        'online':data
      }),headers: {'Accept': 'application/json',
          'Content-Type': 'application/json',
          'Authorization': 'Bearer ${token}',});
      final responseData = json.decode(response.body);
      
    } catch (e) {
    }
  }
}
