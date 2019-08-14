
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/base_model.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
class AuthBloc extends BaseModel {

  RestDatasource _api;
  AuthBloc({@required RestDatasource api,}):_api = api;
  String name;
  String rating;
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

}