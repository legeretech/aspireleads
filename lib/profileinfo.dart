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

class Profileinfo extends StatefulWidget {
  @override
  _ProfileinfoState createState() => _ProfileinfoState();
}

class _ProfileinfoState extends StateMVC<Profileinfo> {
  AdminController? _con;

  late String imageUrl;

  _ProfileinfoState() : super(AdminController()) {
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

  bool autovalidate = false;

  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue[600],
        elevation: 5.0,
        bottomOpacity: 0.0,
        title: Text("Profile",style: TextStyle(color: Colors.white,fontSize: 18),),
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
          _con!.userData.length > 0
              ? Form(
                  autovalidateMode: AutovalidateMode.always,
                  key: _con!.RegFormKey,
                  child: Container(
                    padding: EdgeInsets.only(top: 25),
                    height: 300,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      color: Color(0xFFF8F8F9),
                      border: Border.all(
                          width: 4,
                          color: Theme.of(context).scaffoldBackgroundColor),
                      boxShadow: [
                        BoxShadow(
                            spreadRadius: 2,
                            blurRadius: 10,
                            color: Colors.black.withOpacity(0.1),
                            offset: Offset(0, 10))
                      ],
                    ),
                    child: GestureDetector(
                      onTap: () {
                        // _onAddPhotoClicked(context);
                        FocusScope.of(context).unfocus();
                      },
                      child: ListView(
                        children: [
                          SizedBox(
                            height: 15,
                          ),
                          Center(
                            child: Stack(
                              children: [
                                selectedFile != null
                                    ? Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 4,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  offset: Offset(0, 10))
                                            ],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                  selectedFile!,
                                                ))),
                                        //  child: Image.file(selectedFile!),
                                      )
                                    : Container(
                                        width: 130,
                                        height: 130,
                                        decoration: BoxDecoration(
                                            border: Border.all(
                                                width: 4,
                                                color: Theme.of(context)
                                                    .scaffoldBackgroundColor),
                                            boxShadow: [
                                              BoxShadow(
                                                  spreadRadius: 2,
                                                  blurRadius: 10,
                                                  color: Colors.black
                                                      .withOpacity(0.1),
                                                  offset: Offset(0, 10))
                                            ],
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: NetworkImage(
                                                  _con!.userData[0][
                                                                  'imagefilename']
                                                              .toString() !=
                                                          "null"
                                                      ? _con!.userData[0]
                                                              ['imagefilename']
                                                          .toString()
                                                      : "https://holawallet.club/public/user/assets/images/profile/default.png",
                                                ))),
                                      ),
                                GestureDetector(
                                  onTap: () async {
                                    PickedFile _pickedFile =
                                        (await ImagePicker().getImage(
                                            source: ImageSource.gallery))!;
                                    setState(() {
                                      selectedFile = File(_pickedFile.path);
                                    });
                                  },
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor,
                                      ),
                                      color: Colors.white,
                                    ),
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: Colors.blue,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 35,
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Demo User",
                              style: TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 25),
                              textAlign: TextAlign.left,
                            ),
                          ),
                          Align(
                            alignment: Alignment.center,
                            child: Text(
                              "Employee",
                              style:
                                  TextStyle(color: Colors.black, fontSize: 14),
                              textAlign: TextAlign.left,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ))
              : Container(
                  height: 300,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: Color(0xFFF8F8F9),
                    border: Border.all(
                        width: 4,
                        color: Theme.of(context).scaffoldBackgroundColor),
                    boxShadow: [
                      BoxShadow(
                          spreadRadius: 2,
                          blurRadius: 10,
                          color: Colors.black.withOpacity(0.1),
                          offset: Offset(0, 10))
                    ],
                  ),
                  child: GestureDetector(
                    onTap: () {
                      // _onAddPhotoClicked(context);
                      FocusScope.of(context).unfocus();
                    },
                    child: ListView(
                      children: [
                        SizedBox(
                          height: 15,
                        ),
                        Center(
                          child: Stack(
                            children: [
                              Container(
                                width: 130,
                                height: 130,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        width: 4,
                                        color: Theme.of(context)
                                            .scaffoldBackgroundColor),
                                    boxShadow: [
                                      BoxShadow(
                                          spreadRadius: 2,
                                          blurRadius: 10,
                                          color: Colors.black.withOpacity(0.1),
                                          offset: Offset(0, 10))
                                    ],
                                    shape: BoxShape.circle,
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(
                                          "https://holawallet.club/public/user/assets/images/profile/default.png",
                                        ))),
                              ),
                              Container(
                                height: 40,
                                width: 40,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  border: Border.all(
                                    width: 4,
                                    color: Theme.of(context)
                                        .scaffoldBackgroundColor,
                                  ),
                                  color: Colors.white,
                                ),
                                child: Icon(
                                  Icons.camera_alt,
                                  color: Colors.blue,
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 35,
                        ),

                        Align(
                          alignment: Alignment.center,
                          child: Text(
                            NAME,
                            style: TextStyle(
                                color: Colors.blue,
                                fontWeight: FontWeight.bold,
                                fontSize: 25),
                            textAlign: TextAlign.left,
                          ),
                        ),
                    SizedBox(
                      height: 10,
                    ),

                    Align(
                      alignment: Alignment.center,
                      child: Text(
                        "User ID : "+userId.toString(),
                        style: TextStyle(
                            color: Colors.blue,
                            fontSize: 18),
                        textAlign: TextAlign.left,
                      )),
                      ],
                    ),
                  )),
          _con!.userData.length > 0 ? Container(
             padding: EdgeInsets.only(top:20,left:20,right:20),
              child: ListTile(
                  leading: Icon(
                    Icons.location_on_outlined,
                    color: Colors.blue,
                  ),
                  title: Text("Address",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text(_con!.userData[0]['address'].toString()),
                  trailing: Icon(
                    Icons.edit,
                    color: Colors.blue,
                  ),
                  onTap: () {

                    print("My user_id :"+userId.toString());

                    Navigator.push(
                        context,
                        PageTransition(
                            type: PageTransitionType.fade, child: EditProfile(id:userId)));
                  })) : Container(),
          _con!.userData.length > 0 ? Container(
              padding: EdgeInsets.only(top:20,left:20,right:20),
              child: ListTile(
                  leading: Icon(
                    Icons.email_outlined,
                    color: Colors.blue,
                  ),
                  title: Text("Email",
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  subtitle: Text("info@popular.com"),
                  )) : Container(),
          _con!.userData.length > 0 ? Container(
              padding: EdgeInsets.only(top:20,left:20,right:20),
              child: ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                title: Text("Mobile",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(_con!.userData[0]['mobile'].toString()),
              )) : Container(),
          _con!.userData.length > 0 ? Container(
              padding: EdgeInsets.only(top:20,left:20,right:20),
              child: ListTile(
                leading: Icon(
                  Icons.call,
                  color: Colors.blue,
                ),
                title: Text("Work Mobile",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text(_con!.userData[0]['workmobile'].toString()),
              )) : Container(),
          Container(
              padding: EdgeInsets.only(top:20,left:20,right:20),
              child: ListTile(
                onTap: () async{

                  showDialog(
                      context: context,
                      builder: (BuildContext context) {
                        return AlertDialog(
                          title: Text("Confirm"),
                          content: Text("Are you sure want to Log Out?"),
                          actions: <Widget>[
                            MaterialButton(
                              child: Text("Yes"),
                              onPressed: () async{
                                SharedPreferences _prefs =
                                    await SharedPreferences.getInstance();
                                _prefs.clear();

                                Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (context) =>
                                    LoginPage()), (Route<dynamic> route) => false);

                              },
                            ),
                            MaterialButton(
                              child: Text("No"),
                              onPressed: () {
                                Navigator.of(context).pop();
                              },
                            )
                          ],
                        );
                      }
                  );



                },
                leading: Icon(
                  Icons.logout_outlined,
                  color: Colors.blue,
                ),
                title: Text("Logout",
                    style: TextStyle(fontWeight: FontWeight.bold)),
              )),

          Container(
              padding: EdgeInsets.only(top:20,left:20,right:20),
              child: ListTile(
                leading: Icon(
                  Icons.verified,
                  color: Colors.blue,
                ),
                title: Text("Version",
                    style: TextStyle(fontWeight: FontWeight.bold)),
                subtitle: Text("1.0.1"),
              ))
        ],
      ),
    );
  }
}
