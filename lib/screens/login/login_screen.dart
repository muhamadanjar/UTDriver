import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:ut_driver_app/auth.dart';
import 'package:ut_driver_app/data/database_helper.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:ut_driver_app/screens/login/login_screen_presenter.dart';

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
      Navigator.of(_ctx).pushReplacementNamed("/home");

  }

  @override
  Widget build(BuildContext context) {
    _ctx = context;
   return new Scaffold(
      key: scaffoldKey,
      appBar: AppBar(
        title: Image(image:AssetImage("assets/flutter.png",),height: 30.0,fit: BoxFit.fitHeight,),
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
          Center(
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
                                              child: OutlineButton(
                                                child: Text("Login "),
                                                onPressed:_submit
                                              ),
                                              flex: 1,
                                            ),
                                            SizedBox(height: 18.0,width: 18.0,),
                                            SizedBox(height: 18.0,width: 18.0,),
                                            Expanded(
                                              flex: 1,
                                              child: OutlineButton(
                                                  //child: Text("login with google"),
                                                // child: ImageIcon(AssetImage("images/google1.png"),semanticLabel: "login",),
                                                  child: Image(image: AssetImage("assets/google1.png"),height:28.0,fit: BoxFit.fitHeight),
                                                  onPressed: (){
                            
                                                  }),
                                            )

                                          ],
                                    ),
                                    SizedBox(height: 15.0),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.center,
                                      children: <Widget>[
                                        Text(
                                          'New login with google?',
                                          style: TextStyle(fontFamily: 'Montserrat'),
                                        ),
                                        SizedBox(width: 5.0),
                                        InkWell(
                                          child: Text(
                                            'create new account',
                                            style: TextStyle(
                                                color: Colors.blue,
                                                fontFamily: 'Montserrat',
                                                fontWeight: FontWeight.bold,
                                                decoration: TextDecoration.underline),
                                          ),
                                        )
                                      ],
                                    ),
                                    OutlineButton(
                                        child: Text("signup"),
                                        onPressed: (){
                                          // Navigator.of(context).pushNamed('/signup');
                                        }),
                                  
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
          ),
        ],
      ) ,
    );
  }

  @override
  Widget buildOld(BuildContext context) {
    _ctx = context;
    var loginBtn = new RaisedButton(
      onPressed: _submit,
      child: new Text("LOGIN"),
      color: Colors.primaries[0],
    );
    final email = TextFormField(
      keyboardType: TextInputType.emailAddress,
      autofocus: false,
      initialValue: 'alucard@gmail.com',
      decoration: InputDecoration(
        hintText: 'Email',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );

    final password = TextFormField(
      autofocus: false,
      initialValue: 'some password',
      obscureText: true,
      decoration: InputDecoration(
        hintText: 'Password',
        contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 10.0),
        border: OutlineInputBorder(borderRadius: BorderRadius.circular(32.0)),
      ),
    );
    final forgotLabel = FlatButton(
      child: Text(
        'Forgot password?',
        style: TextStyle(color: Colors.black54),
      ),
      onPressed: () {},
    );
    var loginForm = new Column(
      children: <Widget>[
        new Text(
          "Login App",
          textScaleFactor: 2.0,
        ),
        new Form(
          key: formKey,
          child: new Column(
            children: <Widget>[
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _username = val,
                  validator: (val) {
                    return val.length < 10
                        ? "Username must have atleast 10 chars"
                        : null;
                  },
                  decoration: new InputDecoration(labelText: "Username"),
                ),
              ),
              new Padding(
                padding: const EdgeInsets.all(8.0),
                child: new TextFormField(
                  onSaved: (val) => _password = val,
                  decoration: new InputDecoration(labelText: "Password"),
                  obscureText: true,
                ),
              ),
            ],
          ),
        ),
        _isLoading ? new CircularProgressIndicator() : loginBtn
      ],
      crossAxisAlignment: CrossAxisAlignment.center,
    );

    return new Scaffold(
      appBar: null,
      key: scaffoldKey,
      body: new Container(
        decoration: new BoxDecoration(
          image: new DecorationImage(
              image: new AssetImage("assets/login_background.jpg"),
              fit: BoxFit.cover),
        ),
        child: new Center(
          child: new ClipRect(
            child: new BackdropFilter(
              filter: new ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
              child: new Container(
                child: loginForm,
                height: 300.0,
                width: 300.0,
                decoration: new BoxDecoration(
                    color: Colors.grey.shade200.withOpacity(0.5)),
              ),
            ),
          ),
        ),
      ),
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
      validator: (value)=>
      value.isEmpty ? validation: null,
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
}