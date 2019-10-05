import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/components/job_card.dart';
import 'package:ut_driver_app/components/saldo.dart';
import 'package:ut_driver_app/data/bloc/auth_bloc.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
import 'package:ut_driver_app/models/job.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:ut_driver_app/utils/constans.dart';
class HomeScreen extends StatefulWidget {
  @override

  HomeScreenState createState() => new HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{
  Geolocator _geolocator;
  Position _position;
  bool isSwitched = true;
  static const LatLng _center = const LatLng(3.6422756, 98.5294038);
  RestDatasource api = new RestDatasource();
  Marker marker;
  Job job;
  String saldo = "Rp. 0";
  

  @override
  void initState() {
    super.initState();
    _geolocator = Geolocator();
    LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
    checkPermission();
    // updateLocation();

    StreamSubscription positionStream = _geolocator.getPositionStream(locationOptions).listen((Position position) {
      _position = position;
    });
  }

  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) { print('status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationAlways).then((status) { print('always status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationWhenInUse)..then((status) { print('whenInUse status: $status'); });
  }

  
  void _onChangeSwitch(bool value) async {
    try {
      print(value);
      setState(() {
        isSwitched = value;
        api.changeStatusOnline(value.toString());
      });
    } catch (e) {
      print(e);
    }
  }

  
  @override
  Widget build(BuildContext context) {
    final userData = Provider.of<User>(context);
    return Scaffold(
      appBar: AppBar(

        title: Text('Utama Trans'),
        actions: <Widget>[
          Consumer<AuthBloc>(
            builder:(ctx,auth,_)=> InkWell(
              child: Switch(value: isSwitched,onChanged: (bool val){
                print(val);
                setState(() {
                  isSwitched = val;
                });
                auth.updateStatus(isSwitched);
              },activeColor: Colors.white),
              onTap: () {
                print("click search");
              },
            ),
          ),
        ],
      ),

      body:BaseWidget(
        model: AuthBloc(),
        onModelReady: (model) async{
          
          print("Ready Model");
          model.getUser();
          Position newPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).timeout(new Duration(seconds: 5));
          print("position $newPosition");
          model.updatePosition(newPosition);
        },
        builder:(context,model,child)=> Container(
          child:RefreshIndicator(
            onRefresh: () =>_reload(model),
            child: ListView(
              children: <Widget>[
                Container(
                  padding: EdgeInsets.only(left: 16.0, right: 16.0, top: 16.0),
                  color: Colors.white,
                  child: Column(
                    children:<Widget>[
                      Saldo()
                    ],
                  )
                ),
                Container(
                  color: Colors.white,
                  margin: EdgeInsets.only(top: 16.0),
                  child: Center(
                    child: Text('Latitude: ${model.userPosition != null ? model.userPosition.latitude.toString() : '0'}, Longitude: ${model.userPosition != null ? model.userPosition.longitude.toString() : '0'}'),
                  ),
                ),
                JobCard(job: model.job,)

              ],
            ),
          )
        ),
      ),

    );

  }
  Future<Null> _reload(model) async{

    Completer<Null> completer = new Completer<Null>();
    Position newPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high);
    model.updatePosition(newPosition);
    Timer timer = new Timer(new Duration(seconds: 3), () {
      
      completer.complete();
    });
    return completer.future;
  }


  
}
