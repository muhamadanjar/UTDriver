import 'package:flutter/material.dart';
import 'package:ut_driver_app/theme/styles.dart';

class OrderDetailWidget extends StatelessWidget {
  final String type, harga, jam;

  OrderDetailWidget({this.type, this.harga, this.jam});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildDetailColumn("terminal", jam),
        Spacer(),
        buildDetailColumn("game", harga),
        Spacer(),
        buildDetailColumn("boarding", jam),
      ],
    );
  }

  Widget buildDetailColumn(String label, String value) => Column(
    crossAxisAlignment: CrossAxisAlignment.start,
    mainAxisSize: MainAxisSize.max,
    children: <Widget>[
      Text(label.toUpperCase(), style: smallTextStyle),
      Text(value, style: smallBoldTextStyle),
    ],
  );
}
