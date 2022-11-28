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

class PendingForVerification extends StatefulWidget {
  @override
  _PendingForVerificationState createState() => _PendingForVerificationState();
}

class _PendingForVerificationState extends StateMVC<PendingForVerification> {
  AdminController? _con;

  late String imageUrl;

  _PendingForVerificationState() : super(AdminController()) {
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
      "job_precess" : "Test Process 1",
      "client" : "Test Client 1",
      "assigned_user" : "Test User",
      "manager" : "super admin",
      "partner" : "test admin",
      "start_date" : "02/10/2022",
      "end_date" : "20/10/2022"
    },
    {
      "job_precess" : "Test Process 2",
      "client" : "Test Client 2",
      "assigned_user" : "Test User",
      "manager" : "manager admin",
      "partner" : "test admin",
      "start_date" : "05/10/2022",
      "end_date" : "20/10/2022"
    },
    {
      "job_precess" : "Test Process 3",
      "client" : "Test Client 3",
      "assigned_user" : "Test demo User",
      "manager" : "demo admin",
      "partner" : "test demo admin",
      "start_date" : "04/10/2022",
      "end_date" : "18/10/2022"
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
        title: Text("Pending For Verification",style: TextStyle(color: Colors.white,fontSize: 18),),
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
                  shrinkWrap: false,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 250, //
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
                                    "Job Process ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 50,),
                                  Text(
                                    '${items[key]['job_precess']}',
                                    textAlign: TextAlign.center,
                                  )
                                ],
                              ),
                            ),

                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top:5),
                                child:Row(
                                  //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "Client",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50),
                                    Text(
                                      '${items[key]['client']}',
                                      textAlign: TextAlign.center,

                                    )
                                  ],
                                )),
                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top:5),
                                child:Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "Assigned User",
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
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "Manager",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50,),
                                    Text(
                                      '${items[key]['manager']}',
                                      textAlign: TextAlign.left,

                                    )
                                  ],
                                )),
                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top:5),
                                child:Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                  //mainAxisSize: MainAxisSize.max,
                                  children: <Widget>[
                                    Text(
                                      "Partner",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50,),
                                    Text(
                                      '${items[key]['partner']}',
                                      textAlign: TextAlign.left,

                                    )
                                  ],
                                )),
                            SizedBox(height: 10),
                            Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top:5),
                                child:Row(
                                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                                      "End Date",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50,),
                                    Text(
                                      '${items[key]['end_date']}',
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
