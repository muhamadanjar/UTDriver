
import 'dart:async';
import 'dart:convert';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ut_driver_app/data/database_helper.dart';
import 'package:ut_driver_app/data/enum/authMode.dart';
import 'package:ut_driver_app/models/http_exception.dart';
import 'package:ut_driver_app/models/job.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:ut_driver_app/utils/constans.dart';
import '../../models/base_model.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
class AuthBloc extends BaseModel{
  DatabaseHelper _databaseHelper = new DatabaseHelper();
  RestDatasource _api;
  AuthBloc({RestDatasource api}):_api = api;  
  String _token;
  String _userId;
  Position userPosition;
  User _authenticatedUser;
  bool userStatus;
  Job job;
  Timer _authTimer;
  DateTime _expiryDate;
  PublishSubject<bool> _userSubject = PublishSubject();
  PublishSubject<User> _userDataSubject = PublishSubject();

      @override
      void dispose() {
        print("disposing auth");
        super.dispose();
      }
      bool get isAuth {
        return _token != null;
      }
      String get token {
        if (_expiryDate != null && _expiryDate.isAfter(DateTime.now()) && _token != null) {
          return _token;
        }
        return null;
      }
      User get user => _authenticatedUser;

      PublishSubject<bool> get userSubject {
        return _userSubject;
      }

      PublishSubject<User> get userDataSubject => _userDataSubject;
      Future getUser() async {
        setBusy(true);
        // var d = _databaseHelper.getClient(1);
        _api.getUser();
        setBusy(false);
      }
    
      Future updatePosition(Position position) async{
        try {
          setBusy(true);
          await _api.updateLocation(position.latitude.toString(), position.longitude.toString());
          userPosition = position;
          setBusy(false);
        } catch (e) {
          print('Error Position :'+ e);
        }
        
      }
    
      Future updateStatus(bool status) async{
        try{
          setBusy(true);
          _api.changeStatusOnline(status.toString());
          userStatus = status;
          setBusy(false);
    
        }catch (e){}
      }
    
      Future checkJob() async{
        try {
          print("checking job");
          await _api.checkJob();
        } catch (e) {
        }
      }

      Future<Map<String, dynamic>> authenticate(String email, String password,[AuthMode mode = AuthMode.Login]) async {
        final url = "${apiURL}/login";
        bool hasErrors = true;
        String message = 'Something went wrong.';
        try {
          final formData = json.encode(
              {
                'username': email,
                'password': password,
                'returnSecureToken': true,
              },
          );
          print(formData);
          final response = await http.post(url,
            body: formData,
            headers: {'Content-Type': 'application/json'},
          );
          final responseData = json.decode(response.body);
          print(responseData);
          if (responseData.containsKey('status') && responseData['status']) {
            message = 'Authentication succeeded!';
            hasErrors = false;
            _authenticatedUser = User(
              token: responseData['data']['token'],
              email: responseData['data']['user']['email']
            );
            _userDataSubject.add(_authenticatedUser);
            _token = responseData['token'];
            _userId = "responseData['localId']";
            _expiryDate = DateTime.now().add(
              Duration(
                seconds: responseData['expiresIn'] != null ? int.parse(responseData['expiresIn']):3600 ,
              ),
            );
            _autoLogout();
            notifyListeners();
            final prefs = await SharedPreferences.getInstance();
            final userData = json.encode({
              'token': _token,
              'userId': _userId,
              'expiryDate': _expiryDate.toIso8601String(),
            },);
            prefs.setString('userData', userData);
            return {'success':!hasErrors,'data':_authenticatedUser};    
          }
          
        } catch (e) {
        }
        
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
        notifyListeners();
        final prefs = await SharedPreferences.getInstance();
        // prefs.remove('userData');
        prefs.clear();
      }
      void _autoLogout() {
        if (_authTimer != null) {
          _authTimer.cancel();
        }
        final timeToExpiry = _expiryDate.difference(DateTime.now()).inSeconds;
        _authTimer = Timer(Duration(seconds: timeToExpiry), logout);
      }
      void setAuthTimeout(int time) {
        _authTimer = Timer(Duration(seconds: time), logout);
      }
    
}


