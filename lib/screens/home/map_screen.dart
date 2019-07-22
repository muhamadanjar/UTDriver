import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'dart:async';
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
    return Scaffold(
      appBar: AppBar(
          title: Text('Lokasi Penumpang'),
          backgroundColor: Colors.blue[700],
      ),
      body: 
      Stack(
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
                    onPressed: ()=>{},
                    materialTapTargetSize: MaterialTapTargetSize.padded,
                    backgroundColor: Colors.blue,
                    child: const Icon(Icons.add_location, size: 36.0),
                  ),
                  SizedBox(height: 16.0),
                ],
              ),
            ),
          ),
          

        ],
      )
      
    );
    
  }
}