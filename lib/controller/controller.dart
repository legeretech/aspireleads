import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:holacoin/model/technician_model.dart';
import 'package:holacoin/myleads.dart';
import 'package:holacoin/view/dashboard.dart';
import 'package:holacoin/global.dart';
import 'package:mvc_pattern/mvc_pattern.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:holacoin/repository/repository.dart' as repo;
import 'package:holacoin/forgotverification.dart';
import 'package:page_transition/page_transition.dart';


import '../dashboard.dart';

import '../leaddetail.dart';
import '../profileinfo.dart';
import '../resetpassword.dart';

class AdminController extends ControllerMVC {
  late GlobalKey<ScaffoldState> scaffoldKey;
  late GlobalKey<FormState> RegFormKey;

  AdminController() {
   this.scaffoldKey = new GlobalKey<ScaffoldState>();
   RegFormKey = new GlobalKey<FormState>();
  }

  var checkamount;
  var stakingData;
  var newrequests;
  var allrequests;
  var instanttransferData;
  var stakelist;
  var stakedetails;
  var dashboardData;
  var branchassignedrequests;
  var invoiceDetail;
  var salesReportData;
  var salesTodayList= [];
  var recentOrdersList;
  var collectionList= [];
  var returnItemList= [];
  var mostSellingShopsList= [];
  var shopList= [];
  var distributorsList= [];
  var salesManList= [];
  var userData = [];
  var NotificationData;
  var userDataOwn;
  var referralData;
  var referralCount;
  var sendData;
  bool loading = false;
  bool dash = true;
  String pagloading = "completed";
  bool userexists = false;
  String payment_method = "1";
  List<String> stake_dropdown =['4','5','6','7'];
  var coinlist;
  var LeadData;
  var completedrequestData;
  var branchassignedequestData;
  var BrTechniciansList = [];
  var myleads;
  var mycampaigns;
  var technicianassignedequestData;
  var dashboardrequestData;
  var LeadStatusList = [];
  var CampaignList = [];


  setUserId(user,name,userrole,business_id) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('user',user.toString());
    await prefs.setString('name',name.toString());
    await prefs.setString('userrole',userrole.toString());
    await prefs.setString('business_id',business_id.toString());

  }

  void signup(context,firstname,email,password,referred_by) async{

    repo.signup(firstname,email,password,referred_by). then((value) async {

      Navigator.pop(context);

      if(value["success"] == true)
      {
        setUserId(value["user"]["user_id"].toString(),value["user"]["full_name"].toString(),value["user"]["role_id"].toString(),value["user"]["business_ids"][0].toString());
        setState(() {
          NAME = value["name"].toString();
        });
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: MyHome()));
      }
      else
        Fluttertoast.showToast(
        msg: value["message"].toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
    });
  }
  void checkForgorEmail(context,email) async {

    setState(() {
      loading = true;
    });

    repo.checkEmailRepo(email). then((value) async {
      setState(() {
        loading = false;
      });
      if(value["success"] == true)
      {

        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ForgotVerificationPassword(email:email)));
      }
      else

        Fluttertoast.showToast(
          msg: value["message"].toString(),
         toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

    });

  }

  void checkForgotCode(context,email,code) async {

    setState(() {
      loading = true;
    });

    repo.checkEmailCodeRepo(email,code). then((value) async {
      setState(() {
        loading = false;
      });
      if(value["success"] == true)
      {

        Navigator.push(context, PageTransition(type: PageTransitionType.fade, child: ResetPassword(email:email)));
      }
      else

        Fluttertoast.showToast(
          msg: value["message"].toString(),
         toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );

    });

  }


  void signIn(context,username,password) async {

    repo.signInRepo(username,password). then((value) {
      Navigator.pop(context);

      if(value["status"] == true)
      {



           setUserId(value["user"]["user_id"].toString(),value["user"]["full_name"].toString(),value["user"]["role_id"].toString(),value["user"]["business_ids"][0].toString());

           setState(() {
             NAME = value["user"]["full_name"].toString();
           });

             Navigator.pushReplacement(context, PageTransition(
                 type: PageTransitionType.fade, child: MyHome()));


      }
      else
        Fluttertoast.showToast(
          msg: value["message"].toString(),
         toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.black,
          textColor: primaryColor,
          fontSize: 16.0,
        );
    });
  }


  void userprofileupdate(context,userId,name,email,phone,workmobile,address){

    setState(() {
      loading = true;
    });

    repo.userprofileupdate(userId,name,email,phone,workmobile,address). then((value) {

      if(value["success"] == true)
      {
        setState(() {
          loading = false;
        });

        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: Profileinfo()));

      }
      else
        setState(() {
          loading = false;
        });
      Fluttertoast.showToast(
        msg: value["message"].toString(),
       toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Colors.black,
        textColor: primaryColor,
        fontSize: 16.0,
      );
    });

  }





  void resendemailcode(email)async {


    setState(() {
      loading = true;
    });

    repo.resendemailcode(email). then((value) async {
      setState(() {
        loading = false;
      });

      if(value["success"] == true)
      {

        Fluttertoast.showToast(
          msg: value["message"].toString(),
         toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
      }
      else
        Fluttertoast.showToast(
          msg: value["message"].toString(),
         toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
    });

  }



  void passwordupdate(context,userid,newpassword,currentpassword)async {


    setState(() {
      loading = true;
    });

    repo.changePassRepo(userid,newpassword,currentpassword). then((value) async {
      setState(() {
        loading = false;
      });

      if(value["success"] == true)
      {
        Fluttertoast.showToast(
          msg: value["message"].toString(),
         toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16.0,
        );
        Navigator.pushReplacement(context, PageTransition(type: PageTransitionType.fade, child: Profileinfo()));
      }
      else
        Fluttertoast.showToast(
          msg: value["message"].toString(),
         toastLength: Toast.LENGTH_LONG,
          gravity: ToastGravity.TOP,
          timeInSecForIosWeb: 35,
          backgroundColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16.0,
        );
    });

  }


  void getuserinfo(userId)async {
    setState(() {
      loading = true;
    });
    repo.getuserinfo(userId).then((value) {
      if(value["Success"] == true){
        setState(() {
          userData = [];
          loading = false;
          userData = value["Data"]["ProfileViewDetailsList"];
        });
      }
    });
  }

  void getNotification(userId)async {
    repo.getNotification(userId).then((value) {
      if(value["success"] == true){
        setState(() {
          NotificationData = value["data"];
        });
      }
    });
  }




  void getuserinfoown(userId)async {

    repo.getuserinfo(userId).then((value) {
      if(value["success"] == true){
        setState(() {
          userDataOwn = value["user"];
        });
      }
    });
  }


  void getuserlogininfo(context,userId)async {
    setState(() {
      loading = true;
    });
    repo.getuserinfo(userId).then((value) {
      if(value["Success"] == true){
        setState(() {
          loading = false;
          userData = value["Data"]["ProfileViewDetailsList"];

          print("rele"+value["Data"]["ProfileViewDetailsList"][0]["LoginRoleId"].toString()+userId);


            Navigator.pushReplacement(context, PageTransition(
                type: PageTransitionType.fade, child: MyHome()));


        });
      }
    });
  }

  void getsendinfo(userId,coin_id)async {
    setState(() {
      loading = true;
    });
    repo.getsendinfo(userId,coin_id).then((value) {
      if(value["success"] == true){
        setState(() {
          loading = false;
          sendData = value["data"];
        });
      }
    });
  }




  void getreferralinfo(userId)async {
    repo.getreferralinfo(userId).then((value) {
      if(value["success"] == true){
        setState(() {
          referralData = value["data"];
          referralCount = value["data_count"];
        });
      }
    });
  }




  void getaddtoquicksendinfo(userId)async {
    repo.getaddtoquicksendinfo(userId).then((value) {
      if(value["success"] == true){
        setState(() {
          referralData = value["data"];
          referralCount = value["data_count"];
        });
      }
    });
  }


  void getstaking(userId)async {
    repo.getstaking(userId).then((value) {
      if(value["success"] == true){
        setState(() {
          stakingData = value["data"];
        });
      }
    });
  }

  void getnewrequests(userId,branchcode,sortby)async {
    repo.getnewrequests(userId,branchcode,sortby).then((value) {
      if(value["Success"] == true){
        setState(() {
          newrequests = value["Data"]['NewRequestList'];
        });
      }
    });
  }

  void getallrequests(userId,status,sortby)async {
    repo.getallrequests(userId,status,sortby).then((value) {
      if(value["Success"] == true){
        setState(() {
          allrequests = value["Data"]['AllRequestList'];
        });
      }
    });
  }



  void getcompletedrequests(userId)async {
    repo.getcompletedrequests(userId).then((value) {
      if(value["Success"] == true){
        setState(() {
          completedrequestData  = value["Data"]['CompleteRequestList'];
        });
      }
    });
  }



  void getbranchassignedrequests(userId)async {
    repo.getbranchassignedrequests(userId).then((value) {
      if(value["Success"] == true){
        setState(() {
          branchassignedrequests = value["Data"]['BranchListAllList'];
        });
      }
    });
  }

  void getleads(userId,businessId)async {
    repo.getleads(userId,businessId).then((value) {
        setState(() {
          myleads = value;
        });
    });
  }

  void getleadsbycampagin(userId,businessId,campaignid)async {
    repo.getleadsbycampagin(userId,businessId,campaignid).then((value) {
      setState(() {
        myleads = value;
      });
    });
  }



  void getcampaigns(userId,businessId)async {
    repo.getcampaigns(userId,businessId).then((value) {
      setState(() {
        mycampaigns = value;
      });
    });
  }




  Future getdashboard(userId) async {
    repo.getdashboard(userId).then((value) {
      if(value["Success"] == true){
        setState(() {
          print("user_id"+userId);
          print("data"+value["Data"].toString());
          dashboardData = value["Data"];
        });
      }
    });
  }

  void getleadinfo(id) async {
    repo.getleadinfo(id).then((value) {
      setState(() {
        LeadData = value;
      });
    });
  }

  void getdashboardrequests(id) async {
    repo.getdashboardrequests(id).then((value) {
      if(value["Success"] == true){
        setState(() {
          dashboardrequestData = value["Data"]["RequestCountBasedStatus"];
        });
      }
    });
  }


  void branchassignedrequestdetail(id) async {
    repo.branchassignedrequestdetail(id).then((value) {
      if(value["Success"] == true){
        setState(() {
          branchassignedequestData = value["Data"]["BranchAssignedList"];
          BrTechniciansList = value["Data"]["BrTechniciansList"];

        });
      }
    });
  }

  void leadstatus() async {
    repo.leadstatus().then((value) {
      setState(() {

        LeadStatusList = value;

      });
    });
  }

  void campaignlist() async {
    repo.campaignlist().then((value) {
      setState(() {

        CampaignList = value;

      });
    });
  }



  void technicianassignedrequestdetail(id) async {
    repo.technicianassignedrequestdetail(id).then((value) {
      if(value["Success"] == true){
        setState(() {
          technicianassignedequestData = value["Data"]["TechnicianList"];
        });
      }
    });
  }


  void leadupdate(context,lead_id,userId,lead_name,qualification,selCatcamp,selCat,follow_up_date,phone_number){

    setState(() {
      loading = true;
    });

    repo.leadupdate(lead_id,userId,lead_name,qualification,selCatcamp,selCat,follow_up_date,phone_number). then((value) {

      if(value["error"] == false)
      {
        setState(() {
          loading = false;
        });

        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: LeadDetail(id:lead_id)));


      }
      else
        setState(() {
          loading = false;
        });
      Fluttertoast.showToast(
        msg: value["message"].toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Colors.black,
        textColor: primaryColor,
        fontSize: 16.0,
      );
    });

  }


  void leadadd(context,userId,lead_name,qualification,selCatcamp,selCat,follow_up_date,phone_number,businessId){

    setState(() {
      loading = true;
    });

    repo.leadadd(userId,lead_name,qualification,selCatcamp,selCat,follow_up_date,phone_number,businessId). then((value) {

      if(value["error"] == false)
      {
        setState(() {
          loading = false;
        });

        Navigator.push(
            context,
            PageTransition(
                type: PageTransitionType.fade, child: Myleads()));


      }
      else
        setState(() {
          loading = false;
        });
      Fluttertoast.showToast(
        msg: value["message"].toString(),
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.TOP,
        timeInSecForIosWeb: 35,
        backgroundColor: Colors.black,
        textColor: primaryColor,
        fontSize: 16.0,
      );
    });

  }


}