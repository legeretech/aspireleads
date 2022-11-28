import 'package:flutter/material.dart';
import 'package:glass_card/glass_card.dart';
import 'package:holacoin/workflow.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';
import 'package:holacoin/controller/controller.dart';


import '../campaignlist.dart';
import '../constants/Theme.dart';
import '../dashboard.dart';
import '../myleads.dart';
import '../profileinfo.dart';
import '../sendmessage.dart';
import '../todolist.dart';

class Dashboard extends StatefulWidget {
  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends StateMVC<Dashboard>
    with SingleTickerProviderStateMixin {
  AdminController? _con;

  _DashboardState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  AnimationController? _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  @override
  void initState() {
    // TODO: implement initState
    getUserId();
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _controller?.forward();
  }

  dispose() {
    super.dispose();
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user').toString();
      NAME = prefs.getString('name').toString();
    });
   // await _con!.getdashboard(userId);
  }



  late double width;
  late double height;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        body: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(1),
                  child: Container(
                      height: 500,
                      width: double.infinity,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                    AssetImage("assets/img/profile-screen-bg.png"),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: GestureDetector(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  PageTransition(
                                                      type: PageTransitionType.fade, child: Profileinfo()));
                                            },
                                            child: Icon(
                                              Icons.person,
                                              size: 26.0,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: GestureDetector(
                                            onTap: () {

                                            },
                                            child: Icon(
                                              Icons.doorbell,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Center(
                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Dashboard",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                      textAlign: TextAlign.left,
                                    ),
                                  )),

                            ],
                          )))),
              SizedBox.expand(
                child: SlideTransition(
                  position: _tween.animate(_controller!),
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.70,
                    minChildSize: 0.70,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return  Container(
                        padding: EdgeInsets.only(left: 15,right: 15),
                          decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30),
                      topRight: Radius.circular(30))),
                      child: Container(
                        height: 750.0,
                        margin: EdgeInsets.only(top:50),
                        child: Column(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade, child: CampaignList()));
                                    },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width /
                                        2.32,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 62,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: Colors.green[300],
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(10),
                                                  topRight:
                                                  Radius.circular(40),
                                                  bottomLeft:
                                                  Radius.circular(40),
                                                  bottomRight:
                                                  Radius.circular(40))),
                                          child: Center(
                                              child: Image.asset(
                                                "assets/icons/takeorder_w.png",
                                                height: 30,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10,
                                              left: 12,
                                              right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "My Campaigns",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 22,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                      color: primaryColor,
                                      borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          topRight: Radius.circular(40),
                                          bottomRight: Radius.circular(10),
                                          bottomLeft: Radius.circular(10)),
                                      // boxShadow: [shad]
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            type: PageTransitionType.fade, child: Myleads()));
                                  },
                                  child: Container(
                                    width: MediaQuery.of(context).size.width /
                                        2.32,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 62,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: Colors.blue[400],
                                              borderRadius: BorderRadius.only(
                                                  topLeft:
                                                  Radius.circular(10),
                                                  topRight:
                                                  Radius.circular(40),
                                                  bottomLeft:
                                                  Radius.circular(40),
                                                  bottomRight:
                                                  Radius.circular(40))),
                                          child: Center(
                                              child: Image.asset(
                                                "assets/icons/preorder_w.png",
                                                height: 30,
                                                color: Colors.white,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 5, right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment
                                                .spaceBetween,
                                            children: [
                                              Text(
                                                "My Leads",
                                                style:  TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,
                                                    fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              SizedBox(
                                                width: 1,
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 16,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[600],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(40),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        boxShadow: [BoxShadow(
                                            color: Colors.grey,blurRadius: 3,spreadRadius: 1
                                        )]),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width / 2.32,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 62,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: Colors.blue[400],
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(40),
                                                  bottomLeft: Radius.circular(40),
                                                  bottomRight:
                                                  Radius.circular(40))),
                                          child: Center(
                                              child: Image.asset(
                                                "assets/icons/invoice_w.png",
                                                height: 30,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 12, right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "My Tasks",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 22,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.blue[600],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(40),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        boxShadow: [BoxShadow(
                                            color: Colors.grey,blurRadius: 3,spreadRadius: 1
                                        )]
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width / 2.32,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 62,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(40),
                                                  bottomLeft: Radius.circular(40),
                                                  bottomRight:
                                                  Radius.circular(40))),
                                          child: Center(
                                              child: Image.asset(
                                                "assets/icons/return.png",
                                                height: 30,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 12, right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "My Report",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 13,fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 22,
                                                color: Colors.black,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(40),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        boxShadow: [BoxShadow(
                                            color: Colors.grey,blurRadius: 3,spreadRadius: 1
                                        )]
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 30,
                            ),
                            Row(
                              mainAxisAlignment:
                              MainAxisAlignment.spaceBetween,
                              children: [
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width / 2.32,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 62,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color: Colors.grey[300],
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(40),
                                                  bottomLeft: Radius.circular(40),
                                                  bottomRight:
                                                  Radius.circular(40))),
                                          child: Center(
                                              child: Image.asset(
                                                "assets/icons/return.png",
                                                height: 30,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 12, right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Call Logs",
                                                style: TextStyle(
                                                    color: Colors.grey[800],
                                                    fontSize: 13,fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 22,
                                                color: Colors.black,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: Colors.grey[200],
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(40),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        boxShadow: [BoxShadow(
                                            color: Colors.grey,blurRadius: 3,spreadRadius: 1
                                        )]
                                    ),
                                  ),
                                ),
                                InkWell(
                                  onTap: () {

                                  },
                                  child: Container(
                                    width:
                                    MediaQuery.of(context).size.width / 2.32,
                                    child: Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          height: 62,
                                          width: 65,
                                          decoration: BoxDecoration(
                                              color:  Colors.green[300],
                                              borderRadius: BorderRadius.only(
                                                  topLeft: Radius.circular(10),
                                                  topRight: Radius.circular(40),
                                                  bottomLeft: Radius.circular(40),
                                                  bottomRight:
                                                  Radius.circular(40))),
                                          child: Center(
                                              child: Image.asset(
                                                "assets/icons/wallet_w.png",
                                                height: 30,
                                              )),
                                        ),
                                        SizedBox(
                                          height: 15,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              bottom: 10, left: 12, right: 12),
                                          child: Row(
                                            mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                "Walk In Leads",
                                                style: TextStyle(
                                                    color: Colors.white,
                                                    fontSize: 13,fontWeight: FontWeight.w500
                                                ),
                                              ),
                                              Icon(
                                                Icons.arrow_forward,
                                                size: 22,
                                                color: Colors.white,
                                              )
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                    decoration: BoxDecoration(
                                        color: primaryColor,
                                        borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(10),
                                            topRight: Radius.circular(40),
                                            bottomRight: Radius.circular(10),
                                            bottomLeft: Radius.circular(10)),
                                        boxShadow: [BoxShadow(
                                            color: Colors.green,blurRadius: 3,spreadRadius: 1
                                        )]
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),);
                    },
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => new MyHome()));

        return false;
      },
    );
  }
}


