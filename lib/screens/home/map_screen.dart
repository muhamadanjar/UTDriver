import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/components/button_full.dart';
import 'package:ut_driver_app/components/container_posisi.dart';
import 'dart:async';

import 'package:ut_driver_app/components/custom_dialog.dart';
import 'package:ut_driver_app/components/form_inputs/functionButton.dart';
import 'package:ut_driver_app/components/network.dart';
import 'package:ut_driver_app/components/pemesanan/CardPemesanan.dart';
import 'package:ut_driver_app/data/bloc/auth_bloc.dart';
import 'package:ut_driver_app/data/bloc/trip_bloc.dart';
import 'package:ut_driver_app/models/base_model.dart';
import 'package:ut_driver_app/models/job.dart';
import 'package:ut_driver_app/theme/styles.dart';
import 'package:ut_driver_app/utils/constans.dart';
class MapScreen extends StatefulWidget {
  Job job;
  MapScreen({Key key ,this.job}):super(key:key);
  
  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  CameraPosition _initialPosition = CameraPosition(target: LatLng(3.6422756, 98.5294038),zoom: 11.0);
  Completer<GoogleMapController> _controller = Completer();
  static const LatLng _center = const LatLng(3.6422756, 98.5294038);
  BuildContext _ctx;
  @override
  void initState(){
    super.initState();
  }
  void _onMapCreated(GoogleMapController controller) {
    _controller.complete(controller);
  }

  void openDialog(){
    showDialog(
      context: _ctx,
      builder: (BuildContext context) => CustomDialog(
        title: "Success",
        description:
        "Text",
        buttonText: "Okay",
      ),
    );
  }


  Widget bottomApp(){
    return Container(
      height: 90,
      decoration: BoxDecoration(
        color: Colors.white,
        boxShadow: [BoxShadow(color: Colors.grey, blurRadius: 11, offset: Offset(3.0, 4.0))],
      ),
      padding: EdgeInsets.only(left: 10,right: 15),
      child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            mainAxisSize: MainAxisSize.max,      
            children: <Widget>[
               MaterialButton(
                  minWidth: SizeConfig.blockWidth*45,
                  height: 50,
                  color: Colors.blue[700],
                  padding: EdgeInsets.only(left: 20),
                  onPressed: () {
                    
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Jemput',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 4,wordSpacing: 7.0),
                      )
                    ],
                  ),
                ),
                MaterialButton(
                  minWidth: SizeConfig.blockWidth*45,
                  height: 50,
                  color: Colors.red[700],
                  padding: EdgeInsets.only(left: 20),
                  onPressed: () {
                    
                  },
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      SizedBox(
                        width: 5.0,
                      ),
                      Text(
                        'Batal',
                        style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold,letterSpacing: 4,wordSpacing: 7.0),
                      )
                    ],
                  ),
                ),
            ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    SizeConfig().init(context);
    var iconButton = IconButton(icon: Icon(Icons.ac_unit), onPressed: () {},);
    return Scaffold(
      // bottomNavigationBar: Consumer<AuthBloc>(
      //   builder:(contex,trip,prev)=> bottomApp()
      // ),
      appBar: AppBar(
          title: Text('Lokasi Penumpang'),
          backgroundColor: Colors.blue[700],
      ),
      body:BaseWidget(
        model: AuthBloc(),
        onModelReady: (model){},
        builder: (context,model,_)=>
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
                      onPressed: openDialog,
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
              bottom: 20,
              child: Container(
                width: SizeConfig.blockWidth*95,
                height: 200,
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 10,right: 10),
                child: Consumer<TripBloc>(builder:(context,trip,_) {
                  trip.getCurrentTrip();
                  return trip.currentJob != null ?
                  CardPemesanan(
                      userUrl: "http://via.placeholder.com/50x50",
                      namaUser: 'A',
                      tgl: trip.currentJob.dateTime,
                      harga: trip.currentJob.harga.toString(),
                      jarak: trip.currentJob.distance.toString(),
                      lokasiAwal: trip.currentJob.origin,
                      lokasiAkhir: trip.currentJob.destination
                  ) : Container();
                }),
              ),
            ),
          ],
        ),
        
      )
      
    );
    
  }
}