
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/widgets.dart';
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ut_driver_app/data/database_helper.dart';
import 'package:ut_driver_app/data/enum/authMode.dart';
import 'package:ut_driver_app/models/job.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:ut_driver_app/utils/constans.dart';
import '../../models/base_model.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
class AuthBloc extends BaseModel{
  DatabaseHelper _databaseHelper = new DatabaseHelper();
  RestDatasource _api;
  AuthBloc({RestDatasource api}):_api = api;  
  Position userPosition;
  User _authenticatedUser;
  bool userStatus;
  Job job;
  Timer _authTimer;
  PublishSubject<bool> _userSubject = PublishSubject();
  PublishSubject<User> _userDataSubject = PublishSubject();

      @override
      void dispose() {
        print("disposing auth");
        super.dispose();
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
        
        setBusy(true);
        notifyListeners();
        final Map<String, dynamic> authData = {
          'username': email,
          'password': password,
          'returnSecureToken': true
        };
        http.Response response;
        if (mode == AuthMode.Login) {
          print(json.encode(authData));
          response = await http.post(
            "${apiURL}/login",
            body: json.encode(authData),
            headers: {'Content-Type': 'application/json'},
          );
        } else {
          response = await http.post(
            "${apiURL}/login",
            body: json.encode(authData),
            headers: {'Content-Type': 'application/json'},
          );
        }
        final Map<String, dynamic> responseData = json.decode(response.body);
        print("responseData $responseData");
        bool hasError = true;
        String message = 'Something went wrong.';
        print(responseData);
        if (responseData.containsKey('data')) {
          hasError = false;
          message = 'Authentication succeeded!';
          _authenticatedUser = User(
              id: responseData['data']['user']['localId'],
              email: email,
              token: responseData['data']['token']);
          _userDataSubject.add(_authenticatedUser);
          // var ex = int.parse(responseData['expiresIn']);
          var ex = 3600;
          setAuthTimeout(ex);
          _userSubject.add(true);
          final DateTime now = DateTime.now();
          final DateTime expiryTime = now.add(Duration(seconds: ex));
          final SharedPreferences prefs = await SharedPreferences.getInstance();
          prefs.setString('token', responseData['data']['token']);
          prefs.setString('userEmail', email);
          prefs.setString('userId', responseData['data']['localId']);
          prefs.setString('expiryTime', expiryTime.toIso8601String());
          
        
        } else if (responseData.containsKey('error')){
          if(responseData['message'] == 'EMAIL_EXISTS') {
            message = 'This email already exists.';
          } else if (responseData['message'] == 'EMAIL_NOT_FOUND') {
            message = 'This email was not found.';
          } else if (responseData['message'] == 'INVALID_PASSWORD') {
            message = 'The password is invalid.';
          }
        }
        setBusy(false);
        notifyListeners();
        return {'success': !hasError, 'message': message,'data':_authenticatedUser};
      }
    
      Future autoAuthenticate() async {
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        final String token = prefs.getString('token');
        final String expiryTimeString = prefs.getString('expiryTime');
        if (token != null) {
          final DateTime now = DateTime.now();
          final parsedExpiryTime = DateTime.parse(expiryTimeString);
          if (parsedExpiryTime.isBefore(now)) {
            _authenticatedUser = null;
            notifyListeners();
            return;
          }
          final String userEmail = prefs.getString('userEmail');
          final String userId = prefs.getString('userId');
          final int tokenLifespan = parsedExpiryTime.difference(now).inSeconds;
          _authenticatedUser = User(id: userId, email: userEmail, token: token);
          _userSubject.add(true);
          setAuthTimeout(tokenLifespan);
          notifyListeners();
        }
      }
    
      void logout() async {
        _authenticatedUser = null;
        _authTimer.cancel();
        _userSubject.add(false);
        // _selProductId = null;
        final SharedPreferences prefs = await SharedPreferences.getInstance();
        prefs.remove('token');
        prefs.remove('userEmail');
        prefs.remove('userId');
        _databaseHelper.deleteUsers();
      }
    
      void setAuthTimeout(int time) {
        _authTimer = Timer(Duration(seconds: time), logout);
      }
    
}


