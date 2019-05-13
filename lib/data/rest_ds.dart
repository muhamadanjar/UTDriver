import 'dart:async';
import 'package:ut_driver_app/models/post.dart';
import 'package:ut_driver_app/utils/network_util.dart';
import 'package:ut_driver_app/models/UserLogin.dart';

class RestDatasource {
  UserLogin _userLogin;
  

  static final BASE_URL = "http://192.168.43.110/api";
  static final LOGIN_URL = BASE_URL + "/login";
  static final UPDATE_LOCATION =  BASE_URL + "/user/update_position";
  static final GET_USER =  BASE_URL + "/user/details";
  static final _API_KEY = "somerandomkey";

  Future<UserLogin> login(String username, String password) {
    var data = {
      "username": username,
      "password": password,
      "token": _API_KEY,
    };
    return new NetworkUtil(_userLogin).post(LOGIN_URL,data).then((dynamic res) {
      print(res);
      if(res["error"] == null) throw new Exception(res["message"]);
      // return new User.map(res["data"]);
      return new UserLogin.fromJson(res['data']);
    });
  }

  Future<String> getUser(String token){
    var data = {'token':token};
    return new NetworkUtil(_userLogin).post(GET_USER,data).then((dynamic res){
      print(res);
    });
  }

  Future<Post> updateLocation(double latitude,double longitude){
    var data = {
      latitude: latitude,
      longitude: longitude
    };
    print(UPDATE_LOCATION);
    return new NetworkUtil(_userLogin).post(UPDATE_LOCATION,data).then((dynamic res){
      print(res);
    });
  }  
}   