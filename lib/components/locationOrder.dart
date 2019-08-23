import 'package:flutter/material.dart';
import '../theme/styles.dart';
class LocationWidget extends StatelessWidget {
  final String cityName,subtitle;

  LocationWidget(
      {@required this.cityName,
        @required this.subtitle});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(cityName, style: smallTextStyle),
        SizedBox(height: 2.0),
        Text(subtitle, style: mediumTextStyle),
      ],
    );
  }
}