import 'dart:io';

import 'package:holacoin/LoginPage.dart';
import 'package:flutter/material.dart';
import 'package:holacoin/dashboard.dart';
import 'dart:async';
import 'package:holacoin/global.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:firebase_core/firebase_core.dart';

class MyHttpOverrides extends HttpOverrides {
  @override
  HttpClient createHttpClient(SecurityContext? context) {
    return super.createHttpClient(context)
      ..badCertificateCallback =
          (X509Certificate cert, String host, int port) => true; }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  HttpOverrides.global = new MyHttpOverrides();

  runApp(
      MaterialApp(
          debugShowCheckedModeBanner: false,
          home: HomePage()
      )
  );
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends StateMVC<HomePage> {

  AdminController? _con;


  _HomePageState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  bool hideIcon = false;

  @override
  void initState() {
    // TODO: implement initState
    _timer();
    getUserId();
    super.initState();
  }

  getUserId() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId= prefs.getString('user').toString();
      NAME= prefs.getString('name').toString();
      status= prefs.getString('status').toString();
      Mobile= prefs.getString('mobile').toString();
    });
  }

  _timer(){
    return Timer(
        Duration(seconds: 5),(){
      if(userId.toString().isNotEmpty && userId.toString()!=null && userId!=null &&
          NAME.toString().isNotEmpty && NAME.toString()!=null && NAME!=null&&NAME.toString()!="null") {
      //  _con!.getuserlogininfo(context,userId);
        Navigator.pushReplacement(context, PageTransition(
            type: PageTransitionType.fade, child: MyHome()));
        }

      else{
        Navigator.of(context).pushReplacement(
            MaterialPageRoute(builder: (BuildContext context) => LoginPage()));
      }
    }
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage("assets/img/onboard-background.png"),
            fit: BoxFit.cover,
          ),
        ),
        child: Center(
          child: Text(
            "Aspire Leads",
            style: TextStyle(fontWeight: FontWeight.bold,fontSize: 60.00,color: Colors.white),
            textAlign: TextAlign.center,
          ),
        ) /* add child content here */,
      )
    );
  }
}