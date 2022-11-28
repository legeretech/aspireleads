import 'dart:convert';
import 'package:holacoin/api/api.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as convert;

Future signInRepo(username,password) async {
  final String url = APIData.domainLink+"user/login";
  final res = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
    "phone_number": username,
    "password": password
  }));
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}
Future createRequest(user_id,complaint,vehiclenumber,modelnumber,customername,driverlocation,drivernumber,additionalnote,frontimagefilename,sideimagefilename,imagefile,sideimagefile) async {
  final String url = APIData.domainLink+"NewComplaint";
  final res = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "user_id" : user_id,
        "complaint": complaint,
        "vehicle_no": vehiclenumber,
        "model_no": modelnumber,
        "customer_name": customername,
        "driver_location": driverlocation,
        "driver_contactno": drivernumber,
        "notes": additionalnote,
        "audiofile": "",
        "audiofilename": "",
        "frontimagefilename": frontimagefilename,
        "sideimagefilename": sideimagefilename,
        "createdby": "",
        "imagefile":imagefile,
        "sideimagefile": sideimagefile,
        "status_id": 12,
        "createdby": DateTime.now().toString()
      }));

  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future assignBranch(user_id,complaintid,techniciancode) async {
  final String url = APIData.domainLink+"AssignTechnician";
  final res = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "user_id" : user_id,
        "complaintid": complaintid,
        "techniciancode": techniciancode
      }));

  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future updatestatus(user_id,complaintid,status,remarks) async {
  final String url = APIData.domainLink+"StatusUpdate";
  final res = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "technicianid" : user_id,
        "complaintid": complaintid,
        "statusid": status,
        "remarks": remarks
      }));

  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future signup(firstname,email,password,referredBy) async {
  final String url = APIData.domainLink+"sign-up";
  final res = await http.post(Uri.parse(url), body: {
    "first_name": firstname,
    "email": email,
    "password": password,
    "referred_by":referredBy
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future checkReferralRepo(referralCode) async {
  final String url = APIData.domainLink+"checkreferral";
  final res = await http.post(Uri.parse(url), body: {
    "referral_id": referralCode
  });
  // ignore: non_constant_identifier_names
  var RegData =  json.decode(res.body);
  return RegData;
}

Future checkEmailRepo(email) async {
  final String url = APIData.domainLink+"checkemail";
  final res = await http.post(Uri.parse(url), body: {
    "email": email
  });
  // ignore: non_constant_identifier_names
  var RegData =  json.decode(res.body);
  return RegData;
}

Future checkEmailCodeRepo(email,otp) async {
  final String url = APIData.domainLink+"email-verify";
  final res = await http.post(Uri.parse(url), body: {
    "email": email,
    "access_code": otp
  });
  // ignore: non_constant_identifier_names
  var RegData =  json.decode(res.body);
  return RegData;
}

Future forgotRepo(email) async {
  final String url = APIData.domainLink+"forgotpassword";
  final res = await http.post(Uri.parse(url), body: {
    "email": email,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future verifyemail(email,otp) async {
  final String url = APIData.domainLink+"email-verify";
  final res = await http.post(Uri.parse(url), body: {
    "email": email,
    "access_code":otp
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future verifyauthemail(email,otp) async {
  final String url = APIData.domainLink+"authemail-verify";
  final res = await http.post(Uri.parse(url), body: {
    "email": email,
    "access_code":otp
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future resendemailcode(email) async {
  final String url = APIData.domainLink+"resendemailcode";
  final res = await http.post(Uri.parse(url), body: {
    "email": email,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}



Future resetPassRepo(email,password) async {
  final String url = APIData.domainLink+"resetpassword";
  final res = await http.post(Uri.parse(url), body: {
    "email": email,
    "password": password,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}
Future changePassRepo(id,password,currentpassword) async {

  final String url = APIData.domainLink+"changePassRepo";
  final res = await http.post(Uri.parse(url), body: {
    "id": id,
    "password": password,
    "currentpassword":currentpassword
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future checkusername(userId,username) async {

  final String url = APIData.domainLink+"checkusername";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "last_name": username,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}



Future userprofilephoneupdate(userId,country,mobile) async {

  final String url = APIData.domainLink+"registerprofileupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "country": country,
    "mobile": mobile,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future registerprofileupdateRepo(userId,country,country_code,currency,mobile) async {

  final String url = APIData.domainLink+"registerprofileupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "country": country,
    "currency": currency,
    "mobile": mobile,
    "country_code": country_code,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}



Future userprofileupdate(userId,name,email,phone,workmobile,address) async {

  final String url = APIData.domainLink+"EditProfile";
  final res = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "User_id": userId,
        "Name": name,
        "Address": address,
        "Email": email,
        "PhoneNumber": phone,
        "WorkMobile": workmobile,
      }));
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future userprofilemoreupdate(userId,name,dob,sex,address) async {
  final String url = APIData.domainLink + "registeruserprofilemoreupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "name": name,
    "dob": dob,
    "sex": sex,
    "address": address,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}



Future userpaymentupdate(userId,id,name) async {

  final String url = APIData.domainLink+"userpaymentupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "name": name,
    "payment_id": id,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future registerprofilephoneverifyupdate(userId) async {

  final String url = APIData.domainLink+"registerprofilephoneverifyupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future userprofileimageupdate(userId,photo) async {

  final String url = APIData.domainLink+"registeruserprofileimageupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "photo": photo,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}



Future referralmoverewads(userId) async {

  final String url = APIData.domainLink+"referralmoverewads";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future stakemoverewads(userId) async {

  final String url = APIData.domainLink+"stakemoverewads";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future stakeunlockupdate(userId,_selected) async {

  final String url = APIData.domainLink+"stakeunlockupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "stake_id": _selected,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future userprofilekycupdate(userId,photo,photo1,photo2) async {

  final String url = APIData.domainLink+"registeruserprofilekycupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "kyc_selfie": photo,
    "kyc_id_front": photo1,
    "kyc_id_back": photo2,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future instanttrasferexternal(userId,amount,send_to,message,coin_id) async {

  final String url = APIData.domainLink+"instanttrasferexternal";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "amount": amount,
    "send_to": send_to,
    "message": message,
    "coin_id": coin_id,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future instanttrasfer(userId,amount,send_to,message,coin_id) async {

  final String url = APIData.domainLink+"instanttrasfer";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "amount": amount,
    "send_to": send_to,
    "message": message,
    "coin_id": coin_id,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future profileauthupdateRepo(userId) async {

  final String url = APIData.domainLink+"profileauthupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future profileauthenableRepo(userId) async {

  final String url = APIData.domainLink+"profileauthenabled";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}



Future getuserinfo(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"ProfileViewDetails?userid="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future getNotification(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"getnotification?id="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}



Future getreferralinfo(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"getreferralinfo?id="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future getsendinfo(userId,coin_id)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"getsendinfo?id="+userId+"&coin_id="+coin_id),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future getquicksendinfo(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"getquicksendinfo?id="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future getaddtoquicksendinfo(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"getaddtoquicksendinfo?id="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}



Future getquicksendfavorites(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"getquicksendfavorites?id="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}


Future getquicksendinfosearch(userId,name)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"getquicksendinfo?id="+userId+"&name="+name),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future addmoreinfo(userId,username) async {

  print("user id"+userId);

  final String url = APIData.domainLink+"registeraddmoreupdate";
  final res = await http.post(Uri.parse(url), body: {
    "id": userId,
    "last_name": username,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future quicksendsubmit(userId,favorite_user_id) async {

  final String url = APIData.domainLink+"getquicksubmit";
  final res = await http.post(Uri.parse(url), body: {
    "user_id": userId,
    "favorite_user_id": favorite_user_id,
  });
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}

Future getstaking(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"getstaking?id="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}


Future getnewrequests(userId,branchcode,sortby)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"NewRequest?userid="+userId+"&branchcode="+branchcode.toString()+"&sortby="+sortby.toString()),
  );
  var qData = json.decode(response.body);
  return qData;
}


Future getallrequests(userId,status,sortby)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"AllRequestList?userid="+userId+"&statusid=0"),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future getcompletedrequests(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"CompleteRequest?userid="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}


Future getbranchassignedrequests(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"BranchListAllView?userid="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}
Future getleads(userId,businessId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"leads/leadbyuser/"+userId+"/"+businessId),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future getleadsbycampagin(userId,businessId,campaignid)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"leads/leadbyuser/"+userId+"/"+businessId+"/"+campaignid),
  );
  var qData = json.decode(response.body);
  return qData;
}



Future getcampaigns(userId,businessId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"common/campaign/findall/"+businessId),
  );
  var qData = json.decode(response.body);
  return qData;
}




Future getdashboard(userId)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"Dashboard?userid="+userId),
  );
  var qData = json.decode(response.body);
  return qData;
}
Future getleadinfo(id)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"leads/"+id),
  );
  print(APIData.domainLink+"leads/"+id);
  var qData = json.decode(response.body);
  return qData;
}
Future getdashboardrequests(id)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"RequestCountBasedStatus?statusid="+id),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future branchassignedrequestdetail(id)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"BranchAssigned?complaintid="+id),
  );
  var qData = json.decode(response.body);
  return qData;
}
Future technicianassignedrequestdetail(id)async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"TechnicianAssigned?complaintid="+id),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future leadstatus()async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"common/status"),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future campaignlist()async {
  final response = await http.get(
    Uri.parse(APIData.domainLink+"common/campaign/findall/5"),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future getDashboardRepo(id) async {
  print(APIData.domainLink+"dashboard?id="+id);
  final response = await http.get(
      Uri.parse(APIData.domainLink+"dashboard?id="+id),
  );
  var qData = json.decode(response.body);
  return qData;
}

Future leadupdate(lead_id,userId,lead_name,qualification,selCatcamp,selCat,follow_up_date,phone_number) async {

  final String url = APIData.domainLink+"leads/"+lead_id.toString();
  final res = await http.put(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
    "lead_name": lead_name,
    "qualification": qualification,
    "campaign_id": selCatcamp.toString(),
    "status_id": selCat.toString(),
    "follow_up_date": follow_up_date,
    "phone_number": phone_number,
    "assigned_user":userId.toString(),
  }));
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


Future leadadd(userId,lead_name,qualification,selCatcamp,selCat,follow_up_date,phone_number,businessId) async {

  final String url = APIData.domainLink+"leads";
  final res = await http.post(Uri.parse(url),
      headers: {"Content-Type": "application/json"},
      body: json.encode({
        "lead_name": lead_name,
        "qualification": qualification,
        "campaign_id": selCatcamp.toString(),
        "status_id": selCat.toString(),
        "follow_up_date": follow_up_date,
        "Phone_number": phone_number,
        "assigned_user":userId.toString(),
        "business_id":businessId.toString(),
      }));
  // ignore: non_constant_identifier_names
  var RegData = json.decode(res.body);
  return RegData;
}


















