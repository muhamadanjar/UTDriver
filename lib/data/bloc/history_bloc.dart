
import 'package:meta/meta.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/base_model.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
class HistoryBloc extends BaseModel {

  RestDatasource _api;
  BehaviorSubject HistController = new BehaviorSubject();
  Sink get hisSink => HistController.sink;
  Stream get hisStream => HistController.stream;

  List history;
  HistoryBloc({@required RestDatasource api,}):_api = api;

  @override
  void dispose() {
    print("disposing history");
    HistController.close();
//    super.dispose();
  }

  Future getHistory(int userId) async {
    setBusy(true);
    history = await _api.getHistory();
    setBusy(false);
  }

}