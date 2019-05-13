import 'package:ut_driver_app/data/rest_ds.dart';
import 'package:ut_driver_app/models/UserLogin.dart';

abstract class LoginScreenContract {
  void onLoginSuccess(UserLogin user);
  void onLoginError(String errorTxt);
}

class LoginScreenPresenter {
  LoginScreenContract _view;
  RestDatasource api = new RestDatasource();
  LoginScreenPresenter(this._view);

  doLogin(String username, String password) {
    
    api.login(username, password).then((user) {
      print('print user');
      print(user);
      _view.onLoginSuccess(user);
    }).catchError((Exception error) => _view.onLoginError(error.toString()));

    
  }
}