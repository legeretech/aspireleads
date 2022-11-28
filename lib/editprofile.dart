import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:flutter/services.dart';
import 'package:flutter_sound/flutter_sound.dart';
import 'dart:io';

import '../dashboard.dart';
import 'filterrequest.dart';

class EditProfile extends StatefulWidget {
  String id;
  EditProfile({required this.id});
  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends StateMVC<EditProfile>
    with SingleTickerProviderStateMixin {
  AdminController? _con;

  _EditProfileState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  final recorder = FlutterSoundRecorder();
  AnimationController? _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  final _nameController = TextEditingController();
  final _addressController = TextEditingController();

  final _emailController = TextEditingController();
  final _phoneController = TextEditingController();
  final _workmobileController = TextEditingController();



  File? selectedFile;
  File? selectedFile1;
  @override
  void initState() {
    // TODO: implement initState
    getUserId();
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _controller?.forward();


  }

  dispose() {
    recorder.closeRecorder();
    super.dispose();
  }




  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user').toString();
      NAME = prefs.getString('name').toString();
    });
    _con!.getuserinfo(userId);

    setState(() {

    });

  }



  submit() async {

    _showSheet();
    _con!.userprofileupdate(context,userId,_nameController.text,_emailController.text,_phoneController.text,_workmobileController.text,_addressController.text);

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


  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField,TextEditingController _controller) {
    _controller.text = placeholder;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFDADADA))),
      child: TextFormField(
        controller: _controller,
        style: TextStyle(color: Colors.black),
        keyboardType: TextInputType.text,
        validator: (value) => value!.isEmpty
            ? labelText+' cannot be blank'
            : null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle:
            TextStyle(color: Colors.grey.withOpacity(.8)),
            hintText: labelText),
      ),
    );

  }
  Widget buildTextAreaField(
      String labelText, String placeholder, bool isPasswordTextField,TextEditingController _controller) {
    _controller.text = placeholder;
    return Container(
      padding: EdgeInsets.fromLTRB(10, 2, 10, 2),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          border: Border.all(color: Color(0xFFDADADA))),
      child: TextFormField(
        controller: _controller,
        style: TextStyle(color: Colors.black),
        keyboardType: TextInputType.multiline,
        minLines: 6,
        maxLines: null,
        validator: (value) => value!.isEmpty
            ? labelText+' cannot be blank'
            : null,
        decoration: InputDecoration(
            border: InputBorder.none,
            hintStyle:
            TextStyle(color: Colors.grey.withOpacity(.8)),
            hintText: labelText),
      ),
    );

  }



  @override
  Widget build(BuildContext context) {

    _nameController.text = _con!.userData != null ? _con!.userData[0]['name'].toString() : "";
    _addressController.text = _con!.userData != null ? _con!.userData[0]['address'].toString() : "";
    _emailController.text = _con!.userData != null ? _con!.userData[0]['email'].toString() : "";
    _phoneController.text = _con!.userData != null ? _con!.userData[0]['mobile'].toString() : "";
    _workmobileController.text = _con!.userData != null ? _con!.userData[0]['workmobile'].toString() : "";

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFF05236)),
            onPressed: () => Navigator.of(context).pop(),
          ),
        title: Text("Edit Profile",style: TextStyle(
            fontSize: 20,  color: Colors.black54)),

        ),
        bottomNavigationBar: BottomAppBar(
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: MaterialButton(
                onPressed: () {
                  submit();
                },
                color: Color(0xFFF05236),
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

                    Container(
                      padding: EdgeInsets.all(30),
                      child: Column(
                        children: <Widget>[
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Name",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5,),
                          buildTextField("Name", _con!.userData[0]['name'].toString(), false,_nameController),


                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Email",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5,),
                          buildTextField("Email", _con!.userData[0]['email'].toString(), false,_emailController),

                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Mobile Number",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5,),
                          buildTextField("Mobile Number", _con!.userData[0]['mobile'].toString(), false,_phoneController),
                          SizedBox(
                            height: 10,
                          ),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Work Mobile",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5,),
                          buildTextField("Work Mobile", _con!.userData[0]['workmobile'].toString(), false,_workmobileController),
                          SizedBox(
                            height: 10,
                          ),

                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Address",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 5,),
                          buildTextAreaField("Address", _con!.userData[0]['address'].toString(), false,_addressController),
                        ],
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
