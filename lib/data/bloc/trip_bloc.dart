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
        tripId = _job.id;
        print(tripId);
      }

    } catch (e) {

    }
  }
  Future changeStatusTrip(int status) async{
    final url = '${apiURL}/updateTripStatus';
    try {
      final paramsBody = json.encode(
          {
            'trip_id': tripId,
            'status': status
          },
      );
      final response = await http.post(url,
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer ${authToken}'},
        body: paramsBody
      );
      
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        // _job = Job.fromMap(responseData['data']);
        
        print(tripId);
      }
    } catch (e) {
    }
  }
  checkStatus(int tripId){
    switch (tripId) {
      case 0:
        return 'STATUS_PENDING';
        break;
      case 1:
        return 'STATUS_RECEIVE_DRIVER';
        break;
      case 2:
      return 'STATUS_ONTHEWAY_DRIVER';
      break;
      case 3:
       return 'STATUS_INTRANSIT';
       break;
      case 4:
        return 'STATUS_COMPLETE';
        break;
      case 5:
        return 'STATUS_CANCELED';
        break;
      case 6:
        return "STATUS_DECLINE";
        break;
      default:
    }
  }
}