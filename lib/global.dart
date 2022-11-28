import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:empty_widget/empty_widget.dart';

//status 1=>mobile not verified,2=>registration not completed
String NAME="";
String userrole="";
String userId="";
String status="";
String Mobile="";
String buy_currency="";
String sell_currency="";
String businessId="";

Color primaryColor = Color(0xff22b573);

Widget loading(){
  return Container(
    height: 500,
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(30),
    ),
    child: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset("assets/dots.gif",height: 500),
        ],
      ),
    ),
  );
}

Widget nodatafound(){
  return Container(
    alignment: Alignment.center,
    child: EmptyWidget(
      // Image from project assets
      image: "assets/images/im_emptyIcon_1.png",

      /// Image from package assets
      /// Uncomment below line to use package assets
      packageImage: PackageImage.Image_1,
      title: 'No Notification',
      subTitle: 'No  notification available yet',
      titleTextStyle: TextStyle(
        fontSize: 22,
        color: Color(0xff9da9c7),
        fontWeight: FontWeight.w500,
      ),
      subtitleTextStyle: TextStyle(
        fontSize: 14,
        color: Color(0xffabb8d6),
      ),
      // Uncomment below statement to hide background animation
      // hideBackgroundAnimation: true,
    ),
  );
}

Widget noprofile(){
  return Center(
    child: Stack(
      children: [
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
                    "https://holawallet.club/public/user/assets/images/profile/default.png",
                  ))),
        ),


      ],
    ),
  );
}
