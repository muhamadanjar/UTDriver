import 'dart:async';
import 'package:ut_driver_app/data/database_helper.dart';

import '../models/user.dart';
import '../data/rest_ds.dart';

class AuthenticationService {
  RestDatasource _api;
  DatabaseHelper _databaseHelper;

  AuthenticationService({RestDatasource api,DatabaseHelper database}){
    _api = api;
    _databaseHelper = database;
  } 

  StreamController<User> _userController = StreamController<User>();

  Stream<User> get user => _userController.stream;

  Future<User> getUser() async {
    var d = _databaseHelper.getAllClients();
    print(d);
    var fetchedUser = await _api.getUser();
    var hasUser = fetchedUser != null;
    if (hasUser) {
      _userController.add(fetchedUser);
    }
    return fetchedUser;
  }

  Future<User> login(String username,String password) async{
    var fetchUser = await _api.login(username, password);
    print("data login : ${fetchUser}");
    var hasUser = fetchUser != null;
    if(hasUser){
      _userController.add(fetchUser);
    }
    return fetchUser;
  }

  
}
