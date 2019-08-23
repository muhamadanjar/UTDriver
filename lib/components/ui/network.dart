
import 'package:ut_driver_app/data/enum/connection_status.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/utils/constans.dart';

class NetworkWidget extends StatelessWidget {
  const NetworkWidget({
    Key key,
    this.child,
  }) : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    var network = Provider.of<ConnectivityStatus>(context);
    SizeConfig().init(context);

    if (network == ConnectivityStatus.wifi ||
        network == ConnectivityStatus.mobileData) {
      return Container(
        child: child,
      );
    }

    return Container(
      height: SizeConfig.blockHeight*100,
      width: SizeConfig.blockHeight*100,
      child:Text("Tidak ada koneksi")
    );
  }
}
