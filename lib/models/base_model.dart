import 'package:flutter/material.dart';
import 'package:ut_driver_app/models/user.dart';

class BaseModel extends ChangeNotifier {
  bool _busy = false;
  bool get busy => _busy;
  
  // User get user => _authenticatedUser;

  void setBusy(bool value) {
    _busy = value;
    notifyListeners();
  }
}


