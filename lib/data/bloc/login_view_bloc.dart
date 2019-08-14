import 'package:flutter/widgets.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:ut_driver_app/utils/authentication.dart';
import 'package:ut_driver_app/models/base_model.dart';

class LoginViewModel extends BaseModel {
  AuthenticationService _authenticationService;

  LoginViewModel({
    @required AuthenticationService authenticationService,
  }) : _authenticationService = authenticationService;

  Future<User> login(String username,password) async {
    setBusy(true);
    var success = await _authenticationService.login(username,password);
    setBusy(false);
    return success;
  }


}
