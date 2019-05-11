import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
class HomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(title: new Text("Home"),),
      body: new Center(
        child: new Text("Welcome home!"),
      ),
    );
  }

}

// class HomeScreenState extends State<HomeScreen> {
  
// }