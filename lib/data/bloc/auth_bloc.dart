
import 'package:geolocator/geolocator.dart';
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/base_model.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
class AuthBloc extends BaseModel {

  RestDatasource _api;
  AuthBloc({@required RestDatasource api,}):_api = api;
  String name;
  String rating;
  Position userPosition;
  bool userStatus;
  @override
  void dispose() {
    print("disposing auth");
  
    super.dispose();
  }

  Future getUser() async {
    setBusy(true);
    _api.getUser();
    setBusy(false);
  }

  Future updatePosition(Position position) async{
    try {
      setBusy(true);
      await _api.updateLocation(position.latitude.toString(), position.longitude.toString());
      userPosition = position;
      setBusy(false);
    } catch (e) {
      print('Error Position :'+ e);
    }
    
  }

  Future updateStatus(bool status) async{
    try{
      setBusy(true);
      _api.changeStatusOnline(status.toString());
      userStatus = status;
      setBusy(false);

    }catch (e){}
  }

}