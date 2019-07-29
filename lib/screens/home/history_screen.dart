import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/models/history.dart';
import 'package:ut_driver_app/theme/styles.dart';
import 'package:intl/intl.dart';
import 'package:ut_driver_app/data/bloc/history_bloc.dart';

final formatCurrency = NumberFormat.simpleCurrency();
class HistoryScreen extends StatefulWidget {
  @override
  _HistoryScreenState createState() => _HistoryScreenState();
}

class _HistoryScreenState extends State<HistoryScreen> {
  HistoryBloc historyBloc;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(left: 16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(
              'History Pemesanan',
              style: dropDownMenuItemStyle,
            ),
          ),
          SizedBox(
            height: 10.0,
          ),
          BaseWidget<HistoryBloc>(
            model: HistoryBloc(api: Provider.of(context)),
            onModelReady: (model)=>model.getHistory(1),
            builder: (context,model,child)=>model.busy ?
              Center(
                child: CircularProgressIndicator(),
              ):
              _buildDealsList(context,model.history)
          )
        ],
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
                  Wrap(
                    spacing: 8.0,
                    runSpacing: -8.0,
                    children: <Widget>[
                      FlightDetailChip(
                          Icons.calendar_today, '${hisDetails.date}'),
                      FlightDetailChip(
                          Icons.flight_takeoff, '${hisDetails.airlines}'),
                      FlightDetailChip(Icons.star, '${hisDetails.rating}'),
                    ],
                  )
                ],
              ),
            ),
          ),
          Positioned(
            top: 10.0,
            right: 0.0,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
              child: Text(
                '${hisDetails.discount}%',
                style: TextStyle(
                    color: appTheme.primaryColor,
                    fontSize: 14.0,
                    fontWeight: FontWeight.bold),
              ),
              decoration: BoxDecoration(
                color: discountBackgroundColor,
                borderRadius: BorderRadius.all(
                  Radius.circular(10.0),
                ),
              ),
            ),
          )
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

