import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:ut_driver_app/components/button_full.dart';
import 'package:ut_driver_app/components/container_posisi.dart';
import 'package:ut_driver_app/components/form_inputs/functionButton.dart';
import 'package:ut_driver_app/theme/styles.dart';

class CardPemesanan extends StatelessWidget {
  String userUrl;
  String namaUser;
  DateTime tgl;
  String harga;
  String jarak;
  String lokasiAwal;
  String lokasiAkhir;
  CardPemesanan({this.userUrl,this.namaUser,this.tgl,this.harga,this.jarak,this.lokasiAwal,this.lokasiAkhir});
  @override
  Widget build(BuildContext context) {
    return Card(
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
                imageUrl: userUrl != null ? userUrl:"http://via.placeholder.com/50x50",
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
                          namaUser,
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 12),
                        ),
                      ),
                      SizedBox(height: 3.0,),
                      Text(
                        new DateFormat('d, MMMM y').format(tgl),
                        style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 10),
                      ),
                    ],
                  ),
                  Column(
                    children: <Widget>[
                      Text(
                        harga,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 10),
                      ),
                      SizedBox(height: 5,),
                      Text(
                        jarak,
                        style: TextStyle(color: Colors.grey[800],fontSize: 10),
                      ),
                    ],
                  )
                ],
              ),
            ),
          ),
          Column(
            children: <Widget>[

              ContainerPosisi(
                info: 'JEMPUT',
                lokasi: lokasiAwal,
              ),
              ContainerPosisi(
                info: 'TUJUAN',
                lokasi: lokasiAkhir,
              ),
            ],
          ),
          FunctionalButton(),
        ],
      ),
    );
  }
}
