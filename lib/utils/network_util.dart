import 'dart:async';
import 'dart:convert';
import 'dart:core';

import 'package:http/http.dart' as http;
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
      return http
          .post(url, body: body, headers: {
            'Accept': 'application/json',
            'Authorization': 'Bearer eyJ0eXAiOiJKV1QiLCJhbGciOiJSUzI1NiIsImp0aSI6IjM5MTQzYTE4MGI2MzVkMTFhZmYxYThlYjVhMzgzZWQ1YjUzNjg0ZGI0YzViMGY4NDg2MmZiMzhkMjgyMGQyN2M1MDUzMmFkMWVkNjYyMWI0In0.eyJhdWQiOiIzIiwianRpIjoiMzkxNDNhMTgwYjYzNWQxMWFmZjFhOGViNWEzODNlZDViNTM2ODRkYjRjNWIwZjg0ODYyZmIzOGQyODIwZDI3YzUwNTMyYWQxZWQ2NjIxYjQiLCJpYXQiOjE1NTgzNDgyOTQsIm5iZiI6MTU1ODM0ODI5NCwiZXhwIjoxNTg5OTcwNjk0LCJzdWIiOiIyIiwic2NvcGVzIjpbXX0.eOLMUKDJRp3ORqAaU9I9sR5AgScLenJafn47g2snBpf2sAngi2IAyHR0sXNFwieJadpOoYshbaoi-5g997f4NEGT9fMFuA4ZOkOB26a-JuI_qnTwedrFPDfxHoQHQtcBPkp4XTVtRqRZdHUZMNOoHL89YBfmuDt4mPu5CoYMLTlzHema0Efo2bCyBG3ZEK3wKRjoJZ0k_oB4IcRfGyXW9IrW9IMjmR_bJZ4itqTMiGh7cRx5EsrXbkEOjcbwQ9pC_ewIDfqr_BMX3jRrpsj58nSNzEJYvKkNp0bsxSJ-vheV3zO2ZY0RGSOQLQ85SNXxy2HoGJhfcb62IanB2NfPQyHORQQJ7cjFYw9vjW-wiznaZC9hrBm1QUkTvP35e3L62KIbGnVdAu95BY4fVpcl-b2rFM7MnbhaLrUjZdySz_igz-psL98KRc57L35Q1qzwQT6-Y9N-m5tdHd3Kv25NN7-DIqey8eo5jbxio1HgD8V-KJL8Y7xYwNlMoSkTyFN_sQlGYgYYzJmaBHfD4wVrsZ-uP9ErldXUjzfC0uoflY4L3VsMeB8MjJJzQ8wmRSRgzVzzZTWA8d7vQpFb4LEL2oZjHoptTja0pxVAYqgEHtIMVy6f0jJfnfqaH0ppdABs_FSZAlHpDNDSZEcAmyVa0jzUffLJX5a2Q8ocOG7xWFA',
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