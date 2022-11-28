import 'package:flutter/material.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';

import 'dashboard.dart';

var country_name = "";
bool isPasswordTextField1=false;
bool isPasswordTextField2=false;
bool isPasswordTextField3=false;

class ChangePassword extends StatefulWidget {
  @override
  _ChangePasswordState createState() => _ChangePasswordState();
}

class _ChangePasswordState extends StateMVC<ChangePassword> {

  AdminController? _con;


  _ChangePasswordState() : super(AdminController()) {
    _con = controller as AdminController?;
  }
  final _currentpwdController = TextEditingController();
  final _newpwdController = TextEditingController();

  final _confirmpwdController = TextEditingController();

  void initState() {
    // TODO: implement initState
    getUserId();
    super.initState();

    _con!.getuserinfo(userId);


  }
  getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId= prefs.getString('user').toString();
      NAME= prefs.getString('name').toString();
    });
  }


  bool autovalidate = false;
  submit() async {
    final FormState? form = _con!.RegFormKey.currentState;
    if (!form!.validate()) {
      autovalidate = true;
      // Start validating on every change.
      print("faaill");
    }
    else {
      form.save();
      if(_confirmpwdController.text == _newpwdController.text) {
        _con!.passwordupdate(context, userId, _newpwdController.text,
            _currentpwdController.text);
      }else{
        Fluttertoast.showToast(
          msg: "New Password and Confirm Password Mismatch",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
    }
  }


  passwordvalidated() async{
    print("Valid password");
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: Colors.white,
        title: Text(
          'Change Password',
          textAlign: TextAlign.left,
          style: TextStyle(color: Colors.black),
        ),
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
           // Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: PersonalSettings()));
          },
        ),
      ),
      backgroundColor: Colors.white,
      body:  Form(
          key: _con!.RegFormKey,
          child:Container(
            padding: EdgeInsets.only(left: 50, top: 25, right: 50),
            child: GestureDetector(
              onTap: () {
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
                        _con!.userData != null ?
                        Container(
                          width: 130,
                          height: 130,
                          decoration: BoxDecoration(
                              border: Border.all(
                                width: 4,
                                color: Colors.white,),
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
                                    _con!.userData[0]['photo'].toString() != "null" ? _con!.userData[0]['photo'].toString() : "https://holawallet.club/public/user/assets/images/profile/default.png",
                                  ))),
                        ) : Container(),


                      ],
                    ),
                  ),
                  SizedBox(
                    height: 35,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _currentpwdController,
                      validator: (value) => value!.isEmpty ? 'Password cannot be blank' : null,
                      obscureText: !isPasswordTextField1,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              isPasswordTextField1
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                isPasswordTextField1 = !isPasswordTextField1;
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Current Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _newpwdController,
                      validator: (value) => value!.isEmpty ? 'Password cannot be blank' : null,
                      obscureText: !isPasswordTextField2,
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              isPasswordTextField2
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                isPasswordTextField2 = !isPasswordTextField2;
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "New Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 20.0),
                    child: TextFormField(
                      keyboardType: TextInputType.visiblePassword,
                      controller: _confirmpwdController,
                      obscureText:!isPasswordTextField3,
                      validator: (val){
                          if(val != _newpwdController.text)
                            return 'Not Match';
                          return null;
                        },
                      decoration: InputDecoration(
                          suffixIcon: IconButton(
                            icon: Icon(
                              // Based on passwordVisible state choose the icon
                              isPasswordTextField3
                                  ? Icons.visibility
                                  : Icons.visibility_off,
                              color: Theme.of(context).primaryColorDark,
                            ),
                            onPressed: () {
                              // Update the state i.e. toogle the state of passwordVisible variable
                              setState(() {
                                isPasswordTextField3 = !isPasswordTextField3;
                              });
                            },
                          ),
                          contentPadding: EdgeInsets.only(bottom: 3),
                          labelText: "Confirm Password",
                          floatingLabelBehavior: FloatingLabelBehavior.always,
                          hintText: "",
                          hintStyle: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          )),
                    ),
                  ),
                  SizedBox(height: 10,),
                  new FlutterPwValidator(
                     defaultColor: Colors.black,
                      controller: _newpwdController,
                      minLength: 7,
                      uppercaseCharCount: 1,
                      numericCharCount: 1,
                      specialCharCount: 1,
                      width: 300,
                      height: 120,
                      onSuccess: passwordvalidated
                  ),
                  SizedBox(
                    height: 20,
                  ),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      ButtonTheme(
                        minWidth: MediaQuery.of(context).size.width*0.7,
                        height: 50,
                        child:  MaterialButton(
                          onPressed: () {

                            submit();

                          },
                          color: Colors.black,
                          padding: EdgeInsets.symmetric(horizontal: 55),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          child: Text(
                            "Change Password",
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        ),
                      )

                    ],
                  )
                ],
              ),
            ),
          ))

    );
  }

  bool showPassword = false;

  Widget buildTextField(
      String labelText, String placeholder, bool isPasswordTextField) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: TextFormField(
        obscureText: isPasswordTextField ? showPassword : false,
        decoration: InputDecoration(
            suffixIcon: isPasswordTextField
                ? IconButton(
              onPressed: () {
                setState(() {
                  showPassword = !showPassword;
                });
              },
              icon: Icon(
                Icons.remove_red_eye,
                color: Colors.grey,
              ),
            )
                : null,
            contentPadding: EdgeInsets.only(bottom: 3),
            labelText: labelText,
            floatingLabelBehavior: FloatingLabelBehavior.always,
            hintText: placeholder,
            hintStyle: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.black,
            )),
      ),
    );
  }

}