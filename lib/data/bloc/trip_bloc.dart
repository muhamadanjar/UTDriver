import 'package:rxdart/rxdart.dart';
import 'package:rxdart/subjects.dart';
import 'package:ut_driver_app/models/job.dart';
class TripBloc {
  Job _job;
  PublishSubject _trip = new PublishSubject<Job>();
  TripBloc(){
    
  }
}