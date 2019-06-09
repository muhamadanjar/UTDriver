import 'package:flutter/material.dart';

class TopupScreen extends StatefulWidget {
  @override
  _TopupScreenState createState() => _TopupScreenState();
}

class _TopupScreenState extends State<TopupScreen> {
  final _key = new GlobalKey<FormState>();
  String amount;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Form(
        key: _key,
        child: Column(children: <Widget>[
          TextFormField(
            autofocus: true,
            decoration: InputDecoration(
              hintText: 'Amount',
              contentPadding: EdgeInsets.fromLTRB(20.0, 10.0, 20.0, 20.0),
              border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.0)
              ),
            ),
            validator: (value) {
              if (value.isEmpty) {
                return 'Please enter some amount';
              }
            },
            onSaved: (val)=> amount = val,
          ),
          SizedBox(
            height: 15.0,
          ),
          Container(
            padding: EdgeInsets.only(left: 32.0, right: 32.0, top: 12.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: <Widget>[
                new Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 23,
                        child: Text('16K',style: TextStyle(color: Colors.white, fontSize: 12.0),
                        ),
                      ),
                    ],
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: RaisedButton(
              onPressed: (){},
              color: Colors.blue,
              textColor: Colors.white,
              child: Text('Proses'),
            ),
          )
        ],
        ),
      ),
    );
  }
}