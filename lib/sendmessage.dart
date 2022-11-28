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

class SendMessage extends StatefulWidget {

  @override
  _SendMessageState createState() => _SendMessageState();
}

class _SendMessageState extends StateMVC<SendMessage>
    with SingleTickerProviderStateMixin {
  AdminController? _con;

  _SendMessageState() : super(AdminController()) {
    _con = controller as AdminController?;
  }



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
    _con!.getuserinfo(userId);

    setState(() {

    });

  }



  submit() async {

    _showSheet();
  //  _con!.userprofileupdate(context,userId,_nameController.text,_emailController.text,_phoneController.text,_workmobileController.text,_addressController.text);

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

    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue[600],
          elevation: 5.0,
          bottomOpacity: 0.0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text("Send Message",style: TextStyle(
              fontSize: 20,  color: Colors.white)),

        ),
        backgroundColor: Color(0xFFF8F8F9),
        bottomNavigationBar: BottomAppBar(
            child: Container(
              margin: EdgeInsets.only(left: 30, right: 30, bottom: 10),
              child: MaterialButton(
                onPressed: () {
                //  submit();
                },
                color: Color(0xFF2B65EC),
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
                              "Message",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10,),
                          buildTextAreaField("Enter your message", '', false,_addressController),
                          SizedBox(height: 20,),
                          Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Send To",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,fontWeight: FontWeight.bold),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          SizedBox(height: 10,),
                          buildTextAreaField("All\nTest Admin\nTest User", '', false,_addressController),

                        ],
                      ),
                    ),
                  ],
                )
              ],
            )));
  }
}
