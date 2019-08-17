import 'dart:async';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/auth.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/components/ui/adaptive_progress_indicator.dart';
import 'package:ut_driver_app/data/bloc/auth_bloc.dart';
import 'package:ut_driver_app/data/bloc/login_view_bloc.dart';
import 'package:ut_driver_app/data/database_helper.dart';
import 'package:ut_driver_app/data/enum/authMode.dart';
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
    implements AuthStateListener {
  BuildContext _ctx;
  AnimationController _controller;
  Animation<Offset> _slideAnimation;
  final TextEditingController _passwordTextController = TextEditingController();
  AuthMode _authMode = AuthMode.Login;
  final formKey = new GlobalKey<FormState>();  
  final scaffoldKey = new GlobalKey<ScaffoldState>();
  final Map<String, dynamic> _formData = {
    'username': null,
    'email': null,
    'password': null,
    'acceptTerms': false
  };


  LoginScreenState() {
    var authStateProvider = new AuthStateProvider();
    authStateProvider.subscribe(this);
  }

  DecorationImage _buildBackgroundImage() {
    return DecorationImage(
      fit: BoxFit.cover,
      colorFilter:
          ColorFilter.mode(Colors.black.withOpacity(0.5), BlendMode.dstATop),
      image: AssetImage('assets/background.jpg'),
    );
  }

  void _showSnackBar(String text) {
    scaffoldKey.currentState
        .showSnackBar(new SnackBar(content: new Text(text)));
  }
  void _submitForm(Function authenticate) async {
    if (!formKey.currentState.validate()) {
      return;
    }
    formKey.currentState.save();
    
    // if (form.validate()) {
    //   form.save();
    //   print("data $_username $_password");
    //   model.login(_username, _password).then((user){
    //     onLoginSuccess(user);
    //   }).catchError((Object error)=>onLoginError(error));
    Map<String, dynamic> successInformation;
    print(_formData);
    successInformation = await authenticate(_formData['username'], _formData['password'],_authMode);
    if (successInformation['success']) {
      onLoginSuccess(successInformation['data']);
      // Navigator.pushReplacementNamed(context, '/');
    } else {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('An Error Occurred!'),
            content: Text(successInformation['message']),
            actions: <Widget>[
              FlatButton(
                child: Text('Okay'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              )
            ],
          );
        },
      );
    }
  }


  @override
  onAuthStateChanged(AuthState state) {
    print(state);
    if(state == AuthState.LOGGED_IN)
      Navigator.pushReplacementNamed(_ctx, RoutePaths.Home);

  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
    final form =Form(
      key: formKey,
      child: Center(
        child: ListView(
          shrinkWrap: true,
          children: <Widget>[
            _buildEmailTextField(),
            SizedBox(width: 20.0,height: 20.0,),
            _buildPasswordTextField(),
          ]
        )
      )
    );
    return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Text('Driver Utama Trans'),
        elevation: 8.0,
        centerTitle: true,
        backgroundColor: Colors.blue,

      ),
      body:ListView(
        shrinkWrap: true,
        children: <Widget>[
          Container(
            height: 220.0,
            width: 110.0,
            decoration: BoxDecoration(
              image: DecorationImage(image: AssetImage('assets/monkey.gif'),fit: BoxFit.cover),
              borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(500.0),
                  bottomRight: Radius.circular(500.0)
              ),
           ),
          ),
          BaseWidget<AuthBloc>(
            model: AuthBloc(api: Provider.of(context)),
            child: form,
            builder: (context, model, child){
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(5.0),
                    child: child,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Material(
                      child: model.busy ? AdaptiveProgressIndicator():MaterialButton(
                        minWidth: 350,
                        height: 41,
                        color: Colors.lightBlueAccent,
                        onPressed: ()=>_submitForm(model.authenticate),
                        child: Text("Log In",style: TextStyle(color: Colors.white,fontWeight: FontWeight.bold),),
                      ),
                    ),
                  ),
                  
                ],
                
              );
            },
          ),
          
        ],
      ) ,
    );
  }

  @override
  void onLoginError(String errorTxt) {
    _showSnackBar(errorTxt);
    
  }

  @override
  void onLoginSuccess(User user) async {
    _showSnackBar(user.toString());
    var db = new DatabaseHelper();
    await db.saveUser(user);
    var authStateProvider = new AuthStateProvider();
    authStateProvider.notify(AuthState.LOGGED_IN);
  }

  @override
  void dispose() {

    super.dispose();
  }

  Widget _buildEmailTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'E-Mail', filled: true, fillColor: Colors.white),
      keyboardType: TextInputType.emailAddress,
      validator: (String value) {
        if (value.isEmpty ||
            !RegExp(r"[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?")
                .hasMatch(value)) {
          return 'Please enter a valid email';
        }
      },
      onSaved: (String value) {
        _formData['email'] = value;
        _formData['username'] = value;
      },
    );
  }

  Widget _buildPasswordTextField() {
    return TextFormField(
      decoration: InputDecoration(
          labelText: 'Password', filled: true, fillColor: Colors.white),
      obscureText: true,
      controller: _passwordTextController,
      validator: (String value) {
        if (value.isEmpty || value.length < 6) {
          return 'Password invalid';
        }
      },
      onSaved: (String value) {
        _formData['password'] = value;
      },
    );
  }

  Widget _buildPasswordConfirmTextField() {
    return FadeTransition(
      opacity: CurvedAnimation(parent: _controller, curve: Curves.easeIn),
      child: SlideTransition(
        position: _slideAnimation,
        child: TextFormField(
          decoration: InputDecoration(
              labelText: 'Confirm Password',
              filled: true,
              fillColor: Colors.white),
          obscureText: true,
          validator: (String value) {
            if (_passwordTextController.text != value &&
                _authMode == AuthMode.Signup) {
              return 'Passwords do not match.';
            }
          },
        ),
      ),
    );
  }

  Widget _buildAcceptSwitch() {
    return SwitchListTile(
      value: _formData['acceptTerms'],
      onChanged: (bool value) {
        setState(() {
          _formData['acceptTerms'] = value;
        });
      },
      title: Text('Accept Terms'),
    );
  }

}