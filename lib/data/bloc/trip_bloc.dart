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
  int tripStatus;
  String textButton;
  TripBloc(this.authToken);

  PublishSubject<Job> get tripSubject {
    return _trip;
  }

  Future getCurrentTrip() async{
    final url = "${apiURL}/driver/check_job";
    try {
      final response = await http.post(url,
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer ${authToken}'},
      );
      final responseData = json.decode(response.body);
      if (response.statusCode == 200) {
        _job = Job.fromMap(responseData['data']);
        _trip.add(_job);
        tripId = _job.id;
        tripStatus = _job.status;

        setTextButton(setTextButton(checkStatus(tripStatus)));
        
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
  incrementStatus(){
    if (tripStatus == null) {
      tripStatus = 0;
    }
    if(tripStatus < 6){
      tripStatus++;
    }
    notifyListeners();
    
  }
  setTextButton(String text){
    textButton = text;
    notifyListeners();
  }
}