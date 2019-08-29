import 'dart:async';
import 'package:rxdart/subjects.dart';
import 'package:ut_driver_app/data/bloc/auth_bloc.dart';
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
  PublishSubject<String> token = new PublishSubject<String>();

  

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
