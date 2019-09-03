import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/material.dart' as prefix0;
import 'package:flutter/rendering.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'dart:async';

import 'package:ut_driver_app/components/custom_dialog.dart';
import 'package:ut_driver_app/components/form_inputs/functionButton.dart';
import 'package:ut_driver_app/components/network.dart';
import 'package:ut_driver_app/data/bloc/auth_bloc.dart';
import 'package:ut_driver_app/models/job.dart';
import 'package:ut_driver_app/theme/styles.dart';
import 'package:ut_driver_app/utils/constans.dart';
class MapScreen extends StatefulWidget {
  Job job;
  MapScreen({Key key , @required this.job}):super(key:key);
  
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
        "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua.",
        buttonText: "Okay",
      ),
    );
  }

  Widget infoWidget(){
    return  Card(
      color: Colors.white,
      elevation: 12,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      ),
      child: Column(
        children: <Widget>[
          ListTile(
            leading: Container(
              padding: EdgeInsets.only(right: 12.0),
              decoration: new BoxDecoration(
                  border: new Border(
                      right: new BorderSide(width: 1.0, color: Colors.white24))),
              child: CachedNetworkImage(
                    imageUrl: "http://via.placeholder.com/50x50",
                    placeholder: (context, url) => new CircularProgressIndicator(),
                    errorWidget: (context, url, error) => new Icon(Icons.error),
              ),
            ),
            title: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: <Widget>[
                      Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Customer 1",
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),
                        ),
                      ),
                      SizedBox(height: 3.0,),
                      Text(
                        "Selasa, 3 September 2019",
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        "120.000",
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        "12 Km",
                        style: TextStyle(color: Colors.grey[800],fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            ),

          ),
          Container(
            padding: EdgeInsets.all(4.0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("JEMPUT", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blueGrey)),
                SizedBox(height: 2.0),
                Text("Titik Jemput",style: TextStyle(fontSize: 13),),
                Container(
                  color: Colors.blueGrey,
                  height: 0.8,
                )
              ],
            ),
          ),
          Container(
            padding: EdgeInsets.all(4.0),
            alignment: Alignment.topLeft,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                Text("TUJUAN", style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blueGrey)),
                SizedBox(height: 2.0),
                Text("Titik Jemput",style: TextStyle(fontSize: 13),),
                Container(
                  color: Colors.blueGrey,
                  height: 0.8,
                )
              ],
            ),
          ),
          
          ConstrainedBox(
            constraints: const BoxConstraints(minWidth: double.infinity),
            child: Padding(
              padding: const EdgeInsets.only(left:3,right: 3),
              child: RaisedButton(
                onPressed: (){},
                child: Text('Proses',style: TextStyle(color: Colors.white),),
                color: secondaryColor,
                shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
              ),
            ),
          )
        ],
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
              bottom: 10,
              child: Container(
                width: SizeConfig.blockWidth*95,
                height: 200,
                color: Colors.transparent,
                margin: EdgeInsets.only(left: 10,right: 10),
                child: infoWidget(),
              ),
            )

          ],
        ),
        
      )
      
    );
    
  }
}