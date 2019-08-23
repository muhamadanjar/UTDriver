
import 'dart:convert';

import 'package:native_widgets/native_widgets.dart';
import 'package:ut_driver_app/models/history.dart';

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
  List<HisDetails> _history;
  HistoryBloc(this.authToken,this.userId,this._history);

  // @override
  // void dispose() {
  //   print("disposing history");
  //   // _controller.close();
  // }

  List<HisDetails> get history {
    return [..._history];
  }

  Future getHistory() async {
    // setBusy(true);
    final url = "${apiURL}/trip/history";
    try {
      final response = await http.get(url,
        headers: {'Content-Type': 'application/json','Authorization': 'Bearer ${authToken}'},
      );
      _history.clear();
      final responseData = json.decode(response.body);
      if (responseData['status']) {
         (responseData["data"] as List).forEach((f){
          var data = HisDetails.fromJson(f);
          print(f);
          _history.add(data);
        });
      }

    } catch (e) {
    }
    // setBusy(false);
  }

}