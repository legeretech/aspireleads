import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:flutter/services.dart';
import 'dart:io';
import 'dart:convert';
import 'package:holacoin/api/api.dart';
import 'package:http/http.dart' as http;


class AddNewLead extends StatefulWidget {

  @override
  _AddNewLeadState createState() => _AddNewLeadState();
}

class _AddNewLeadState extends StateMVC<AddNewLead>
    with SingleTickerProviderStateMixin {
  AdminController? _con;

  _AddNewLeadState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  AnimationController? _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  final _lead_nameController = TextEditingController();
  final _qualificationController = TextEditingController();

  final _campaign_idController = TextEditingController();
  final _status_idController = TextEditingController();

  final _follow_up_dateController = TextEditingController();
  final _phone_numberController = TextEditingController();


  var selCatId,selCat;
  var selCatcampId,selCatcamp;

  File? selectedFile;
  File? selectedFile1;
  @override
  void initState() {
    // TODO: implement initState
    _con!.leadstatus();
    _con!.campaignlist();
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
  }

  submit() async {

    _showSheet();
    _con!.leadadd(context,userId,_lead_nameController.text,_qualificationController.text,selCatcamp,selCat,_follow_up_dateController.text,_phone_numberController.text,businessId);

  }

  void _showSheet() {
    showModalBottomSheet<void>(
      context: context,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(60.0),
      ),
      builder: (BuildContext context) {
        return Container(
          height: 400,
          decoration: const BoxDecoration(
            color: Color(0xFFFFFFFF),
            borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60)),
          ),
          child: Container(
              padding: EdgeInsets.all(30),
              child:Center(
                child: Align(
                  alignment: FractionalOffset.topCenter,
                  child: Container(
                    height: 250,
                    decoration: BoxDecoration(
                        color: Colors.white
                    ),
                    child: Image.asset("assets/dots.gif",height: 250),
                  ),
                ),
              )),
        );
      },
    );
  }




  late double width;
  late double height;

  @override
  Widget build(BuildContext context) {


    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          elevation: 5.0,
          bottomOpacity: 0.0,
          title: Text("Add Lead ",style: TextStyle(color: Colors.white,fontSize: 18),),
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
                  submit();
                },
                color: Colors.blue,
                padding: EdgeInsets.symmetric(horizontal: 50, vertical: 16),
                elevation: 2,
                shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                child: Text(
                  "Save",
                  style: TextStyle(
                      fontSize: 14, letterSpacing: 2.2, color: Colors.white),
                ),
              ),
            )),
        body: SingleChildScrollView(
            child:Stack(
              children: [
                Column(
                  children: [

                    SizedBox(
                      height: 10,
                    ),
                    Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Lead Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5,),

                          Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFDADADA))),
                            child: TextFormField(
                              controller: _lead_nameController,
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              validator: (value) => value!.isEmpty
                                  ? 'Lead Name cannot be blank'
                                  : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Lead Name"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Qualification",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFDADADA))),
                            child: TextFormField(
                              controller: _qualificationController,
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              validator: (value) => value!.isEmpty
                                  ? 'Qualification cannot be blank'
                                  : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Qualification"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Campaign",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          SizedBox(height: 5,),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFDADADA))),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selCatcamp,
                              hint: Text("Select Campaign"),
                              dropdownColor:  Colors.white,
                              iconEnabledColor: Colors.grey,
                              iconSize: 25,
                              elevation: 16,
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  selCatcamp = newValue;
                                });
                              },
                              items: _con?.CampaignList.map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    setState(() {
                                      selCatcampId = item["campaign_id"].toString();
                                    });
                                  },
                                  value: item["campaign_id"],
                                  child: Text(item["campaign_name"]),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Select Status",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),

                          SizedBox(height: 5,),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFDADADA))),
                            child: DropdownButton(
                              isExpanded: true,
                              value: selCat,
                              hint: Text("Select Status"),
                              dropdownColor:  Colors.white,
                              iconEnabledColor: Colors.grey,
                              iconSize: 25,
                              elevation: 16,
                              underline: Container(
                                height: 0,
                              ),
                              onChanged: (newValue) {
                                setState(() {
                                  print("status" +newValue.toString());
                                  selCat = newValue;
                                });
                              },
                              items: _con?.LeadStatusList.map((item) {
                                return DropdownMenuItem(
                                  onTap: () {
                                    setState(() {
                                      selCatId = item["status_id"].toString();
                                    });
                                  },
                                  value: item["status_id"],
                                  child: Text(item["status_name"]),
                                );
                              }).toList(),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Follow Up Date",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFDADADA))),
                            child: TextFormField(
                              controller: _follow_up_dateController,
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              validator: (value) => value!.isEmpty
                                  ? 'Follow Up Date cannot be blank'
                                  : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Follow Up Date"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Phone Number",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5,),
                          Container(
                            padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                border: Border.all(color: Color(0xFFDADADA))),
                            child: TextFormField(
                              controller: _phone_numberController,
                              style: TextStyle(color: Colors.black),
                              keyboardType: TextInputType.text,
                              validator: (value) => value!.isEmpty
                                  ? 'Phone Number cannot be blank'
                                  : null,
                              decoration: InputDecoration(
                                  border: InputBorder.none,
                                  hintStyle:
                                  TextStyle(color: Colors.grey.withOpacity(.8)),
                                  hintText: "Phone Number"),
                            ),
                          ),
                          SizedBox(
                            height: 10,
                          ),

                        ],
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
