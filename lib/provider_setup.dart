import 'package:provider/provider.dart';
import 'package:ut_driver_app/data/bloc/history_bloc.dart';
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
  ChangeNotifierProvider.value(
    value: AuthBloc(),
  ),
];

List<SingleChildCloneableWidget> dependentServices = [
  ProxyProvider<RestDatasource, AuthenticationService>(
    builder: (context, api, authenticationService) => AuthenticationService(api: api),
  ),
  ChangeNotifierProxyProvider<AuthBloc, HistoryBloc>(
    builder: (context, auth, previousHistory) => HistoryBloc(
          auth.token,
          auth.userId,
          previousHistory == null ? [] : previousHistory.history,
        ),
  ),
];

List<SingleChildCloneableWidget> uiConsumableProviders = [

  StreamProvider<User>(
    builder: (context) => Provider.of<AuthenticationService>(context, listen: false).user,
  ),
  StreamProvider<ConnectivityStatus>.value(
    value: ConnectivityService().connectivityController.stream,
  ),

];


