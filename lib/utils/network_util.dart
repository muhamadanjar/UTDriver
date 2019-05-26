import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'package:ut_driver_app/models/user.dart';
class NetworkUtil {
  
  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url) {
    return http.get(url).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data");
      }
      return _decoder.convert(res);
    });
  }

    Future<dynamic> post(String url, {Map headers, body, encoding}) {
      var token;
      SharedPreferences.getInstance().then((_p){
        token = _p.getString('token');
        
      });
  
      return http
          .post(url, body: body, headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer ${token}',
          }, encoding: encoding)
          .then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;
        print(statusCode);
        if (statusCode < 200 || statusCode > 400 || json == null) {
          throw new Exception("Error while fetching data");
        }
        return _decoder.convert(res);
      });
    }
  }