
import 'package:native_widgets/native_widgets.dart';

import '../../utils/constans.dart';
import 'package:rxdart/rxdart.dart';
import '../../models/base_model.dart';
import 'package:ut_driver_app/data/rest_ds.dart';
import 'package:http/http.dart' as http;
class HistoryBloc extends BaseModel {
  BehaviorSubject _controller = new BehaviorSubject();
  Sink get hisSink => _controller.sink;
  Stream get hisStream => _controller.stream;
  final String authToken;
  final String userId;
  List _history;
  HistoryBloc(this.authToken,this.userId,this._history);

  @override
  void dispose() {
    print("disposing history");
    _controller.close();
  }

  List get history {
    return [..._history];
  }

  Future getHistory(String userId) async {
    setBusy(true);
    final url = "${apiURL}/trip/history";
    try {
      final response = await http.get(url,
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer ${authToken}'},
      );
      print(response);
    } catch (e) {
    }
    setBusy(false);
  }

}