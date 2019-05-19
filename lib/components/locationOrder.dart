import 'package:flutter/material.dart';
import '../theme/styles.dart';
class LocationWidget extends StatelessWidget {
  final String cityName, time;

  LocationWidget(
      {@required this.cityName,
        @required this.time});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(cityName, style: smallTextStyle),
        SizedBox(height: 2.0),
        Text(time, style: mediumTextStyle),
      ],
    );
  }
}