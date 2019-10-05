import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/components/button_full.dart';
import 'package:ut_driver_app/components/container_posisi.dart';
import 'package:ut_driver_app/data/bloc/auth_bloc.dart';
import 'package:ut_driver_app/data/bloc/trip_bloc.dart';
import 'package:ut_driver_app/theme/styles.dart';
import 'package:ut_driver_app/utils/constans.dart';

class CardPemesanan extends StatelessWidget {
  String userUrl;
  // String namaUser;
  // DateTime tgl;
  // String harga;
  // String jarak;
  // String lokasiAwal;
  // String lokasiAkhir;
  Function onPress;
  String textButton;
  CardPemesanan({this.userUrl,this.onPress,this.textButton});
  // CardPemesanan({this.userUrl,this.namaUser,this.tgl,this.harga,this.jarak,this.lokasiAwal,this.lokasiAkhir,this.onPress,this.textButton});
  @override
  Widget build(BuildContext context) {
    return BaseWidget(
      model: TripBloc(Provider.of<AuthBloc>(context).token),
      onModelReady: (model){
        model.getCurrentTrip();
      },
      builder: (context,model,prev) {
      print(model.currentJob.toString());
      var curDist ='0';
      if (model.currentJob != null) {
        // curDist = new Length.fromMeters(value:(model.currentJob.distance).toDouble()).inKilometers.toString();
      }else{
        curDist = '0';
      }
      
      return model.currentJob == null ? Container(): Card(
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
                  imageUrl: userUrl,
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
                            model.currentJob.customer == null ? 'Current User':model.currentJob.customer,
                            style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 14),
                          ),
                        ),
                        SizedBox(height: 3.0,),
                        Text( 
                          new DateFormat('d, MMMM y').format(model.currentJob.dateTime),
                          style: TextStyle(color: Colors.grey,fontWeight: FontWeight.bold,fontSize: 13),
                        ),
                      ],
                    ),
                    Column(
                      children: <Widget>[
                        Text(
                          NumberFormat.compact().format(model.currentJob.harga),
                          style: TextStyle(color: Colors.black,fontWeight: FontWeight.bold,fontSize: 13),
                        ),
                        SizedBox(height: 5,),
                        Text(
                          "$curDist Km",
                          style: TextStyle(color: Colors.grey[800],fontSize: 13),
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
                  lokasi: model.currentJob.origin,
                ),
                ContainerPosisi(
                  info: 'TUJUAN',
                  lokasi: model.currentJob.destination,
                ),
              ],
            ),
            ButtonFull(onPress: (){
              model.incrementStatus();
              var status = model.tripStatus;
              var keyButton = model.checkStatus(status);
              textButton = keyButton;
              print(status);
              print(keyButton);
              model.setTextButton(keyButton);
              if(keyButton == 'STATUS_COMPLETE' || keyButton =='STATUS_CANCELED' || keyButton == 'STATUS_DECLINE'){
                Navigator.pushReplacementNamed(context, RoutePaths.Home);
              }else{
                model.changeStatusTrip(status);
              }
            },color: secondaryColor,text: model.textButton,),
          ],
        ),
      );
      }
    );
  }
}
