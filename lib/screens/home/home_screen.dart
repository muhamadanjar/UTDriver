import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/components/job_card.dart';
import 'package:ut_driver_app/components/job_widget.dart';
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
          InkWell(
            child: Switch(value: isSwitched,onChanged: _onChangeSwitch,activeColor: Colors.white),
            onTap: () {
              print("click search");
            },
          ),
        ],
      ),

      body:BaseWidget(
        model: AuthBloc(api: Provider.of(context)),
        onModelReady: (model) async{
          
          print("Ready Model");
          model.getUser();
          Position newPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high).timeout(new Duration(seconds: 5));
          print("position $newPosition");
          model.updatePosition(newPosition);
          model.checkJob();
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
                    children:<Widget>[_buildGopayMenu()],
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
  Widget _buildGopayMenu() {
    return Consumer<AuthBloc>(
          builder:(context,model,_)=> new Container(
          height: 120.0,
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
              ),
              borderRadius: new BorderRadius.all(new Radius.circular(3.0))
          ),
          child: new Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.all(12.0),
                decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
                    ),
                    borderRadius: new BorderRadius.only(
                        topLeft: new Radius.circular(3.0),
                        topRight: new Radius.circular(3.0))),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                     Text(
                      "Saldo",
                      style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                      ),
                    ),
                    Container(
                      child: new Text(
                        "",
                        style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 12.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset(
                          "assets/icons/icon_transfer.png",
                          width: 32.0,
                          height: 32.0,
                        ),
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        new Text(
                          "Transfer",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RoutePaths.Topup),
                      child: new Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.asset(
                            "assets/icons/icon_saldo.png",
                            width: 32.0,
                            height: 32.0,
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          new Text(
                            "Isi Saldo",
                            style: TextStyle(color: Colors.white, fontSize: 12.0),
                    
                          )
                        ],
                      ),
                    ),
                    
                    
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset(
                          "assets/icons/icon_menu.png",
                          width: 32.0,
                          height: 32.0,
                        ),
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        new Text(
                          "Lainnya",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }

  
}
