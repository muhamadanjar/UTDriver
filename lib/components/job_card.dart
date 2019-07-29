import 'package:flutter/material.dart';
import 'package:ut_driver_app/theme/styles.dart';
import 'package:ut_driver_app/utils/constans.dart';
import '../models/job.dart';
import '../components/locationOrder.dart';
import '../components/detailOrder.dart';
class JobCard extends StatelessWidget {
  final Job job;

  const JobCard({Key key, this.job}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return 
    Container(
      height: 210.0,
      padding: EdgeInsets.symmetric(horizontal: 20.0, vertical: 10.0),
      child:Material(
        color: secondaryColor,
        elevation: 8.0 ,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
            onTap: (){
              Navigator.pushNamed(context, RoutePaths.Map);
            },
            child: Container(
              margin: const EdgeInsets.all(16.0),
              child: Row(
                children: <Widget>[
                  Expanded(
                    child: Column(
                      mainAxisSize: MainAxisSize.max,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            LocationWidget(
                              cityName: 'Medan',
                              time: '120min',
                            ),
                            Spacer(),
                            Icon(
                              Icons.crop_square,
                              color: Colors.white,
                              // size: 40.0,
                            ),
                            Spacer(),
                            LocationWidget(
                              cityName: 'Medan',
                              time: '120min',
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          height: 0.5,
                          color: Colors.white,
                        ),
                        SizedBox(height: 16.0),
                        OrderDetailWidget(
                          type: 'Rental',
                          jam: '12:00',
                          harga: 12,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(width: 10.0),
                  Container(
                    child: Image.asset(
                      "assets/google_map_vector.png",
                      width: 80.0,
                      color: Colors.white,
                    ),
                  )
                ],
              ),
            ),
          )
      )
    );
  }
}