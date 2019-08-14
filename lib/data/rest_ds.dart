import 'dart:async';
import 'package:ut_driver_app/models/history.dart';
import 'package:ut_driver_app/utils/network_util.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ut_driver_app/utils/constans.dart';
import 'database_helper.dart';
class RestDatasource {
  NetworkUtil _networkUtil = new NetworkUtil();

  static final BASE_URL = apiURL;
  static final LOGIN_URL = BASE_URL + "/login";
  static final LOGOUT_URL = BASE_URL + "/logout";
  static final UPDATE_LOCATION =  BASE_URL + "/user/update_position";
  static final GET_USER =  BASE_URL + "/user/details";
  static final SET_STATUS_ONLINE =  BASE_URL + "/user/changeonline";
  static final CHECK_JOB =  BASE_URL + "/driver/checkjob";
  static final TRIP_HISTORY = BASE_URL + "/trip/history";
  static final POST_UPLOAD_BUKTI = BASE_URL + "/post_upload_bukti";

  static final _API_KEY = "somerandomkey";
  final token = 'token';
  

  Future<String> getPrefs(key) async {
    var _prefs = await SharedPreferences.getInstance();
    return _prefs.getString(key);
  }

  Future<User> login(String username, String password) {
    var data = {
      "username": username,
      "password": password,
      "token": _API_KEY,
    };
    var headers ={
      'Accept': 'application/json',
    };
    return _networkUtil.post(LOGIN_URL,body:data,headers: headers).then((dynamic res) async {
//      print("response from login ${res}");
      if(res["error"] == null) throw new Exception(res["message"]);
      final prefs = await SharedPreferences.getInstance();
      prefs.setString('token', res['data']['token']);
      return new User.fromJson(res["data"]['user']);
    });
  }

  Future<dynamic> logout(){
    var db = new DatabaseHelper();
    SharedPreferences.getInstance().then((pref){
      pref.clear();
      db.deleteUsers();
    });
  }

  Future<User> getUser() async{
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get("token");
    var data = {'token':token};
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}',
    };
    return _networkUtil.post(GET_USER,body:data,headers: headers).then((dynamic res){
      return new User.fromJson(res['data']);
    });
  }

  Future<dynamic> updateLocation(String latitude,String longitude) async{
    var data = {
      'latitude': latitude,
      'longitude': longitude,
      'latest_update': new DateTime.now().toString()
    };
    
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get("token");
    print(token);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}',
    };
    
    return _networkUtil.post(UPDATE_LOCATION,body:data,headers: headers).then((dynamic res){
      print(res);
    });
  }
  Future<dynamic> changeStatusOnline(String status) async{
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get("token");
    var data = {
      'online' : status
    };
    print(data);
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    return _networkUtil.post(SET_STATUS_ONLINE,body: data,headers: headers).then((dynamic res){
      print(res);
    });
  }
  Future<dynamic> checkJob(){
    var body = {
      'driverId':'1'
    };
    var headers = {
      'Accept': 'application/json',
      'Authorization': 'Bearer $token',
    };
    _networkUtil.post(CHECK_JOB,body: body,headers: headers).then((dynamic res){
      print(res);
    });
  }

  Future<List<HisDetails>> getHistory() async{
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get("token");
    var headers ={
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}',
    };
    var history = new List<HisDetails>();
    var response = await _networkUtil.get(TRIP_HISTORY,headers:headers);
    (response["data"] as List).forEach((f){
      var data = HisDetails.fromJson(f);
      print(f);
      history.add(data);
    });
    return history;
  }
  Future uploadbukti(data) async{
    var _prefs = await SharedPreferences.getInstance();
    var token = _prefs.get("token");
    var headers ={
      'Accept': 'application/json',
      'Authorization': 'Bearer ${token}',
    };
    
    var response = await _networkUtil.post(POST_UPLOAD_BUKTI,body: data,headers: headers);
    return response;
  }
}   