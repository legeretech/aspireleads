import 'package:flutter/material.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';
import 'package:holacoin/controller/controller.dart';
import 'package:flutter/services.dart';

import '../dashboard.dart';

class FilterRequest extends StatefulWidget {
  @override
  _FilterRequestState createState() => _FilterRequestState();
}

class _FilterRequestState extends StateMVC<FilterRequest>
    with SingleTickerProviderStateMixin {
  AdminController? _con;

  _FilterRequestState() : super(AdminController()) {
    _con = controller as AdminController?;
  }

  AnimationController? _controller;
  Duration _duration = Duration(milliseconds: 500);
  Tween<Offset> _tween = Tween(begin: Offset(0, 1), end: Offset(0, 0));

  @override
  void initState() {
    // TODO: implement initState
    getUserId();
    super.initState();
    _controller = AnimationController(vsync: this, duration: _duration);
    _controller?.forward();
  }

  dispose() {
    super.dispose();
  }

  getUserId() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      userId = prefs.getString('user').toString();
      NAME = prefs.getString('name').toString();
    });
  }

  bool value = false;

  Widget _myListView() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
            child: ListTile(
                title: Text('Newest First', style: TextStyle(fontSize: 16)),
                trailing: Checkbox(
                  value: this.value,
                  onChanged: (bool? value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                onTap: () {})),
        Container(
            child: ListTile(
                title: Text('Branch Assigned', style: TextStyle(fontSize: 16)),
                trailing: Checkbox(
                  value: this.value,
                  onChanged: (bool? value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                onTap: () {})),
        Container(
            child: ListTile(
                title: Text('Technician Assigned', style: TextStyle(fontSize: 16)),
                trailing: Checkbox(
                  value: this.value,
                  onChanged: (bool? value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                onTap: () {})),
        Container(
            child: ListTile(
                title: Text('Completed', style: TextStyle(fontSize: 16)),
                trailing: Checkbox(
                  value: this.value,
                  onChanged: (bool? value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                onTap: () {})),
        Container(
            child: ListTile(
                title: Text('Branch Reassign', style: TextStyle(fontSize: 16)),
                trailing: Checkbox(
                  value: this.value,
                  onChanged: (bool? value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                onTap: () {})),
        Container(
            child: ListTile(
                title: Text('Staff Reassign', style: TextStyle(fontSize: 16)),
                trailing: Checkbox(
                  value: this.value,
                  onChanged: (bool? value) {
                    setState(() {
                      this.value = value!;
                    });
                  },
                ),
                onTap: () {})),
      ],
    );
  }

  late double width;
  late double height;


  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 0,
          leading: IconButton(
            icon: Icon(Icons.arrow_back, color: Color(0xFFF05236)),
            onPressed: () => Navigator.of(context).pop(),
          ),
          actions: <Widget>[
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child:
                      Icon(Icons.search, size: 26.0, color: Color(0xFFF05236)),
                )),
            Padding(
                padding: EdgeInsets.only(right: 20.0),
                child: GestureDetector(
                  onTap: () {},
                  child: Icon(Icons.doorbell, color: Color(0xFFF05236)),
                )),
          ],
        ),
        bottomNavigationBar: BottomAppBar(
          child:Container(
            margin: EdgeInsets.only(left: 30,right: 30,bottom: 10),
          child:MaterialButton(
            onPressed: () {
              // submit();
            },
            color: Color(0xFFF05236),
            padding: EdgeInsets.symmetric(horizontal: 145,vertical: 16),
            elevation: 2,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15)),
            child: Text(
              "Apply",
              style: TextStyle(
                  fontSize: 14,
                  letterSpacing: 2.2,
                  color: Colors.white),
            ),
          ),
        )),
        body: Stack(
          children: [
            Column(
              children: [
                Container(
                  padding:
                      EdgeInsets.only(left: 35, right: 30, bottom: 10, top: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Sort By",
                          style: TextStyle(
                              color: Color(0xFFF05236),
                              fontWeight: FontWeight.bold,
                              fontSize: 25),
                          textAlign: TextAlign.left,
                        ),
                      ),

                    ],
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Expanded(
                    child: Container(
                  padding: EdgeInsets.only(left: 30, right: 30),
                  child: _myListView(),
                )),
              ],
            )
          ],
        ));
  }
}
