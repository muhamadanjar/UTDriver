import 'package:flutter/material.dart';
import 'package:ut_driver_app/utils/constans.dart';

class EarningsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return EarningsView();
  }
}

class EarningsView extends StatefulWidget {
  @override
  _EarningsViewState createState() => _EarningsViewState();
}

const kExpandedHeight = 300.0;

class _EarningsViewState extends State<EarningsView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        height: SizeConfig.blockHeight *100,
        child: Stack(
          alignment: Alignment.topCenter,
          children: <Widget>[
            Container(
              width: MediaQuery.of(context).size.width,
              height: SizeConfig.blockHeight * 34,
              decoration: BoxDecoration(
                color: Colors.black,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          SizedBox(
                            width: 10,
                          ),
                          IconButton(
                            onPressed: ()=> Navigator.pop(context),
                            icon: Icon(
                              Icons.keyboard_backspace,
                              color: Colors.white,
                              size: 20,
                            ),
                          ),
                          SizedBox(
                            width: 10,
                          ),
                          Text(
                            "Earnings",
                            style: TextStyle(color: Colors.white, fontSize: 20),
                          )
                        ],
                      ),
                      Container(
                        padding: EdgeInsets.only(right: 20),
                        child: Icon(
                          Icons.help,
                          color: Colors.white,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Minggu ini",
                    style: TextStyle(color: Colors.white, fontSize: 22),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "\Rp. 3.60",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.bold),
                  )
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                margin: EdgeInsets.symmetric(horizontal: 30),
                width: double.infinity,
                height: SizeConfig.blockHeight * 70,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  boxShadow: [
                    BoxShadow(
                        color: Colors.black12,
                        blurRadius: 11,
                        offset: Offset(3.0, 4.0))
                  ],
                ),
                child: Column(
                  children: <Widget>[
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: ListTile(
                        onTap: () =>
                            Navigator.pushNamed(context, RoutePaths.EarningDetail),
                        title: Text("Earning Details",
                            style: TextStyle(fontSize: 20)),
                        subtitle: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text("Sep 17 - Sep 24",
                                style: TextStyle(fontSize: 16))),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: Icon(
                            Icons.lightbulb_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right,
                            color: Colors.black, size: 20),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: ListTile(
                        onTap: () =>Navigator.pushNamed(context, RoutePaths.RecentTransaction),
                        title: Text("Recent transactions",style: TextStyle(fontSize: 20)),
                        subtitle: Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Text("\$3.60 balance",style: TextStyle(fontSize: 16))),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(
                              color: Colors.blue, shape: BoxShape.circle),
                          child: Icon(
                            Icons.lightbulb_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right,
                            color: Colors.black, size: 20),
                      ),
                    ),
                    Divider(),
                    Padding(
                      padding: EdgeInsets.symmetric(vertical: 12),
                      child: ListTile(
                        onTap: () =>
                            Navigator.pushNamed(context, RoutePaths.Promotion),
                        title:Text("Promotions", style: TextStyle(fontSize: 20)),
                        subtitle: Container(
                          margin: EdgeInsets.only(top: 10),
                          child: Text("See what's available",style: TextStyle(fontSize: 16))
                        ),
                        leading: Container(
                          width: 40,
                          height: 40,
                          decoration: BoxDecoration(color: Colors.blue, shape: BoxShape.circle),
                          child: Icon(
                            Icons.lightbulb_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        trailing: Icon(Icons.chevron_right,color: Colors.black, size: 20),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
