import 'package:flutter/material.dart';
import 'package:page_transition/page_transition.dart';
import 'package:holacoin/LoginPage.dart';
import 'package:holacoin/forgotverification.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:holacoin/controller/controller.dart';


class ForgotPassword extends StatefulWidget {

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends StateMVC<ForgotPassword> with SingleTickerProviderStateMixin {

  AdminController? _con;

  _ForgotPasswordState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  bool autovalidate = false;

  final _emailController = TextEditingController();

  submit() async {
    final FormState? form = _con!.RegFormKey.currentState;
    if (!form!.validate()) {
      autovalidate = true;
      // Start validating on every change.
      print("faaill");
    }
    else {
      form.save();
      _con!.checkForgorEmail(context,_emailController.text);
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
   //         Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: LoginPage()));
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
                                    child: Column(
                                      children: <Widget>[
                                        SizedBox(height: 60,),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: Colors.black,
                                            borderRadius: BorderRadius.circular(10),
                                          ),
                                          child:Column(
                                            children: <Widget>[
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:Text("Forgot Password?",
                                                      style: TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.bold),textAlign: TextAlign.left)),
                                              SizedBox(height: 10,),
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:Text("That's ok...",
                                                      style: TextStyle(color: Colors.grey, fontSize: 16),textAlign: TextAlign.left)),
                                              SizedBox(height: 10,),
                                              Align(
                                                  alignment: Alignment.centerLeft,
                                                  child:Text("Just enter the email address you've  used to register with us.",
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
                                                  controller: _emailController,
                                                  validator: (value) => value!.isEmpty ? 'Email Address cannot be blank' : null,
                                                  decoration: InputDecoration(
                                                    hintText: 'Email Address',
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
                                          child: RawMaterialButton(
                                            onPressed: () {
                                              submit();
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
      ),

    );
  }
}