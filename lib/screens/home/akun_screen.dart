import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:ut_driver_app/components/base_widget.dart';
import 'package:ut_driver_app/data/bloc/auth_bloc.dart';
import 'package:ut_driver_app/data/bloc/login_view_bloc.dart';
import 'package:ut_driver_app/models/user.dart';
import 'package:ut_driver_app/theme/styles.dart';
import 'package:ut_driver_app/utils/constans.dart';
import '../../data/rest_ds.dart';
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
  final GlobalKey<RefreshIndicatorState> _refreshIndicatorKey =new GlobalKey<RefreshIndicatorState>();
  @override
  void initState() {
    super.initState();
    
  }
  
  void _signOut() async{
    print('Request Sign out');
    _restDatasource.logout();
    Navigator.pushReplacementNamed(ctx, RoutePaths.Login);

  }
  
  @override
  Widget build(BuildContext context) {
    var userData = Provider.of<AuthBloc>(context);
    ctx = context;
    return DefaultTabController(
      length: 1,
      child: NestedScrollView(
          controller: _scrollController,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverAppBar(
                expandedHeight: 300,
                floating: false,
                automaticallyImplyLeading: false,
                pinned: true,
                backgroundColor: Colors.blue,
                actions: <Widget>[
                  IconButton(
                    icon: Icon(Icons.edit, size: 26, color: Colors.white),
                    onPressed: () {
                      Navigator.pushNamed(context, RoutePaths.EditProfile);
                    },
                  )
                ],
                flexibleSpace:BaseWidget(
                  model: AuthBloc(),
                    onModelReady: (model){
                      model.getUser();
                    },
                    builder:(context,auth,_)=> 
                    FlexibleSpaceBar(background: 
                    Stack(
                      children: <Widget>[
                        Container(
                          margin: EdgeInsets.only(top: 100),
                          height: 300,
                          decoration: BoxDecoration(color: secondaryColor),
                          child: Center(
                            child: ProfileWidget(
                              onPressed: () =>{},
                              icon: Icons.star,
                              name: auth.user == null ? "user":auth.user.name,
                              rating: auth.user == null ? "0.0":auth.user.rating.toString(),
                              photoUrl: null,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              )
            ];
          },
          body: RefreshIndicator(
            key: _refreshIndicatorKey,
            onRefresh: (){},
            child: Scaffold(
              body: BaseWidget(
                model: AuthBloc(),
                onModelReady: (model){},
                builder:(context,model,child){
                  return Container(
                    decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                    child: ListView(
                      children: <Widget>[
                        infoWidget(context),
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
                              height: 20,
                            ),
                            Container(
                                width: 200,
                                height: 40,
                                margin: EdgeInsets.only(bottom: 5),
                                alignment: FractionalOffset.center,
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.blue, width: 2),
                                  color: Colors.white,
                                  borderRadius:BorderRadius.all(const Radius.circular(2.0)),
                                ),
                                child: Text('Tambah Keterangan',style: TextStyle(color: Colors.blue,fontSize: 15,fontWeight: FontWeight.bold))),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                        Divider(),
                        Column(
                          children: <Widget>[
                            Padding(
                              padding: EdgeInsets.all(20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: <Widget>[
                                  Text(
                                    "Tanggapan",
                                    style: TextStyle(
                                        color: Colors.black,
                                        fontSize: 18,
                                        fontWeight: FontWeight.normal),
                                  ),
                                  Text(
                                    "Lihat Semua",
                                    style: TextStyle(
                                        color: Colors.blue,
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ],
                              ),
                            ),
                            makeCompliementsList("Cool Car"),
                          ],
                        ),
                        containerLogout(),
                      ],
                    ),
                  );
                },
              ),
            ),
          )),
    );
  }

  Widget infoWidget(BuildContext context){
    return Consumer<AuthBloc>(
      builder: (context,auth,_)=> Padding(
        padding: EdgeInsets.symmetric(vertical: 20),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Column(
              children: <Widget>[
                // Text(
                //   auth.user != null ? auth.user.totalTrip.toString():'0',
                //   style: TextStyle(
                //     fontSize: 30,
                //   ),
                // ),
                SizedBox(
                  height: 5,
                ),
                Text(
                  "Trips",
                  style:TextStyle(color: Colors.grey, fontSize: 16),
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
            InkWell(
              onTap: (){;
                Navigator.pushNamed(context, RoutePaths.Topup);
              },
              child: Column(
                children: <Widget>[
                  Text(
                    '0',
                    style: TextStyle(
                      fontSize: 30,
                    ),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    "Saldo",
                    style:TextStyle(color: Colors.grey, fontSize: 16),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget containerLogout(){
    return  Padding(
      padding: EdgeInsets.only(left:20,right: 20),
      child: Container(
        child: InkWell(
          onTap: (){
            Navigator.of(context).pushReplacementNamed(RoutePaths.Login);
            Provider.of<AuthBloc>(context, listen: false).logout();
          },
          child: Container(
              width: 200,
              height: 38,
              margin: EdgeInsets.only(bottom: 10),
              alignment: FractionalOffset.center,
              decoration: BoxDecoration(
                border: Border.all(color: Colors.blue, width: 1),
                color: Colors.white,
                borderRadius:
                BorderRadius.all(const Radius.circular(2.0)),
              ),
              child: Text('Keluar',
                  style: TextStyle(
                      color: Colors.blue,
                      fontSize: 18,
                      fontWeight: FontWeight.bold))),
        ),
      ),
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
  final String name, rating,photoUrl;
  final IconData icon;
  final Function() onPressed;

  const ProfileWidget({Key key, this.name, this.rating, this.icon,this.photoUrl, this.onPressed}): super(key: key);

  @override
  _ProfileWidgetState createState() => _ProfileWidgetState();
}
class _ProfileWidgetState extends State<ProfileWidget> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onPressed,
      child: Stack(
        children: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              ClipOval(
                child: widget.photoUrl == null ? Image.asset(
                  "assets/avatar5.png",
                  width: 100,
                  height: 100,
                  fit: BoxFit.cover,
                ):NetworkImage(widget.photoUrl),
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
                    style: TextStyle(fontSize: 16.0, color: Colors.blue),
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
