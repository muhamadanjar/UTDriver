import 'package:flutter/material.dart';

class ContainerPosisi extends StatelessWidget {
  final String info;
  final String lokasi;
  ContainerPosisi({this.info,this.lokasi});
  @override
  Widget build(BuildContext context) {
    return Container(
              padding: EdgeInsets.all(4.0),
              alignment: Alignment.topLeft,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text(info, style: TextStyle(fontSize: 14,fontWeight: FontWeight.bold,color: Colors.blueGrey)),
                  SizedBox(height: 2.0),
                  Text(lokasi,style: TextStyle(fontSize: 13),),
                  Container(
                    color: Colors.blueGrey,
                    height: 0.8,
                  )
                ],
              ),
    );
  }
}