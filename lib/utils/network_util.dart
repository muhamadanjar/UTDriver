import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;

import 'package:ut_driver_app/models/UserLogin.dart';

class NetworkUtil {
  // next three lines makes this class a Singleton
  // NetworkUtil(this.auth);
  // final UserLogin auth;
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
      return http
          .post(url, body: body, headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjAxYjFhOWI1MGQ2NTVlNzIwNDBmZTA1ZGJlNmUxZGYwY2U0NGQ0YTgxNDhiOWQ5NTg4MGE0MGJhYzQ5ZDZiNDU1NGQ1MjQ4ZjJlZTUyZDUyIn0.eyJhdWQiOiIzIiwianRpIjoiMDFiMWE5YjUwZDY1NWU3MjA0MGZlMDVkYmU2ZTFkZjBjZTQ0ZDRhODE0OGI5ZDk1ODgwYTQwYmFjNDlkNmI0NTU0ZDUyNDhmMmVlNTJkNTIiLCJpYXQiOjE1NTc0ODc3OTAsIm5iZiI6MTU1NzQ4Nzc5MCwiZXhwIjoxNTg5MTEwMTkwLCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.U3KXYFKf4ZKPDZsCl1P-ipKX5-vJlhtULIwZ7G9KzvObNsEGqdb9vfLh9Pm0-w0C3_Tf3-G7oGGqtIn_NEO6fmjImXenkWvE8QgKvLZEOIfDLFJ4g8YvUdTT6jK2gGl7DlubvNfBS-Jvpzk1_ts3h64aTVFwrqTWj5qlvndfQuouzDl32RrwSpqnlAeBcR53_MZNc0u0LKHN0mmT7GXNs8aSXkXNE82tm_CP52J0YWHcmyPioCX0T39c4YcE240wH2Q8-bgQbr3lXdrsmp8WF_L0u8tpxa0_SQBFBe7ww0sScl4W9QK1knwPF4a83GbToh1DAPEURCra6OcD8nO-kfFyeZzzdRst7qAAqFUl6yh6kXZDicAEN1e9ryPX1B8v-lSyw1jMxrGZ6BoouGjha5Ogc9cqW9ykNr1tQJSiEE4vR8w9jAl8H4-67jY_yIXz1NpP4JJ0AM4D9Wy8D85hxZI4xr_qSv21fx0ZhyNOsWi5ct6kFPDlUK2Jw4wpUxg41MeGj_aqtKKF50M8rqjJEMoK_y0GXvClVxnhEMZwrYZU6ffR0PMZEpzEYBvwQlqkaMzuQYxD2mE3LXDtBVkADeoLGCXJxU4_cO6amuFR0qdrQxzTihZciijAr0VT-nmAbg7ESqHXWGBsYop92xOvrgcZvbLvMiA8kceETMk-bYM',
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

//   Future<dynamic> get(String url) async {
//     if (auth == null) throw ('Auth Model Required');
//     final String _token = auth?.token ?? "";
//     final http.Response response = await getHttpReponse(
//       url,
//       headers: {
//               HttpHeaders.authorizationHeader: "Bearer $_token",
//             },
//       method: HttpMethod.get,
//     );

//     if (response?.body == null) return null;

//     return json.decode(response.body);
//   }



// Future<dynamic> post(String url, dynamic data,
//       {String bodyContentType}) async {
//     if (auth == null) throw ('Auth Model Required');
//     final String _token = auth?.token ?? "";
//     final http.Response response = await getHttpReponse(
//       url,
//       body: data,

//       headers: {
//         HttpHeaders.contentTypeHeader: bodyContentType ?? 'application/json',
//         HttpHeaders.authorizationHeader: "Bearer $_token",
//       },
//       method: HttpMethod.post,
//     );

//     if (response.headers.containsValue("json"))
//       return json.decode(response.body);

//     return response.body;
//   }

//   Future<dynamic> delete(String url) async {
//     final String _token = auth?.token ?? "";
//     http.Response response = await getHttpReponse(
//       url,
//       headers: {
//         HttpHeaders.authorizationHeader: "Bearer $_token",
//       },
//       method: HttpMethod.delete,
//     );

//     return json.decode(response.body);
//   }

//   Future<dynamic> put(String url, dynamic data) async {
//     final String _token = auth?.token ?? "";
//     final http.Response response = await getHttpReponse(
//       url,
//       body: data,
//       headers: {
//         'Content-Type': 'application/json',
//         HttpHeaders.authorizationHeader: "Bearer $_token",
//       },
//       method: HttpMethod.put,
//     );

//     return json.decode(response.body);
//   }


//   Future<http.Response> getHttpReponse(
//     String url, {
//     dynamic body,
//     Map<String, String> headers,
//     HttpMethod method = HttpMethod.get,
//   }) async {
//     final inner.IOClient _client = getClient();
//     http.Response response;
//     try {
//       switch (method) {
//         case HttpMethod.post:
//           response = await _client.post(
//             url,
//             body: body,
//             headers: headers,
//           );
//           break;
//         case HttpMethod.put:
//           response = await _client.put(
//             url,
//             body: body,
//             headers: headers,
//           );
//           break;
//         case HttpMethod.delete:
//           response = await _client.delete(
//             url,
//             headers: headers,
//           );
//           break;
//         case HttpMethod.get:
//           response = await _client.get(
//             url,
//             headers: headers,
//           );
//       }

//       print("URL: ${url}");
//       print("Body: $body");
//       print("Response Code: " + response.statusCode.toString());
//       print("Response Body: " + response.body.toString());

//       if (response.statusCode >= 400) {
//         // if (response.statusCode == 404) return response.body; // Not Found Message
//         if (response.statusCode == 401) {
//           if (auth != null) {
//             // Todo: Refresh Token !
//             // await auth.refreshToken();
//             final String _token = auth?.token ?? "";
//             print(" Second Token => $_token");
//             // Retry Request
//             response = await getHttpReponse(
//               url,
//               headers: {
//                 HttpHeaders.authorizationHeader: "Bearer $_token",
//               },
//             );
//           }
//         } // Not Authorized
//         if (devMode) throw ('An error occurred: ' + response.body);
//       }
//     } catch (e) {
//       print('Error with URL: $e');
//     }

//     return response;
//   }

//   inner.IOClient getClient() {
//     bool trustSelfSigned = true;
//     HttpClient httpClient = new HttpClient()
//       ..badCertificateCallback =
//           ((X509Certificate cert, String host, int port) => trustSelfSigned);
//     inner.IOClient ioClient = new inner.IOClient(httpClient);
//     return ioClient;
//   }
// }

// enum HttpMethod { get, post, put, delete }