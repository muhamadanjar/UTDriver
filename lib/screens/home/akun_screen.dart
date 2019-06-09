import 'package:flutter/material.dart';
import '../../data/rest_ds.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:ut_driver_app/data/database_helper.dart';
class ProfilePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ProfileView();
  }
}

class ProfileView extends StatefulWidget {
  @override
  _ProfileViewState createState() => _ProfileViewState();
}

const kExpandedHeight = 300.0;

class _ProfileViewState extends State<ProfileView> {
  BuildContext ctx;
  ScrollController _scrollController;
  String driverName;
  int totTrip,toYear;
  double rating;
  Map userData;
  RestDatasource _restDatasource = new RestDatasource();
  @override
  void initState() {
    super.initState();
    
    this.getUser();
  }
  void getUser() async{
    final _prefs = await SharedPreferences.getInstance();
    final token = _prefs.getString('token');
    dynamic userData = await _restDatasource.getUser(token);
    setState(() {
      rating = userData.rating;
      driverName = userData.name;
    });
  }
  void _signOut() async{
    print('Request Sign out');
    var db = new DatabaseHelper();
    final _pref = await SharedPreferences.getInstance();
    _pref.clear();
    db.deleteUsers();
    Navigator.pushReplacementNamed(ctx, '/login');

  }

  @override
  Widget build(BuildContext context) {
    ctx = context;
    return DefaultTabController(
      length: 1,
      child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: kExpandedHeight,
                floating: false,
                automaticallyImplyLeading: false,
                pinned: true,
                backgroundColor: Colors.black,
                // leading: GestureDetector(
                //   child: IconButton(
                //     onPressed: () => Navigator.pop(context),
                //     icon: Icon(Icons.arrow_back, size: 26, color: Colors.white),
                //   ),
                // ),
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit, size: 26, color: Colors.white),
                    onPressed: () {},
                  )
                ],
                flexibleSpace: FlexibleSpaceBar(
                  background: Stack(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(top: 100),
                        height: 300,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Center(
                          child: ProfileWidget(
                            onPressed: () =>{},
                            icon: Icons.star,
                            name: driverName.toString(),
                            rating: rating.toString(),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              )
            ];
          },
          body: Scaffold(
            body: Container(
              decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.all(Radius.circular(20))),
              child: ListView(
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Column(
                          children: <Widget>[
                            Text(
                              "3,914",
                              style: TextStyle(
                                fontSize: 34,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Trips",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                        Container(
                          height: 60,
                          width: 1,
                          decoration: BoxDecoration(
                              border: Border(
                                  right: BorderSide(color: Colors.black12))),
                        ),
                        Column(
                          children: <Widget>[
                            Text(
                              "4",
                              style: TextStyle(
                                fontSize: 34,
                              ),
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            Text(
                              "Years",
                              style:
                                  TextStyle(color: Colors.grey, fontSize: 16),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  Divider(),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      SizedBox(
                        height: 20,
                      ),
                      Text(
                        "Tell customers a little about yourself",
                        style: TextStyle(fontSize: 20),
                      ),
                      SizedBox(
                        height: 30,
                      ),
                      GestureDetector(
                        onTap: () {},
                        child: Container(
                            width: 200,
                            height: 60,
                            margin: EdgeInsets.only(bottom: 10),
                            alignment: FractionalOffset.center,
                            decoration: BoxDecoration(
                              border: Border.all(color: Colors.blue, width: 2),
                              color: Colors.white,
                              borderRadius:
                                  BorderRadius.all(const Radius.circular(4.0)),
                            ),
                            child: Text('ADD DETAILS',
                                style: TextStyle(
                                    color: Colors.blue,
                                    fontSize: 24,
                                    fontWeight: FontWeight.bold))),
                      ),
                      SizedBox(
                        height: 10,
                      ),
                    ],
                  ),
                  Divider(),
                  Padding(
                    padding: EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Text(
                          "Compliements",
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 22,
                              fontWeight: FontWeight.normal),
                        ),
                        Text(
                          "VIEW ALL",
                          style: TextStyle(
                              color: Colors.blue,
                              fontSize: 22,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  makeCompliementsList("Cool Car"),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 20),
                    child: Container(
                      child: FlatButton(
                        child: Text('Sign Out'),
                        color: Colors.blue,
                        onPressed: _signOut,
                      ),
                    ),
                  )
                ],
              ),
            ),
          )),
    );
  }
}

class FunctionalButton extends StatefulWidget {
  final String title;
  final IconData icon;
  final Function() onPressed;

  const FunctionalButton({Key key, this.title, this.icon, this.onPressed})
      : super(key: key);

  @override
  _FunctionalButtonState createState() => _FunctionalButtonState();
}

class _FunctionalButtonState extends State<FunctionalButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        RawMaterialButton(
          onPressed: widget.onPressed,
          splashColor: Colors.black,
          fillColor: Colors.blue,
          elevation: 15.0,
          shape: CircleBorder(),
          child: Padding(
              padding: EdgeInsets.all(12.0),
              child: Icon(
                widget.icon,
                size: 50.0,
                color: Colors.white,
              )),
        ),
        SizedBox(
          height: 10,
        ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
          child: Text(
            widget.title,
            style: TextStyle(fontSize: 20.0, color: Colors.white),
          ),
        ),
        SizedBox(
          height: 20,
        )
      ],
    );
  }
}

class ProfileWidget extends StatefulWidget {
  final String name, rating;
  final IconData icon;
  final Function() onPressed;

  const ProfileWidget(
      {Key key, this.name, this.rating, this.icon, this.onPressed})
      : super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}

class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: widget.onPressed,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: Image.asset(
                  "assets/avatar5.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ),
              ),
              SizedBox(
                height: 10,
              ),
              Container(
                margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                child: Text(
                  widget.name,
                  style: TextStyle(fontSize: 20.0, color: Colors.white),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                width: 160,
                height: 50,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    Text(widget.rating,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 22,
                            fontWeight: FontWeight.bold)),
                    SizedBox(
                      width: 5,
                    ),
                    Icon(
                      widget.icon,
                      color: Colors.black,
                      size: 22,
                    )
                  ],
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

  Widget makeCompliementsList(String title) {
    return Container(
      padding: EdgeInsets.only(left: 5, right: 5),
      height: 220,
      child: Column(
        children: <Widget>[
          Container(
            height: 200,
            child: ListView(
              padding: EdgeInsets.all(10),
              scrollDirection: Axis.horizontal,
              children: makeContainers(title),
            ),
          )
        ],
      ),
    );
  }

  int counter = 0;
  List<Widget> makeContainers(String title) {
    List<Container> compliementsList = [];
    for (var i = 0; i < 6; i++) {
      counter++;
      compliementsList.add(Container(
        margin: EdgeInsets.only(right: 10),
        child: Stack(
          children: <Widget>[
            Column(
              children: <Widget>[
                ClipOval(
                  child: Image.asset(
                    "assets/flutter.png",
                    width: 100,
                    height: 100,
                    fit: BoxFit.cover,
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 5.0, horizontal: 2.0),
                  child: Text(
                    title,
                    style: TextStyle(fontSize: 16.0, color: Colors.black),
                  ),
                ),
              ],
            ),
            Positioned(
              left: 68,
              top: -1,
              child: Container(
                width: 30,
                height: 30,
                decoration: BoxDecoration(
                  color: Colors.black,
                  border: Border.all(color: Colors.white),
                  borderRadius: BorderRadius.all(Radius.circular(50.0)),
                ),
                child: Center(
                                child: Text("1",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold)),
                ),
              ),
            ),
          ],
        ),
      ));
      if (counter == 12) {
        counter = 0;
      }
    }
    return compliementsList;
  }
