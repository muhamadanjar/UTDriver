import 'package:flutter/material.dart';
import 'package:ut_driver_app/theme/styles.dart';

class OrderDetailWidget extends StatelessWidget {
  final String terminal, game, boarding;

  OrderDetailWidget({this.terminal, this.game, this.boarding});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: <Widget>[
        buildDetailColumn("terminal", terminal),
        Spacer(),
        buildDetailColumn("game", game),
        Spacer(),
        buildDetailColumn("boarding", boarding),
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
