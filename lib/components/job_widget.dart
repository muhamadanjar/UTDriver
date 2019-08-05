import 'package:flutter/material.dart';
import 'package:ut_driver_app/models/job.dart';
import 'job_card.dart';
class JobWidget extends StatefulWidget {

  Job job;
  JobWidget({this.job});

  @override
  _JobWidgetState createState() => _JobWidgetState();
}

class _JobWidgetState extends State<JobWidget> {
  
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Column(
        children: <Widget>[
          SizedBox(height: 10.0),
          ListView(
            scrollDirection: Axis.vertical,
            shrinkWrap: true,
            children: <Widget>[
              Hero(
                tag: 'driver-job',
                child: JobCard(job: widget.job),
              )
            ],
          )

        ],
      ),
    );
  }
}
