import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
class MapScreen extends StatefulWidget {
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition _initialPosition = CameraPosition(target: LatLng(3.6422756, 98.5294038));
  @override
  void initState(){
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Container(
            height: MediaQuery.of(context).size.height,
            child: GoogleMap(
              onMapCreated: (GoogleMapController controller){

              },
              initialCameraPosition: _initialPosition,
              
            ),
          )
        ],
      ),
    );
  }
  Widget _buildAppBar(){

  }
}