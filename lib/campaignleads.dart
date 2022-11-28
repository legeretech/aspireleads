import 'package:empty_widget/empty_widget.dart';
import 'package:flutter/material.dart';
import 'package:holacoin/profileinfo.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:flutter/services.dart';

import '../dashboard.dart';
import 'addnewlead.dart';
import 'filterrequest.dart';
import 'leaddetail.dart';

class CampaignLeads extends StatefulWidget {

  String id,title;

  CampaignLeads({required this.id,required this.title});

  @override
  _CampaignLeadsState createState() => _CampaignLeadsState();
}

class _CampaignLeadsState extends StateMVC<CampaignLeads>
    with SingleTickerProviderStateMixin {
  AdminController? _con;

  _CampaignLeadsState() : super(AdminController()) {
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
      businessId = prefs.getString('business_id').toString();
    });
    _con!.getleadsbycampagin(userId,businessId,widget.id);
  }


  late double width;
  late double height;
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          elevation: 5.0,
          bottomOpacity: 0.0,
          title: Text("Leads of campaign : "+widget.title,style: TextStyle(color: Colors.white,fontSize: 18),),
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
                    type: PageTransitionType.fade, child: AddNewLead()));
          },
          label: Text('Add Lead',style: TextStyle(color: Colors.white)),
          icon: Icon(Icons.add,color: Colors.white,),
          backgroundColor: Colors.blue,
        ) ,
        body:  Stack(
          children: [
            Column(
              children: [

                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Container(
                        padding: EdgeInsets.only(left: 30, right: 30),
                        child:  _con?.myleads != null
                            ?  ListView(
                          children: List.generate(
                              _con?.myleads.length,
                                  (index) => Column(children: [

                                Container(
                                  decoration: new BoxDecoration(
                                    color: Colors.blue[50],
                                    borderRadius: BorderRadius.all(Radius.circular(15)),
                                  ),
                                  child: Column(
                                    children: [
                                      ListTile(
                                          title: Text(_con!.myleads[index]['lead_name'].toString(),
                                              style: TextStyle(fontWeight: FontWeight.bold)),
                                          subtitle: Text('Qualification : '+_con!.myleads[index]['qualification'].toString()),
                                          trailing: Icon(
                                            Icons.arrow_forward,
                                            color: Colors.blue[400],
                                          ),
                                          onTap: () {

                                            Navigator.push(
                                                context,
                                                PageTransition(
                                                    type: PageTransitionType.fade, child: LeadDetail(id:_con!.myleads[index]['lead_id'].toString())));

                                          }
                                      ),
                                      Divider(color: Colors.grey,),
                                      Container(
                                        padding: EdgeInsets.only(top: 10,left: 10,bottom: 10),
                                        child: Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [

                                            Row(
                                              children: [

                                                Image.asset("images/time.png",width: 32.00,),

                                                SizedBox(width: 10,),

                                                Container(
                                                  child: Text(_con!.myleads[index]['follow_up_date'].toString(),style: TextStyle(fontSize: 16),),
                                                ),

                                              ],
                                            ),

                                            Container(
                                              margin: EdgeInsets.only(right: 10.00),
                                              padding:EdgeInsets.only(top:5.00,left:10.00,right: 10.00,bottom: 5.00),
                                              decoration: BoxDecoration(
                                                  color: Colors.blue,
                                                  border: Border.all(
                                                    color: Colors.blue,
                                                  ),
                                                  borderRadius: BorderRadius.all(Radius.circular(20))
                                              ),
                                              child: Text(_con!.myleads[index]['status_name'].toString(),style: TextStyle(fontSize: 16,color: Colors.white),),
                                            ),



                                          ],
                                        ),
                                      )

                                    ],
                                  ),
                                ),

                                SizedBox(height: 10),
                              ])),
                        ) : EmptyWidget(
                          image: null,
                          packageImage: PackageImage.Image_1,
                          title: 'No Data Found',
                          subTitle: 'No new leads available yet',
                          titleTextStyle: TextStyle(
                            fontSize: 22,
                            color: Color(0xff9da9c7),
                            fontWeight: FontWeight.w500,
                          ),
                          subtitleTextStyle: TextStyle(
                            fontSize: 14,
                            color: Color(0xffabb8d6),
                          ),
                        ))),
              ],
            )
          ],
        )

    );
  }
}
