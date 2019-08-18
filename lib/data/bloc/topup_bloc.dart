
import 'dart:io';

import 'package:image_picker/image_picker.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/base_model.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
class TopUpBloc extends BaseModel {

  RestDatasource _api;
  TopUpBloc({@required RestDatasource api,}):_api = api;
  
  String errMessage = 'Error Uploading Image';
  String page = 'konfirmasi';
  String noRek;
  String totTrans;

  @override
  void dispose() {
    print("disposing topup");
    
    super.dispose();
  }

  

  konfirmasi(data){
    setBusy(true);
    print("data : ${data}");
    _api.uploadbukti(data).then((val)=>print(val));

    setBusy(false);
  }
  

}