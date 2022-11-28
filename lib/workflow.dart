import 'package:flutter/material.dart';
import 'package:holacoin/pendingforverification.dart';

import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/global.dart';
import 'package:holacoin/controller/controller.dart';


import '../constants/Theme.dart';
import '../dashboard.dart';
import '../profileinfo.dart';
import 'duetoday.dart';

class Workflow extends StatefulWidget {
  @override
  _WorkflowState createState() => _WorkflowState();
}

class _WorkflowState extends StateMVC<Workflow>
    with SingleTickerProviderStateMixin {
  AdminController? _con;

  _WorkflowState() : super(AdminController()) {
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
    await _con!.getdashboard(userId);
  }

  Widget _myListView() {
    return ListView(
      physics: const NeverScrollableScrollPhysics(),
      children: <Widget>[
        Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color(0xFFF8F8F9),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
                title: Text('Pending For Verification',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: ArgonColors.primary,
                ),
                onTap: () {

                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: PendingForVerification()));

                })),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color(0xFFF8F8F9),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
                title: Text('Due Today',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: ArgonColors.primary,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Duetoday(title:"Due Today")));
                })),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color(0xFFF8F8F9),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
                title: Text('Due With In 7 Days',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: ArgonColors.primary,
                ),
                onTap: () {

                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Duetoday(title:"Due With In 7 Days")));

                })),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color(0xFFF8F8F9),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
                title: Text('On Hold',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: ArgonColors.primary,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Duetoday(title:"On Hold")));


                })),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color(0xFFF8F8F9),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
                title: Text('Upcoming within One Month',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: ArgonColors.primary,
                ),
                onTap: () {

                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Duetoday(title:"Upcoming within One Month")));

                })),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color(0xFFF8F8F9),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
                title: Text('Assigned To Me',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: ArgonColors.primary,
                ),
                onTap: () {

                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Duetoday(title:"Assigned To Me")));

                })),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color(0xFFF8F8F9),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
                title: Text('Filed With In last 30 Days',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: ArgonColors.primary,
                ),
                onTap: () {


                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Duetoday(title:"Filed With In last 30 Days")));
                })),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color(0xFFF8F8F9),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
                title: Text('In Progress',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: ArgonColors.primary,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Duetoday(title:"In Progress")));


                })),
        SizedBox(height: 10),
        Container(
            padding: EdgeInsets.all(10),
            decoration: new BoxDecoration(
              color: Color(0xFFF8F8F9),
              borderRadius: BorderRadius.all(Radius.circular(15)),
            ),
            child: ListTile(
                title: Text('Pending',
                    style: TextStyle(fontWeight: FontWeight.bold)),
                trailing: Icon(
                  Icons.arrow_forward,
                  color: ArgonColors.primary,
                ),
                onTap: () {
                  Navigator.push(
                      context,
                      PageTransition(
                          type: PageTransitionType.fade, child: Duetoday(title:"Pending")));



                })),


      ],
    );
  }

  late double width;
  late double height;
  int _selectedIndex = 0;
  void _onTap(int index)
  {
    _selectedIndex = index;

    if(_selectedIndex == 0){
      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: MyHome()));
    }else if(_selectedIndex == 1){

    }else{

      Navigator.push(
          context,
          PageTransition(
              type: PageTransitionType.fade, child: Profileinfo()));




    }
    setState(() {

    });
  }
  @override
  Widget build(BuildContext context) {
    width = MediaQuery.of(context).size.width;
    height = MediaQuery.of(context).size.height;
    return WillPopScope(
      child: Scaffold(
        bottomNavigationBar: BottomNavigationBar(
          items: [
            BottomNavigationBarItem(
              icon: Icon(Icons.home,color: ArgonColors.primary,),
              label: 'Home',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.add,color: ArgonColors.primary,),
              label: 'Send Message',
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.person,color: ArgonColors.primary,),
              label: 'Profile',
            ),
          ],
          currentIndex: _selectedIndex,
          unselectedItemColor: Colors.black,
          selectedItemColor: Colors.black,
          backgroundColor: Colors.white,
          onTap: _onTap,
          type: BottomNavigationBarType.fixed,
        ),
        body: SizedBox.expand(
          child: Stack(
            children: <Widget>[
              Padding(
                  padding: EdgeInsets.all(1),
                  child: Container(
                      height: 500,
                      width: double.infinity,
                      child: DecoratedBox(
                          decoration: BoxDecoration(
                            image: DecorationImage(
                                image:
                                AssetImage("assets/img/profile-screen-bg.png"),
                                fit: BoxFit.cover),
                          ),
                          child: Column(
                            children: [
                              SizedBox(
                                height: 50,
                              ),
                              Container(
                                width: double.infinity,
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: GestureDetector(
                                            onTap: () {

                                            },
                                            child: Icon(
                                              Icons.search,
                                              size: 26.0,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                    Align(
                                      alignment: Alignment.centerRight,
                                      child: Padding(
                                          padding: EdgeInsets.only(right: 20.0),
                                          child: GestureDetector(
                                            onTap: () {

                                            },
                                            child: Icon(
                                              Icons.doorbell,
                                              color: Colors.white,
                                            ),
                                          )),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(
                                height: 50,
                              ),
                              Center(

                                  child: Align(
                                    alignment: Alignment.center,
                                    child: Text(
                                      "Workflow",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontWeight: FontWeight.bold,
                                          fontSize: 30),
                                      textAlign: TextAlign.left,
                                    ),
                                  )),

                            ],
                          )))),
              SizedBox.expand(
                child: SlideTransition(
                  position: _tween.animate(_controller!),
                  child: DraggableScrollableSheet(
                    initialChildSize: 0.70,
                    minChildSize: 0.70,
                    builder: (BuildContext context,
                        ScrollController scrollController) {
                      return Container(
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(30),
                                topRight: Radius.circular(30))),
                        child: ListView.builder(
                          padding: EdgeInsets.zero,
                          controller: scrollController,
                          itemCount: 1,
                          itemBuilder: (BuildContext context, int index) {
                            return _con!.loading
                                ? Align(
                              alignment: Alignment.bottomCenter,
                              child: Container(
                                height: 250,
                                child: Image.asset("assets/dots.gif",
                                    height: 100),
                              ),
                            )
                                : Padding(
                              padding: EdgeInsets.only(
                                  top: 30, left: 30, right: 30),
                              child: Container(
                                height: 750.0,
                                child: _myListView(),
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
        ),
      ),
      onWillPop: () async {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (BuildContext context) => new MyHome()));

        return false;
      },
    );
  }
}


