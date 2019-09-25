import 'package:flutter/material.dart';

class ButtonFull extends StatelessWidget {
  Function onPress;
  Color color;
  String text;

  ButtonFull({@required this.text,@required this.color,@required this.onPress});
  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
              constraints: const BoxConstraints(minWidth: double.infinity),
              child: Padding(
                padding: const EdgeInsets.only(left:3,right: 3),
                child: RaisedButton(
                  onPressed: onPress,
                  child: Text(text,style: TextStyle(color: Colors.white),),
                  color: color,
                  shape: RoundedRectangleBorder(borderRadius: new BorderRadius.circular(10.0))
                ),
              ),
      );
  }
}