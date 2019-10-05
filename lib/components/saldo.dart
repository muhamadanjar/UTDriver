import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/data/bloc/auth_bloc.dart';
import 'package:ut_driver_app/utils/constans.dart';

class Saldo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Consumer<AuthBloc>(
          builder:(context,model,_)=> new Container(
          height: 120.0,
          decoration: new BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
              ),
              borderRadius: new BorderRadius.all(new Radius.circular(3.0))
          ),
          child: new Column(
            children: <Widget>[
              new Container(
                padding: EdgeInsets.all(12.0),
                decoration: new BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [const Color(0xff3164bd), const Color(0xff295cb5)],
                    ),
                    borderRadius: new BorderRadius.only(
                        topLeft: new Radius.circular(3.0),
                        topRight: new Radius.circular(3.0))),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                     Text(
                      "Saldo",
                      style: new TextStyle(
                          fontSize: 18.0,
                          color: Colors.white,
                      ),
                    ),
                    Container(
                      child: new Text(
                        "",
                        style: new TextStyle(
                            fontSize: 14.0,
                            color: Colors.white,
                        ),
                      ),
                    )
                  ],
                ),
              ),
              new Container(
                padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 12.0),
                child: new Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset(
                          "assets/icons/icon_transfer.png",
                          width: 32.0,
                          height: 32.0,
                        ),
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        new Text(
                          "Transfer",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )
                      ],
                    ),
                    GestureDetector(
                      onTap: () => Navigator.pushNamed(context, RoutePaths.Topup),
                      child: new Column(

                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Image.asset(
                            "assets/icons/icon_saldo.png",
                            width: 32.0,
                            height: 32.0,
                          ),
                          new Padding(
                            padding: EdgeInsets.only(top: 10.0),
                          ),
                          new Text(
                            "Isi Saldo",
                            style: TextStyle(color: Colors.white, fontSize: 12.0),
                    
                          )
                        ],
                      ),
                    ),
                    
                    
                    new Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        new Image.asset(
                          "assets/icons/icon_menu.png",
                          width: 32.0,
                          height: 32.0,
                        ),
                        new Padding(
                          padding: EdgeInsets.only(top: 10.0),
                        ),
                        new Text(
                          "Lainnya",
                          style: TextStyle(color: Colors.white, fontSize: 12.0),
                        )
                      ],
                    ),
                  ],
                ),
              )
            ],
          )),
    );
  }
}