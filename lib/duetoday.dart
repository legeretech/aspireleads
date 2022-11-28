import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:holacoin/LoginPage.dart';
import 'package:holacoin/editprofile.dart';
import 'package:intl/intl.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';
import 'package:image_picker/image_picker.dart';
import 'package:simple_s3/simple_s3.dart';
import 'dart:async';
import 'dart:io';
import 'dashboard.dart';
import 'package:firebase_storage/firebase_storage.dart';

var country_name = "";

class Duetoday extends StatefulWidget {

  String title;
  Duetoday({required this.title});

  @override
  _DuetodayState createState() => _DuetodayState();
}

class _DuetodayState extends StateMVC<Duetoday> {
  AdminController? _con;

  late String imageUrl;

  _DuetodayState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  bool isLoading = false;
  bool uploaded = false;

  void initState() {
    //  _showSheet();

    // TODO: implement initState
    getUserId();
    super.initState();
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user').toString();
      NAME = prefs.getString('name').toString();
    });
    _con!.getuserinfo(userId);
  }

  List items = [
    {
      "client" : "Test Client 1",
      "subject" : "Tax Audit",
      "assigned_user" : "Test User",
      "start_date" : "02/10/2022",
      "priority" : "High"
    },
    {
      "client" : "Test Client 2",
      "subject" : "Tax Audit",
      "assigned_user" : "User2234",
      "start_date" : "10/10/2022",
      "priority" : "Normal"
    },
    {
      "client" : "Test Client 3",
      "subject" : "Tax Audit",
      "assigned_user" : "User22234",
      "start_date" : "15/10/2022",
      "priority" : "Medium"
    },

  ];

  bool autovalidate = false;

  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 5.0,
        bottomOpacity: 0.0,
        title: Text(widget.title,style: TextStyle(color: Colors.white,fontSize: 18),),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            //   Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PersonalSettings()));
          },
        ),
      ),
      backgroundColor: Color(0xFFF8F8F9),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top:20,left: 20,right: 20),
              child: GridView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: false,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 200, //
                  ),
                  itemCount: items.length,
                  itemBuilder: (BuildContext context, int key) {
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.white,
                        elevation: 6.0,
                        child: Column(

                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 20,right: 20,top:20),
                              child:Row(
                              //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                //mainAxisSize: MainAxisSize.max,
                                children: <Widget>[
                                  Text(
                                    "Client ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 50,),
                                  Text(
                                    '${items[key]['client']}',
                                    textAlign: TextAlign.left,
                                  )
                                ],
                              ),
                            ),

                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top:5),
                                child:Row(
                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "Subject",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50,),
                                    Text(
                                      '${items[key]['subject']}',
                                      textAlign: TextAlign.left,

                                    )
                                  ],
                                )),
                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top:5),
                                child:Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "Assignee",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50,),
                                    Text(
                                      '${items[key]['assigned_user']}',
                                      textAlign: TextAlign.left,

                                    )
                                  ],
                                )),
                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top:5),
                                child:Row(
                                 // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "Start Date",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50,),
                                    Text(
                                      '${items[key]['start_date']}',
                                      textAlign: TextAlign.left,

                                    )
                                  ],
                                )),
                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top:5),
                                child:Row(
                                //  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "Priority",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50,),
                                    Text(
                                      '${items[key]['priority']}',
                                      textAlign: TextAlign.left,
                                    )
                                  ],
                                )),

                          ],
                        )


                    );
                  }),
            ),
          ),
        ],
      ),
    );
  }
}
