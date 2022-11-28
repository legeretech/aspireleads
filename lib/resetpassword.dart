import 'package:flutter/material.dart';
import 'package:flutter_pw_validator/flutter_pw_validator.dart';
import 'package:page_transition/page_transition.dart';
import 'package:holacoin/LoginPage.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:holacoin/controller/controller.dart';
bool isPasswordTextField2=false;
bool isPasswordTextField3=false;
class ResetPassword extends StatefulWidget {

  String email;
  ResetPassword({required this.email});


  @override
  _ResetPasswordState createState() => _ResetPasswordState();
}

class _ResetPasswordState extends StateMVC<ResetPassword> with SingleTickerProviderStateMixin {

  AdminController? _con;

  _ResetPasswordState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  bool autovalidate = false;

  final _verifycodeController = TextEditingController();

  submit() async {
    final FormState? form = _con!.RegFormKey.currentState;
    if (!form!.validate()) {
      autovalidate = true;
      // Start validating on every change.
      print("faaill");
    }
    else {
      form.save();
    }
  }
  AnimationController? _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  final _newpwdController = TextEditingController();

  final _confirmpwdController = TextEditingController();

  void initState() {
    // TODO: implement initState

    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _controller?.forward();
  }


  passwordvalidated() async{
    print("Valid password");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,color: Colors.black),
          onPressed: () {
            Navigator.pop(context);
           // Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: LoginPage()));
          },
        ),
      ),
      body:  SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Container(
                      alignment: Alignment.center,
                      child:Container(
                        width: 100,
                        height: 100,
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('images/forgot.png'),
                                fit: BoxFit.cover
                            )
                        ),
                      )),
                ],
              ),
            ),

            SizedBox.expand(
              child: SlideTransition(
                position: _tween.animate(_controller!),
                child: DraggableScrollableSheet(
                  initialChildSize:0.70,
                  minChildSize:0.70,
                  builder: (BuildContext context, ScrollController scrollController) {
                    return Container(
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.only(topLeft: Radius.circular(60), topRight: Radius.circular(60))
                      ),
                      child: ListView.builder(
                        controller: scrollController,
                        itemCount: 1,
                        itemBuilder: (BuildContext context, int index) {
                          return _con!.loading ?  Align(
                            alignment: Alignment.bottomCenter,
                            child: Container(
                              height: 250,
                              child: Image.asset("assets/dots.gif",height: 100),
                            ),
                          ) : Form(
                              key: _con!.RegFormKey,
                              child:
                              Container(

                                child:  SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.all(30),
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 60,),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child: Column(
                                            children: <Widget>[
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:Text("Reset Password",
                                                    style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),)),
                                              SizedBox(height: 10,),

                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:Text("Set the new password for your account.",
                                                    style: TextStyle(color: Colors.grey, fontSize: 16),)),

                                              SizedBox(height: 20,),
                                              Container(
                                                height: 60,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.8)))
                                                ),
                                                child: TextFormField(
                                                  keyboardType: TextInputType.visiblePassword,
                                                  style: TextStyle(color: Colors.white),
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
                                              Container(
                                                height: 60,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.8)))
                                                ),
                                                child: TextFormField(
                                                  style: TextStyle(color: Colors.white),
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
                                                  defaultColor: Colors.white,
                                                  controller: _newpwdController,
                                                  minLength: 7,
                                                  uppercaseCharCount: 1,
                                                  numericCharCount: 1,
                                                  specialCharCount: 1,
                                                  width: 300,
                                                  height: 120,
                                                  onSuccess: passwordvalidated
                                              ),
                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: RawMaterialButton(
                                            onPressed: () {

                                              submit();

                                             // Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ResetPasswordSuccess()));
                                            },
                                            elevation: 2.0,
                                            fillColor: Colors.white,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 25.0,
                                            ),
                                            padding: EdgeInsets.all(15.0),
                                            shape: CircleBorder(),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ));
                        },
                      ),
                    );
                  },
                ),
              ),
            ),
          ],
        ),
      )
    );
  }
}