import 'dart:async';
import 'package:ut_driver_app/utils/network_util.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
class RestDatasource {
  NetworkUtil _networkUtil = new NetworkUtil();

  static final BASE_URL = "http://192.168.43.110/api";
  static final LOGIN_URL = BASE_URL + "/login";
  static final LOGOUT_URL = BASE_URL + "/logout";
  static final UPDATE_LOCATION =  BASE_URL + "/user/update_position";
  static final GET_USER =  BASE_URL + "/user/details";
  static final SET_STATUS_ONLINE =  BASE_URL + "/user/changeonline";
  static final _API_KEY = "somerandomkey";

  Future<User> login(String username, String password) {
    var data = {
      "username": username,
      "password": password,
      "token": _API_KEY,
    };
    return _networkUtil.post(LOGIN_URL,body:data).then((dynamic res) {
      print(res);
      if(res["error"] == null) throw new Exception(res["message"]);
      SharedPreferences.getInstance().then((pref)=>{
        pref.setString('token', res['data'].token)
      });
      return new User.map(res["data"]);
      // return new UserLogin.fromJson(res['data']);
    });
  }

  Future<User> logout(){
    return _networkUtil.get(LOGOUT_URL).then((dynamic res)=>{
      SharedPreferences.getInstance().then((pref)=>{
        pref.clear()
      })
    });
  }

  Future<String> getUser(String token){
    var data = {'token':token};
    return _networkUtil.post(GET_USER,body:data).then((dynamic res){
      print(res);
    });
  }

  Future<dynamic> updateLocation(String latitude,String longitude){
    var data = {
      'latitude': latitude,
      'longitude': longitude,
      'latest_update': new DateTime.now().toString()
    };
    print(UPDATE_LOCATION);
    return _networkUtil.post(UPDATE_LOCATION,body:data).then((dynamic res){
      print(res);
    });
  }
  Future<dynamic> changeStatusOnline(String status){
    var data = {
      'online' : status
    };
    return _networkUtil.post(SET_STATUS_ONLINE,body: data).then((dynamic res){
      print(res);
    });
  }  
}   