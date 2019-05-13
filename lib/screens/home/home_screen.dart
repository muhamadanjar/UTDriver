import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'dart:async';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
import 'package:ut_driver_app/utils/network_util.dart';
class HomeScreen extends StatefulWidget {
  @override

  HomeScreenState createState() => new HomeScreenState();

}

class HomeScreenState extends State<HomeScreen>{
  NetworkUtil _networkUtil;
  Geolocator _geolocator;
  Position _position;
  GoogleMapController mapController;
  bool isSwitched = true;
  static const LatLng _center = const LatLng(3.6422756, 98.5294038);
  RestDatasource api;
  Marker marker;

  @override

  void initState() {

    super.initState();

    _geolocator = Geolocator();
    LocationOptions locationOptions = LocationOptions(accuracy: LocationAccuracy.high, distanceFilter: 1);
    checkPermission();
    updateLocation();

    

    StreamSubscription positionStream = _geolocator.getPositionStream(locationOptions).listen((Position position) {
      _position = position;
    });
  }

  void checkPermission() {
    _geolocator.checkGeolocationPermissionStatus().then((status) { print('status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationAlways).then((status) { print('always status: $status'); });
    _geolocator.checkGeolocationPermissionStatus(locationPermission: GeolocationPermission.locationWhenInUse)..then((status) { print('whenInUse status: $status'); });
  }

  void updateLocation() async {

    try {
      Position newPosition = await Geolocator().getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
          .timeout(new Duration(seconds: 5));
      setState(() {
        _position = newPosition;
        
      });
      api.updateLocation(_position.latitude,_position.longitude); 
    } catch (e) {
      print('Error: ${e.toString()}');

    }

  }
  
  @override
  void _onChangeSwitch(bool value) async {
    try {
      setState(() {
        isSwitched = value;
      });
    } catch (e) {
      print(e);
    }
  }


  @override

  Widget build(BuildContext context) {

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

      body:Column(
        children: <Widget>[
          Container(
            child: _buildGopayMenu()
          ),
          Container(
            child: Center(
              child: Text('Latitude: ${_position != null ? _position.latitude.toString() : '0'}, Longitude: ${_position != null ? _position.longitude.toString() : '0'}'),
            ),
          )
          // Center(
          //     child: Text('Latitude: ${_position != null ? _position.latitude.toString() : '0'},'
          //       ' Longitude: ${_position != null ? _position.longitude.toString() : '0'}')
          
        ],
      ),
      bottomNavigationBar:_bottomAppbar()
    );

  }

  Widget _buildGopayMenu() {
    return new Container(
        height: 120.0,
        decoration: new BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
            ),
            borderRadius: new BorderRadius.all(new Radius.circular(3.0))),
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
                  new Text(
                    "Saldo",
                    style: new TextStyle(
                        fontSize: 18.0,
                        color: Colors.white,
                        fontFamily: "NeoSansBold"),
                  ),
                  new Container(
                    child: new Text(
                      "Rp. 120.000",
                      style: new TextStyle(
                          fontSize: 14.0,
                          color: Colors.white,
                          fontFamily: "NeoSansBold"),
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
                  
                  new Column(
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
        ));
  }
  
  Widget _bottomAppbar(){
    return new BottomAppBar(
      child: new Row(
        // alignment: MainAxisAlignment.spaceAround,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: <Widget>[
          new IconButton(
            icon: Icon(
              Icons.home,
            ),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(
              Icons.message,
            ),
            onPressed: () {},
          ),
          new IconButton(
            icon: Icon(
              Icons.account_box,
            ),
            onPressed: null,
          ),
        ],
      ),
    );
  }
}
