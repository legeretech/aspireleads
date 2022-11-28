import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:holacoin/forgotpassword.dart';
import 'package:holacoin/registration.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:scaffold_gradient_background/scaffold_gradient_background.dart';

import 'constants/Theme.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends StateMVC<LoginPage>  with SingleTickerProviderStateMixin {


  AdminController? _con;


  _LoginPageState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  bool autovalidate = false;
  bool _passwordVisible = false;

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  submit() async {
    final FormState? form = _con!.RegFormKey.currentState;
    if (!form!.validate()) {
      autovalidate = true;
      // Start validating on every change.
    }
    else {
      _showSheet();
      form.save();
      _con!.signIn(context,_emailController.text,_passwordController.text);
    }
  }

  AnimationController? _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));


  void initState() {
    // TODO: implement initState
    _passwordVisible = false;
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _controller?.forward();
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

  @override
  Widget build(BuildContext context) {
    return ScaffoldGradientBackground(
      gradient: LinearGradient(
        begin: Alignment.bottomLeft,
        end: Alignment.topRight,
        colors: [
          Color(0xFF2B65EC),
          Color(0xFF8EC5FC),
        ],
      ),
      resizeToAvoidBottomInset: false,
      body: Form(
        key: _con!.RegFormKey,
        child:Container(

        padding: EdgeInsets.only(top:100),
          child:Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
          Container(
          padding: EdgeInsets.only(left:30),
            child :Text("Login",
              style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),)),
            SizedBox(height: 20,),
            Container(
              padding: EdgeInsets.all(30),
              child: Column(
                children: <Widget>[


                  Container(
                    padding: EdgeInsets.fromLTRB(10,2,10,2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color:  Colors.white)
                    ),
                    child: TextFormField(
                      controller: _emailController,
                      style: TextStyle(color: Colors.white),
                      keyboardType: TextInputType.emailAddress,
                      validator: (value) => value!.isEmpty ? 'Username cannot be blank' : null,
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "Username"
                      ),
                    ),
                  ),
                  SizedBox(height: 20,),
                  Container(
                    padding: EdgeInsets.fromLTRB(10,2,10,2),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        border: Border.all(color: Colors.white)
                    ),
                    child:  TextFormField(
                      controller: _passwordController,
                      validator: (value) => value!.isEmpty ? 'Password cannot be blank' : null,
                      keyboardType: TextInputType.visiblePassword,
                      obscureText: !_passwordVisible,
                      style: TextStyle(color: Colors.white),
                      decoration: InputDecoration(
                          border: InputBorder.none,
                          hintStyle: TextStyle(color: Colors.white),
                          hintText: "Password",
                        suffixIcon: IconButton(
                          icon: Icon(
                            // Based on passwordVisible state choose the icon
                            _passwordVisible
                                ? Icons.visibility
                                : Icons.visibility_off,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            // Update the state i.e. toogle the state of passwordVisible variable
                            setState(() {
                              _passwordVisible = !_passwordVisible;
                            });
                          },
                        ),
                      ),
                    ),
                  ),

                ],
              ),
            ),
            SizedBox(height: 5,),


            SizedBox(height: 10,),
            Center(
              child: new Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  new MaterialButton(
                    onPressed: () {
                      submit();
                    },
                    color: Colors.white,
                    padding: EdgeInsets.symmetric(horizontal: 145,vertical: 16),
                    elevation: 2,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15)),
                    child: Text(
                      "NEXT",
                      style: TextStyle(
                          fontSize: 14,
                          letterSpacing: 2.2,
                          color: Color(0xFF2B65EC)),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(height: 30,),




          ],
        ),
      )),
    );
  }
}


