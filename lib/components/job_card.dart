import 'package:flutter/material.dart';
import 'package:ut_driver_app/screens/home/map_screen.dart';
import 'package:ut_driver_app/theme/styles.dart';
import '../models/job.dart';
import '../components/locationOrder.dart';
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
        color: primaryColor,
        elevation: 8.0 ,
        borderRadius: BorderRadius.all(Radius.circular(8.0)),
        child: InkWell(
            onTap: (){
              Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) =>MapScreen(job: job),
                  ),
              );

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
                              cityName: job == null ? "":job.origin,
                              subtitle: 'Penjemputan',
                            ),
                          ],
                        ),
                        SizedBox(height: 16.0),
                        Container(
                          height: 0.5,
                          color: Colors.white,
                        ),
                        SizedBox(height: 16.0),
                        Row(
                          children: <Widget>[
                            LocationWidget(
                              cityName: job == null ? "-":job.destination,
                              subtitle: 'Tujuan',
                            ),
                          ],
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