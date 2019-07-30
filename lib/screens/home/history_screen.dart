import 'dart:async';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/models/history.dart';
import 'package:ut_driver_app/theme/styles.dart';
import 'package:intl/intl.dart';
import 'package:ut_driver_app/data/bloc/history_bloc.dart';

final formatCurrency = NumberFormat.simpleCurrency(locale: "id_ID");
final formatDate = DateFormat.yMMMd('en_us');
class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryBloc historyBloc;
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey = new GlobalKey<RefreshIndicatorState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

        title: Text('History'),

      ),
      body: BaseWidget<HistoryBloc>(
          model: HistoryBloc(api: Provider.of(context)),
          onModelReady: (model)=>model.getHistory(1),
          builder: (context,model,child)=>model.busy ?
            Center(
              child: CircularProgressIndicator(),
            ):
            RefreshIndicator(
              onRefresh: _onRefresh,
              child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: model.history.length,
                  physics: ClampingScrollPhysics(),
                  scrollDirection: Axis.vertical,
                  itemBuilder: (context, index) {

                    return HisCard(hisDetails : model.history[index]);
                  }
              ) ,
            )


      ),

    );
  }

  Widget _buildDealsList(BuildContext context,snapshots) {
    return ListView.builder(
        shrinkWrap: true,
        itemCount: snapshots.length,
        physics: ClampingScrollPhysics(),
        scrollDirection: Axis.vertical,
        itemBuilder: (context, index) {
          return HisCard(hisDetails : snapshots[index]);
        }
    );
  }

  Future<Null> _onRefresh() {
    Completer<Null> completer = new Completer<Null>();
    Timer timer = new Timer(new Duration(seconds: 3), () {
      completer.complete();
    });
    return completer.future;
  }

}

class HisCard extends StatelessWidget {
  final HisDetails hisDetails;

  HisCard({this.hisDetails});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Stack(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.only(right: 16.0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.all(
                Radius.circular(10.0),
              ),
              border: Border.all(color: hisBorderColor),
            ),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Container(
                        decoration: BoxDecoration(
                          border: Border.all(width: 3.0),
                          color: Colors.blueAccent,
                        ),
                        child: Text("Promo",style: TextStyle(color: Colors.white),),
                      ),
                      Text("${(hisDetails.date)}")
                    ],
                  ),
                  SizedBox(height: 10,),
                  Container(
                    height: 2,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 20,),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                    Text("${hisDetails.origin}"),
                    SizedBox(height: 5.0,),
                    Text("${hisDetails.origin}"),
                  ],
                  ),
                  SizedBox(height: 10,),
                  Row(
                    children: <Widget>[
                      Text(
                        '${formatCurrency.format(hisDetails.tripTotal)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20.0,
                        ),
                      ),
                      SizedBox(
                        width: 4.0,
                      ),
                      Text(
                        "(${formatCurrency.format(hisDetails.tripTotal)})",
                        style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            decoration: TextDecoration.lineThrough,
                            color: Colors.grey),
                      ),
                    ],
                  ),

                ],
              ),
            ),
          ),
//          Positioned(
//            top: 10.0,
//            right: 0.0,
//            child: Container(
//              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
//              child: Text(
//                '${hisDetails.discount}%',
//                style: TextStyle(
//                    color: appTheme.primaryColor,
//                    fontSize: 14.0,
//                    fontWeight: FontWeight.bold),
//              ),
//              decoration: BoxDecoration(
//                color: discountBackgroundColor,
//                borderRadius: BorderRadius.all(
//                  Radius.circular(10.0),
//                ),
//              ),
//            ),
//          )
        ],
      ),
    );
  }
}
class FlightDetailChip extends StatelessWidget {
  final IconData iconData;
  final String label;

  FlightDetailChip(this.iconData, this.label);

  @override
  Widget build(BuildContext context) {
    return RawChip(
      label: Text(label),
      labelStyle: TextStyle(color: Colors.black, fontSize: 14.0),
      backgroundColor: chipBackgroundColor,
      avatar: Icon(
        iconData,
        size: 14.0,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(10.0),
        ),
      ),
    );
  }
}

