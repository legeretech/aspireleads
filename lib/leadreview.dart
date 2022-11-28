import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:holacoin/dashboard.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';


import 'leadeditdetail.dart';

var country_name = "";

class LeadReview extends StatefulWidget {

  String id;

  LeadReview({required this.id});
  @override
  _LeadReviewState createState() => _LeadReviewState();
}

class _LeadReviewState extends StateMVC<LeadReview> {
  AdminController? _con;

  late String imageUrl;

  _LeadReviewState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  bool isLoading = false;
  bool uploaded = false;

  void initState() {
    //  _showSheet();
    _con!.getleadinfo(widget.id);
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

  }

  _launchCaller() async {
    final Uri url = Uri.parse("tel:+918138000410");
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    } else {
      await launchUrl(url);
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: LeadReview(id:widget.id)));
    }
  }

  bool autovalidate = false;

  File? selectedFile;

  String? review_id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 5.0,
        bottomOpacity: 0.0,
        title: Text("Lead Review",style: TextStyle(color: Colors.white,fontSize: 18),),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            //   Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PersonalSettings()));
          },
        ),
      ),
      bottomNavigationBar: BottomAppBar(
          child: Container(
            margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
            child: MaterialButton(
              onPressed: () {
                Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: MyHome()));
              },
              color: Colors.blue,
              padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
              elevation: 2,
              shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              child: Text(
                "Submit",
                style: TextStyle(
                    fontSize: 14, letterSpacing: 2.2, color: Colors.white),
              ),
            ),
          )),
      backgroundColor: Color(0xFFF8F8F9),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top:20,left: 20,right: 20),
              child: Column(
                children: [
                  ListTile(
                    title: const Text('Call Connected'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "1",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Don Not Pick'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "2",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Busy in another call'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "3",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('User disconnected the call'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "4",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Switch Off'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "5",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Out of coverage area'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "6",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Call cannot be completed'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "7",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Other reason'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "8",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Incorrect / Invalid number'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "9",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Incoming calls not available'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "10",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                  ListTile(
                    title: const Text('Number not in use'),
                    leading: Radio(
                      fillColor: MaterialStateColor.resolveWith((states) => Color(0XFFB63728)),
                      value: "11",
                      groupValue: review_id,
                      onChanged: (value) {
                        setState(() {
                          review_id = value.toString();
                        });
                      },
                    ),
                  ),
                ],
              ),



            ),
          ),
        ],
      ),
    );
  }
}
