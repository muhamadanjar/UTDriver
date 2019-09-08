import 'dart:convert';

import 'package:flutter/foundation.dart';
import 'package:rxdart/rxdart.dart';
import 'package:http/http.dart' as http;
import 'package:ut_driver_app/models/base_model.dart';
import '../../utils/constans.dart';

import 'package:ut_driver_app/models/job.dart';
class TripBloc extends BaseModel {
  Job _job;
  Job get currentJob => _job; 
  String authToken;
  PublishSubject _trip = new PublishSubject<Job>();
  int tripId;
  TripBloc(this.authToken);

  Future getCurrentTrip() async{
    final url = "${apiURL}/driver/check_job";
    try {
      final response = await http.post(url,
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer ${authToken}'},
      );

      
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        _job = Job.fromMap(responseData['data']);
        print(_job.toString());
      }

    } catch (e) {

    }
  }
}