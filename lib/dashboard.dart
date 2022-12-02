import 'package:holacoin/utility/constants.dart';
import 'package:holacoin/view/dashboard.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class MyHome extends StatelessWidget {
  // This widget is the root of your application.

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: Constants.lightTheme,
        home: Dashboard());
  }
}
