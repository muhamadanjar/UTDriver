import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'package:http/http.dart' as http;
class NetworkUtil {
  
  final JsonDecoder _decoder = new JsonDecoder();

  Future<dynamic> get(String url,{Map headers, body, encoding}) {
    return http.get(url,headers: headers ).then((http.Response response) {
      final String res = response.body;
      final int statusCode = response.statusCode;

      if (statusCode < 200 || statusCode > 400 || json == null) {
        throw new Exception("Error while fetching data from ${url}");
      }
      return _decoder.convert(res);
    });
  }

    Future<dynamic> post(String url, {Map headers, body, encoding}) async{
      return http
          .post(url, body: body, headers: headers, encoding: encoding)
          .then((http.Response response) {
        final String res = response.body;
        final int statusCode = response.statusCode;
        print(statusCode);
        if (statusCode < 200 || statusCode > 400 || json == null) {
          print(res);
          throw new Exception("Error while fetching data : " + url);
        }
        return _decoder.convert(res);
      });
    }
  }