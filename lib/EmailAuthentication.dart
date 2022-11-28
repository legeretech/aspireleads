import 'package:flutter/material.dart';
import 'package:holacoin/LoginPage.dart';
import 'package:page_transition/page_transition.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';

class EmailAuthentication extends StatefulWidget {

  String email,type;

  EmailAuthentication({required this.email,required this.type});

  @override
  _EmailAuthenticationState createState() => _EmailAuthenticationState();
}

class _EmailAuthenticationState extends StateMVC<EmailAuthentication> with SingleTickerProviderStateMixin  {


  AdminController? _con;


  _EmailAuthenticationState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  final _otpController = TextEditingController();
  AnimationController? _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));
  void initState() {
    // TODO: implement initState
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _controller?.forward();

    _con!.resendemailcode(widget.email);
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
    }
  }

  resendemailcode(email) async{

    _con!.resendemailcode(email);

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: AppBar(
        backgroundColor: Colors.black,
        elevation: 0,
        leading: new IconButton(
          icon: new Icon(Icons.arrow_back,color: Colors.white),
          onPressed: () {
            Navigator.pop(context);
          //  Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: LoginPage()));
          },
        ),
      ),
      body: SizedBox.expand(
        child: Stack(
          children: <Widget>[
            Padding(
              padding: EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Text("Authentication",
                    style: TextStyle(color: Colors.white, fontSize: 30, fontWeight: FontWeight.bold),),
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
                          color: Colors.white,
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
                            child: Container(

                              child: SingleChildScrollView(
                                child: Padding(
                                  padding: EdgeInsets.all(40),
                                  child: Column(
                                    children: <Widget>[
                                      SizedBox(height: 60,),
                                      Container(
                                        decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius: BorderRadius.circular(10),
                                        ),
                                        child: Column(
                                          children: <Widget>[
                                            Align(
                                                alignment: Alignment.centerLeft,
                                                child:Text("Email 2FA Authentication",
                                                  style: TextStyle(color: Colors.black, fontSize: 25, fontWeight: FontWeight.bold),textAlign: TextAlign.left)),
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
                                                controller: _otpController,
                                                keyboardType: TextInputType.number,
                                                validator: (value) => value!.isEmpty ? 'Code cannot be blank' : null,
                                                decoration: InputDecoration(
                                                    hintText: "Enter 6 digits code ",
                                                    hintStyle: TextStyle(color: Colors.grey),
                                                    border: InputBorder.none
                                                ),
                                              ),
                                            ),

                                          ],
                                        ),
                                      ),
                                      SizedBox(height: 20,),

                                      Align(
                                        alignment: Alignment.centerLeft,
                                        child: RawMaterialButton(
                                          onPressed: () {
                                            submit();
                                            //    Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: RegistrationProfileinfo()));
                                          },
                                          elevation: 2.0,
                                          fillColor: Colors.black,
                                          child: Icon(
                                            Icons.arrow_forward,
                                            size: 25.0,
                                            color: Colors.white,
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
                                        child:  Text("If you do not receive the  mail within a few minutes, please  check your spam or bulk email  folder  just in case the    mail got delivered  there instead of  your inbox. If so select the   mail and mark it Not  Spam, which should allow future  messages to get through",
                                          style: TextStyle(color: Colors.grey, fontSize: 14),textAlign: TextAlign.left),

                                      ),

                                    ],
                                  ),
                                ),
                              ),
                            ),
                          );
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