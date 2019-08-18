import 'package:provider/provider.dart';
import 'package:ut_driver_app/data/database_helper.dart';
import 'package:ut_driver_app/utils/prefs.dart';


import 'data/bloc/auth_bloc.dart';
import 'models/user.dart';
import 'utils/authentication.dart';
import 'data/rest_ds.dart';
import 'utils/connectivity.dart';
import 'data/enum/connection_status.dart';


List<SingleChildCloneableWidget> providers = [
  ...independentServices,
  ...dependentServices,
  ...uiConsumableProviders,
];

List<SingleChildCloneableWidget> independentServices = [
  Provider.value(value: RestDatasource()),
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<RestDatasource, AuthenticationService>(
    builder: (context, api, authenticationService) => AuthenticationService(api: api),
  ),

];

List<SingleChildCloneableWidget> uiConsumableProviders = [

  StreamProvider<User>(
    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
  ),
  ChangeNotifierProvider.value(
    value: AuthBloc(),
  ),
  StreamProvider<ConnectivityStatus>.value(
    value: ConnectivityService().connectivityController.stream,
  ),

];


