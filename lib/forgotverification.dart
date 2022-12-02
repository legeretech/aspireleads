import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:holacoin/forgotpassword.dart';
import 'package:holacoin/resetpassword.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:holacoin/controller/controller.dart';

class ForgotVerificationPassword extends StatefulWidget {

  String email;

  ForgotVerificationPassword({required this.email});


  @override
  _ForgotVerificationPasswordState createState() => _ForgotVerificationPasswordState();
}

class _ForgotVerificationPasswordState extends StateMVC<ForgotVerificationPassword> with SingleTickerProviderStateMixin {

  AdminController? _con;

  _ForgotVerificationPasswordState() : super(AdminController()) {
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
      _con!.checkForgotCode(context,widget.email,_verifycodeController.text);
    }
  }
  AnimationController? _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));


  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _controller?.forward();
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
        //    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ForgotPassword()));
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

                                child: SingleChildScrollView(
                                  child: Padding(
                                    padding: EdgeInsets.all(30),
                                    child:  Column(
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
                                                  child:Text("Verification",
                                                    style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),textAlign: TextAlign.left)),
                                              SizedBox(height: 10,),

                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:Text("Enter 6 digit verification code we just sent to you at your email address.",
                                                    style: TextStyle(color: Colors.grey, fontSize: 16),textAlign: TextAlign.left)),

                                              SizedBox(height: 20,),
                                              Container(
                                                height: 60,
                                                padding: EdgeInsets.all(10),
                                                decoration: BoxDecoration(
                                                    border: Border(bottom: BorderSide(color: Colors.grey.withOpacity(.8)))
                                                ),
                                                child: TextFormField(
                                                  style: TextStyle(color: Colors.white),
                                                  controller: _verifycodeController,
                                                  validator: (value) => value!.isEmpty ? 'Code cannot be blank' : null,
                                                  decoration: InputDecoration(
                                                    hintText: 'Enter 6 digits code',
                                                    hintStyle: TextStyle(color: Colors.grey),
                                                    border: InputBorder.none,
                                                  ),
                                                ),
                                              ),

                                            ],
                                          ),
                                        ),
                                        SizedBox(height: 20,),
                                        Align(
                                          alignment: Alignment.centerRight,
                                          child: InkWell(
                                            child:  Text("Resend Code",
                                              style: TextStyle(color: Colors.grey, fontSize: 16),),
                                            onTap: () {
                                              Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ForgotPassword()));
                                            },
                                          )
                                          ,
                                        ),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: RawMaterialButton(
                                            onPressed: () {
                                              submit();
                                           //   Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ResetPassword()));
                                            },
                                            elevation: 2.0,
                                            fillColor: Colors.white,
                                            child: Icon(
                                              Icons.arrow_forward,
                                              size: 25.0,
                                              color: Colors.black,
                                            ),
                                            padding: EdgeInsets.all(15.0),
                                            shape: CircleBorder(),
                                          ),
                                        ),

                                        SizedBox(height: 50,),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child: Text("Don't get the code?",
                                            style: TextStyle(color: Colors.grey, fontSize: 14,fontWeight: FontWeight.bold),textAlign: TextAlign.left),
                                        ),
                                        SizedBox(height: 5,),
                                        Align(
                                          alignment: Alignment.centerLeft,
                                          child:  Text("If you do not receive the verification mail within a few minutes, please check your spam or bulk email folder just in case the verification mail got delivered there instead of your inbox. If so select the verification mail and mark it Not Spam, which should allow future messages to get through",
                                            style: TextStyle(color: Colors.grey, height: 5,  fontSize: 14),textAlign: TextAlign.left),

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