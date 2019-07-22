import 'package:flutter/material.dart';
import 'package:ut_driver_app/theme/styles.dart';

class OrderDetailWidget extends StatelessWidget {
  final String type, jam;
  final int harga;

  OrderDetailWidget({this.type, this.harga, this.jam});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildDetailColumn("type", type),
        Spacer(),
        buildDetailColumn("harga", harga.toString()),
        Spacer(),
        buildDetailColumn("jam", jam),
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
