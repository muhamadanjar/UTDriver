import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';

import 'package:ut_driver_app/components/custom_dialog.dart';
import 'package:ut_driver_app/utils/constans.dart';
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition _initialPosition = CameraPosition(target: LatLng(3.6422756, 98.5294038),zoom: 11.0);
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(3.6422756, 98.5294038);

  @override
  void initState(){
    super.initState();
  }
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    var iconButton = IconButton(icon: Icons.phone, onPressed: () {},);
    return Scaffold(
      appBar: AppBar(
          title: Text('Lokasi Penumpang'),
          backgroundColor: Colors.blue[700],
      ),
      body:Stack(
        children: <Widget>[
          GoogleMap(
              onMapCreated: _onMapCreated,
              myLocationEnabled: true,
              initialCameraPosition: CameraPosition(
                target: _center,
                zoom: 11.0,
              )
          ),
          Padding(
            padding: EdgeInsets.all(16.0),
            child: Align(
              alignment: Alignment.topRight,
              child: Column(
                children: <Widget>[
                  FloatingActionButton(
                    onPressed: (){
                      showDialog(
                        context: context,
                        builder: (BuildContext context) => CustomDialog(
                          title: "Success",
                          description:
                          "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
                          buttonText: "Okay",
                        ),
                      );
                    },
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.gps_fixed, size: 25.0),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
          Positioned(
            bottom: 5,
            child: Column(
              mainAxisSize: MainAxisSize.max,
              children: <Widget>[
                Container(
                  width: SizeConfig.blockWidth*95,
                  height: 100,
                  color: Colors.black38,
                  margin: EdgeInsets.only(left: 10,right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      FlatButton(
                        
                        onPressed: null,
                        child: iconButton,
                      ),
                      MaterialButton(onPressed: null,
                          color: Colors.redAccent,
                          highlightColor: Colors.redAccent,
                          splashColor: Colors.redAccent,
                          minWidth: 150,
                          elevation: 4,
                          highlightElevation: 2,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(3)
                          ),
                          padding: EdgeInsets.symmetric(vertical: 35),
                          child: Text("Mulai"),
                          ),
                      
                      
                    ],
                  ),
                ),
              ],
            ),
          )


          

        ],
      )
      
    );
    
  }
}