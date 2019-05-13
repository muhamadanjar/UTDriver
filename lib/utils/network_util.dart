import 'dart:async';
import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:http/io_client.dart' as inner;
import 'package:ut_driver_app/models/UserLogin.dart';
import 'package:ut_driver_app/utils/constans.dart';
class NetworkUtil {
  // next three lines makes this class a Singleton
  NetworkUtil(this.auth);
  final UserLogin auth;
  final JsonDecoder _decoder = new JsonDecoder();

  // Future<dynamic> get(String url) {
  //   return http.get(url).then((http.Response response) {
  //     final String res = response.body;
  //     final int statusCode = response.statusCode;

  //     if (statusCode < 200 || statusCode > 400 || json == null) {
  //       throw new Exception("Error while fetching data");
  //     }
  //     return _decoder.convert(res);
  //   });
  // }

  //   Future<dynamic> post(String url, {Map headers, body, encoding}) {
  //     return http.Client()
  //         .post(url, body: body, headers: {
  //           'Accept': 'application/json',
  //         }, encoding: encoding)
  //         .then((http.Response response) {
  //       final String res = response.body;
  //       final int statusCode = response.statusCode;
      
  //       if (statusCode < 200 || statusCode > 400 || json == null) {
  //         throw new Exception("Error while fetching data");
  //       }
  //       return _decoder.convert(res);
  //     });
  //   }
  // }

  Future<dynamic> get(String url) async {
    if (auth == null) throw ('Auth Model Required');
    final String _token = auth?.token ?? "";
    final http.Response response = await getHttpReponse(
      url,
      headers: {
              HttpHeaders.authorizationHeader: "Bearer $_token",
            },
      method: HttpMethod.get,
    );

    if (response?.body == null) return null;

    return json.decode(response.body);
  }



Future<dynamic> post(String url, dynamic data,
      {String bodyContentType}) async {
    if (auth == null) throw ('Auth Model Required');
    final String _token = auth?.token ?? "";
    final http.Response response = await getHttpReponse(
      url,
      body: data,

      headers: {
        HttpHeaders.contentTypeHeader: bodyContentType ?? 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $_token",
      },
      method: HttpMethod.post,
    );

    if (response.headers.containsValue("json"))
      return json.decode(response.body);

    return response.body;
  }

  Future<dynamic> delete(String url) async {
    final String _token = auth?.token ?? "";
    http.Response response = await getHttpReponse(
      url,
      headers: {
        HttpHeaders.authorizationHeader: "Bearer $_token",
      },
      method: HttpMethod.delete,
    );

    return json.decode(response.body);
  }

  Future<dynamic> put(String url, dynamic data) async {
    final String _token = auth?.token ?? "";
    final http.Response response = await getHttpReponse(
      url,
      body: data,
      headers: {
        'Content-Type': 'application/json',
        HttpHeaders.authorizationHeader: "Bearer $_token",
      },
      method: HttpMethod.put,
    );

    return json.decode(response.body);
  }


  Future<http.Response> getHttpReponse(
    String url, {
    dynamic body,
    Map<String, String> headers,
    HttpMethod method = HttpMethod.get,
  }) async {
    final inner.IOClient _client = getClient();
    http.Response response;
    try {
      switch (method) {
        case HttpMethod.post:
          response = await _client.post(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.put:
          response = await _client.put(
            url,
            body: body,
            headers: headers,
          );
          break;
        case HttpMethod.delete:
          response = await _client.delete(
            url,
            headers: headers,
          );
          break;
        case HttpMethod.get:
          response = await _client.get(
            url,
            headers: headers,
          );
      }

      print("URL: ${url}");
      print("Body: $body");
      print("Response Code: " + response.statusCode.toString());
      print("Response Body: " + response.body.toString());

      if (response.statusCode >= 400) {
        // if (response.statusCode == 404) return response.body; // Not Found Message
        if (response.statusCode == 401) {
          if (auth != null) {
            // Todo: Refresh Token !
            // await auth.refreshToken();
            final String _token = auth?.token ?? "";
            print(" Second Token => $_token");
            // Retry Request
            response = await getHttpReponse(
              url,
              headers: {
                HttpHeaders.authorizationHeader: "Bearer $_token",
              },
            );
          }
        } // Not Authorized
        if (devMode) throw ('An error occurred: ' + response.body);
      }
    } catch (e) {
      print('Error with URL: $e');
    }

    return response;
  }

  inner.IOClient getClient() {
    bool trustSelfSigned = true;
    HttpClient httpClient = new HttpClient()
      ..badCertificateCallback =
          ((X509Certificate cert, String host, int port) => trustSelfSigned);
    inner.IOClient ioClient = new inner.IOClient(httpClient);
    return ioClient;
  }
}

enum HttpMethod { get, post, put, delete }