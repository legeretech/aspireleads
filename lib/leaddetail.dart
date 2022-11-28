import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:io';


import 'leadeditdetail.dart';
import 'leadreview.dart';

var country_name = "";

class LeadDetail extends StatefulWidget {

  String id;

  LeadDetail({required this.id});
  @override
  _LeadDetailState createState() => _LeadDetailState();
}

class _LeadDetailState extends StateMVC<LeadDetail> {
  AdminController? _con;

  late String imageUrl;

  _LeadDetailState() : super(AdminController()) {
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

  _launchCaller(mobile) async {
    final Uri url = Uri.parse("tel:"+mobile);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 5.0,
        bottomOpacity: 0.0,
        title: Text("Lead Details",style: TextStyle(color: Colors.white,fontSize: 18),),
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back, color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
            //   Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PersonalSettings()));
          },
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              PageTransition(
                  type: PageTransitionType.fade, child: LeadEditDetail(id:widget.id)));
        },
        label: Text('Edit Lead',style: TextStyle(color: Colors.white)),
        icon: Icon(Icons.edit,color: Colors.white,),
        backgroundColor: Colors.blue,
      ) ,
      backgroundColor: Color(0xFFF8F8F9),
      body: Column(
        children: [
          Expanded(
            child: Container(
              padding: EdgeInsets.only(top:20,left: 20,right: 20),
              child:  _con?.LeadData != null
                  ? GridView.builder(
                  shrinkWrap: false,
                  scrollDirection: Axis.vertical,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 1,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                    mainAxisExtent: 250, //
                  ),
                  itemCount: _con?.LeadData.length,
                  itemBuilder: (BuildContext context, int key) {
                    return Card(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        color: Colors.blue[50],
                        elevation: 6.0,
                        child: Column(

                          children: [

                            Padding(
                              padding: EdgeInsets.only(left: 20,right: 20,top:20),
                              child:Row(
                                 // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                //mainAxisSize: MainAxisSize.max,
                                children: <Widget>[

                                  Text(
                                    "Lead Name ",
                                    textAlign: TextAlign.left,
                                    style: TextStyle(fontWeight: FontWeight.bold),
                                  ),
                                  SizedBox(width: 50,),
                                  Text(
                                    '${_con?.LeadData[key]['lead_name'].toString()}',
                                    textAlign: TextAlign.center,
                                  ),



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
                                      "Qualification",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 45),
                                    Text(
                                      '${_con?.LeadData[key]['qualification']}',
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
                                      "Follow Up Date",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 30,),
                                    Text(
                                      '${_con?.LeadData[key]['follow_up_date']}',
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
                                      "Phone Number",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 30,),
                                    Text(
                                      '${_con?.LeadData[key]['phone_number']}',
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
                                      "Campaign Id",
                                      textAlign: TextAlign.left,
                                      style: TextStyle(fontWeight: FontWeight.bold),
                                    ),
                                    SizedBox(width: 50,),
                                    Text(
                                      '${_con?.LeadData[key]['campaign_id']}',
                                      textAlign: TextAlign.left,

                                    )
                                  ],
                                )),
                            SizedBox(height: 10),

                                Padding(
                                padding: EdgeInsets.only(left: 20,right: 20,top:5),
                                child: Container(
                                  margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
                                  child: MaterialButton(
                                    onPressed: () {
                                      _launchCaller(_con?.LeadData[key]['phone_number'].toString());
                                    },
                                    color: Colors.blue,
                                    padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                                    elevation: 2,
                                    shape:
                                    RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                                    child: Text(
                                      "Start Call",
                                      style: TextStyle(
                                          fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                                    ),
                                  ),
                                )
                                ),




                          ],
                        )


                    );

                  }): EmptyWidget(
                image: null,
                packageImage: PackageImage.Image_1,
                title: 'No Data Found',
                subTitle: 'No lead detail available yet',
                titleTextStyle: TextStyle(
                  fontSize: 22,
                  color: Color(0xff9da9c7),
                  fontWeight: FontWeight.w500,
                ),
                subtitleTextStyle: TextStyle(
                  fontSize: 14,
                  color: Color(0xffabb8d6),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
