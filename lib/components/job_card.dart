import 'package:flutter/material.dart';
import 'package:ut_driver_app/theme/styles.dart';
import '../models/job.dart';
class JobCard extends StatelessWidget {
  final Job job;
  

  JobCard({@required this.job});
  @override
  Widget build(BuildContext context) {
    return InkWell(
          child: Container(
            margin: const EdgeInsets.all(16.0),
            child: Row(
              children: <Widget>[
                // Expanded(
                //   child: Column(
                //     mainAxisSize: MainAxisSize.max,
                //     children: <Widget>[
                //       Row(
                //         children: <Widget>[
                //           Spacer(),
                //           Icon(
                //             Icons.crop_square,
                //             color: Colors.white,
                //             // size: 40.0,
                //           ),
                //           Spacer(),
                //         ],
                //       )
                //     ],
                //   ),
                // ),
                // SizedBox(width: 10.0),
                // Container()
              ],
            ),
          ),
        );
  }
}