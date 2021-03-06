import 'dart:convert';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/components/profile_tile.dart';
import 'package:ut_driver_app/data/bloc/topup_bloc.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:ut_driver_app/theme/styles.dart';

class TopupScreen extends StatefulWidget {
  @override
  _TopupScreenState createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  final _key = new GlobalKey<FormState>();
  String amount;
  Future<File> imageFile;
  String status = '';
  String base64Image;
  File tmpFile;
  String errMessage = 'Error Uploading Image';
  String page = 'konfirmasi';
  String noRek;
  String totTrans;
  User userData;
  RestDatasource rs = new RestDatasource();
  @override
  Widget build(BuildContext context) {
    final up = Provider.of<User>(context);
    final pageSuccess = Container(

        child:Column(
          mainAxisAlignment: MainAxisAlignment.center,

          children: <Widget>[
            Icon(
              Icons.info,
              size: 100.0,
              color: Colors.blue,
            ),
            SizedBox(
              height: 20.0,
            ),
            ProfileTile(
              title: "Pembayaran Berhasil",
              subtitle: "Mohon tunggu proses oleh CS Kami",
            )
          ],
        ),
    );
    return Scaffold(
        appBar: AppBar(
          backgroundColor: primaryColor,
          title: Text("Topup"),
          actions: <Widget>[
            IconButton(
              icon: Icon(Icons.help),
              onPressed: () {},
              color: Colors.white,
            )
          ],
        ),
        body: BaseWidget<TopUpBloc>(
          model: TopUpBloc(api: Provider.of(context)),
          builder: (context,model,child)=>
           page == 'success'?pageSuccess:ListView(
            children: <Widget>[
            Container(
              margin: EdgeInsets.only(top: 30),
              child: Form(
                key: _key,
                child: Column(children: <Widget>[
                  Container(
                    padding: new EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        new Text("No Rekening: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                        new Container(
                          padding: new EdgeInsets.all(16.0),
                        ),
                        TextFormField(
                          onSaved: (val)=>noRek=val,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'No Rekening & Atas Nama Transfer',
                              contentPadding: EdgeInsets.all(10.0)

                          ),
                        
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: new EdgeInsets.all(16.0),
                    child: Column(
                      children: <Widget>[
                        new Text("Jumlah Transfer: ",style: TextStyle(fontSize: 20,fontWeight: FontWeight.w800),),
                        new Container(
                          padding: new EdgeInsets.all(16.0),
                        ),
                        TextFormField(
                          onSaved: (val)=>totTrans=val,
                          keyboardType: TextInputType.number,
                          decoration: InputDecoration(
                              hintText: 'Nominal ',
                              contentPadding: EdgeInsets.all(10.0)

                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 10,),
                  Container(
                    padding: new EdgeInsets.all(10.0),
                    child: Column(
                      children: <Widget>[
                        ButtonBar(
                          children: <Widget>[

                            IconButton(
                              icon: Icon(Icons.photo),
                              onPressed: ()=> pickImageFromGallery(ImageSource.gallery),
                              tooltip: "Ambil dari Kamera",
                            ),

                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.all(15.0),
                    child: showImage(),
                  ),
                  SizedBox(
                    height: 15.0,
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 12.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              SizedBox(
                                height: 23,
                                child: Text('16K',style: TextStyle(color: Colors.white, fontSize: 12.0),
                                ),
                              ),
                            ],
                        ),
                      ],
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10,right: 26.0),
                    child: model.busy ? CircularProgressIndicator():RaisedButton(
                      color: Colors.blue,
                      child: Text("Konfirmasi Pembayaran",style: TextStyle(color: Colors.white),),
                      onPressed: (){
                        final form = _key.currentState;
                        if (form.validate()) {
                          form.save();
                          String fileName = tmpFile.path.split('/').last;
                          var data = {
                            "image": base64Image,
                            "name": "fileName",
                            "req_file": fileName,
                            "req_saldo": "90",
                            "req_norek": "90",
                          };
                          // print(userData.token);
                          var res =model.konfirmasi(data);
                          print("res : ${res}");
                          // if(res['status']){
                          //   setState(() {
                          //     page ='success';
                          //   });
                          // }
                            
                        }
                        
                        
                        // startUpload(userData.token);
                      },
                    ),
                  )
                ],
                ),
              ),
          ),
      ],
          ),
        ),
    );
  }
  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done && null != snapshot.data) {
          tmpFile = snapshot.data;
          base64Image = base64Encode(snapshot.data.readAsBytesSync());
          return Container(
            child: Image.file(
              snapshot.data,
              fit: BoxFit.fill,
            ),
          );
        } else if (null != snapshot.error) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    
  }

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }
  
  
  setStatus(String message) {
    setState(() {
      status = message;
    });
  }
  startUpload(token) {
    print("start upload ${token}");
    setStatus('Uploading Image...');
    if (null == tmpFile) {
      setStatus(errMessage);
      return;
    }
    String fileName = tmpFile.path.split('/').last;
    upload(fileName);
  }

  upload(String fileName,) {
    var data ={
        "image": base64Image,
        "name": fileName,
        "req_file": fileName,
        "req_saldo": totTrans,
        "req_norek": noRek,
        "req_bank": noRek,
    };
    rs.uploadbukti(data).then((result) {
      print("result ${result}");
      if(result['status']){
        setState(() {
          page = 'success';
        });
      }
      setStatus(result.message);
    }).catchError((error) {
      print(error);
      setStatus(error);
    });
  }
}