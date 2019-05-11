import 'dart:async';
import 'package:ut_driver_app/utils/network_util.dart';
import 'package:ut_driver_app/models/user.dart';

class RestDatasource {
  NetworkUtil _netUtil = new NetworkUtil();
  static final BASE_URL = "http://192.168.43.110/api";
  static final LOGIN_URL = BASE_URL + "/login";
  static final UPDATE_LOCATION =  BASE_URL + "/user/update_position";
//  static final _API_KEY = "somerandomkey";

  Future<User> login(String username, String password) {
    var data = {
      "username": username,
      "password": password
      //"token": _API_KEY,
    };

    return _netUtil.post(Uri.encodeFull(LOGIN_URL), body: data).then((dynamic res) {
      print(res);
//      if(res["error"]) throw new Exception(res["message"]);
      return new User.map(res["data"]);
    });
  }

  

  
}   