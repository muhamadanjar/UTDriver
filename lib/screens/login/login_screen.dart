import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/auth.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/data/bloc/login_view_bloc.dart';
import 'package:ut_driver_app/data/database_helper.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:ut_driver_app/screens/login/login_screen_presenter.dart';
import 'package:ut_driver_app/utils/constans.dart';
class LoginScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen>
    implements LoginScreenContract, AuthStateListener {
  BuildContext _ctx;

  bool _isLoading = false;
  final formKey = new GlobalKey<FormState>();
  
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  String _username, _password;

  LoginScreenPresenter _presenter;

  LoginScreenState() {
    _presenter = new LoginScreenPresenter(this);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  void _submit() {
    final form = formKey.currentState;
    if (form.validate()) {
      setState(() => _isLoading = true);
      form.save();
      print(_username + " "+ _password);
      _presenter.doLogin(_username, _password);
    }
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }

  @override
  onAuthStateChanged(AuthState state) {
    print(state);
    if(state == AuthState.LOGGED_IN)
      Navigator.of(_ctx).pushReplacementNamed(RoutePaths.Home);

  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
   return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Driver Utama Trans'),
        elevation: 8.0,
        centerTitle: true,
        backgroundColor: Colors.transparent,

      ),
      body:
      ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 220.0,
            width: 110.0,
            decoration: BoxDecoration(
                image: DecorationImage(
                    image: AssetImage('assets/monkey.gif'),
                    fit: BoxFit.cover),
              borderRadius: BorderRadius.only
                (
                  bottomLeft: Radius.circular(500.0),
                  bottomRight: Radius.circular(500.0)
              ),
           ),
          ),
          BaseWidget<LoginViewModel>(
            model: LoginViewModel(authenticationService: Provider.of(context)),
            child: null,
            builder: (context, model, child){
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(28.0),
                  child: Center(
                      child: Form(
                        key: formKey,
                        child: Center(
                          child: ListView(
                            shrinkWrap: true,
                            children: <Widget>[
                              _input("required username",false,"Email",'Username',(value) => _username = value),
                              SizedBox(width: 20.0,height: 20.0,),
                              _input("required password",true,"Password",'Password',(value) => _password = value),
                              new Padding(padding: EdgeInsets.all(8.0),
                                child: Center(
                                  child: Padding(
                                    padding: const EdgeInsets.all(8.0),
                                    child: Column(
                                      children: <Widget>[
                                        Row(
                                          children: <Widget>[
                                            Expanded(
                                              child: model.busy ? CircularProgressIndicator():MaterialButton(
                                                minWidth: 264,
                                                height: 48,
                                                color: Color(0xFF00bbff),
                                                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                                                child: Text("Log In",style:TextStyle(color: Colors.white),),
                                                onPressed:(){
                                                  final form = formKey.currentState;
                                                  if (form.validate()) {
                                                    form.save();
                                                    print("data $_username $_password");

                                                    model.login(_username, _password).then((user){
                                                      onLoginSuccess(user);
                                                    }).catchError((Object error)=>onLoginError(error));

                                                    // model.login(_username, _password).then((user){
                                                    //   Navigator.of(context).pushReplacementNamed(DashboardPage.tag);
                                                    // });


                                                  }
                                                }
                                              ),
                                              flex: 1,
                                            ),
                                          ],
                                        ),
                                        SizedBox(height: 15.0),    
                                      ],

                                    ),

                                  ),
                                ),
                              ),

                            ],

                          ),
                        ),
                      )
                  ),
                ),
              );
            },
          ),
          
        ],
      ) ,
    );
  }

  Widget _input(String validation,bool ,String label,String hint, save ){
    return new TextFormField(
      decoration: InputDecoration(
          hintText: hint,
          labelText: label,
          contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
          border: OutlineInputBorder(
              borderRadius: BorderRadius.circular(20.0)
          ),

      ),
      obscureText: bool,
      validator: (value)=>value.isEmpty ? validation: null,
      onSaved: save ,

    );

  }
  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    setState(() => _isLoading = false);
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.toString());
    setState(() => _isLoading = false);
    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }

  @override
  void dispose() {

    super.dispose();
  }
}