import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:fyi_main2_2_1/demo.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:flutter_facebook_auth/flutter_facebook_auth.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'dart:convert';
import 'package:dio/dio.dart';
import 'package:prompt_dialog/prompt_dialog.dart';
var username;
int super_signin=0; //0=google 1=facebook
String fileName = "CacheData.json";
Response response;
String token =
    "";
var educationJson;
var about;
var skillsJson;
var projectsJson;
var dob;
var phone;
var name;
var achievementsJson;
var image;
var email;
var experienceJson;
List<ExperienceList> finalexp;
List<EducationList> finaledu;
List<SkillsList> finalskill;
List<ProjectList> finalproject;
List<AchievementList> finalachievement;

List<Widget> experienceexpandlist = new List();
List<Widget> skillexpandlist = new List();
List<Widget> educationexpandlist = new List();
List<Widget> projectexpandlist = new List();
List<Widget> achievementexpandlist = new List();

class ExperienceList {
  String organization;
  String from;
  String to;
  String description;
  String post;
  String status;

  ExperienceList({
    this.organization,
    this.from,
    this.to,
    this.description,
    this.post,
    this.status,
  });

  factory ExperienceList.fromJson(Map<String, dynamic> json) => ExperienceList(
        organization: json["organization"],
        from: json["from"],
        to: json["to"],
        description: json["description"],
        post: json["post"],
        status: json["status"],
      );
}

class SkillsList {
  String field;
  var level;

  SkillsList({this.field, this.level});

  factory SkillsList.fromJson(Map<String, dynamic> json) => SkillsList(
        field: json["field"],
        level: json["level"],
      );
}

class EducationList {
  String to;
  String degree;
  String description;
  String status;
  String from;
  String institute;

  EducationList(
      {this.status,
      this.description,
      this.from,
      this.degree,
      this.institute,
      this.to});

  factory EducationList.fromJson(Map<String, dynamic> json) => EducationList(
        to: json["to"],
        degree: json["degree"],
        description: json["description"],
        status: json["status"],
        from: json["from"],
        institute: json["institute"],
      );
}

class ProjectList {
  String to;
  String link;
  String description;
  String status;
  String from;
  String name;

  ProjectList(
      {this.status,
      this.description,
      this.from,
      this.name,
      this.to,
      this.link});

  factory ProjectList.fromJson(Map<String, dynamic> json) => ProjectList(
        to: json["to"],
        name: json["name"],
        description: json["description"],
        status: json["status"],
        from: json["from"],
        link: json["link"],
      );
}

class AchievementList {
  String title;
  String year;
  String description;
  String issuer;

  AchievementList({
    this.title,
    this.description,
    this.year,
    this.issuer,
  });

  factory AchievementList.fromJson(Map<String, dynamic> json) =>
      AchievementList(
        title: json["title"],
        year: json["year"],
        description: json["description"],
        issuer: json["issuer"],
      );
}

final FirebaseAuth _auth = FirebaseAuth.instance;
final GoogleSignIn googleSignIn = GoogleSignIn();
bool isLoggedIn = false;
var det = "";

Future<String> signInWithGoogle(BuildContext context) async {
  try{
  await Firebase.initializeApp();
  var dio = Dio();
  final GoogleSignInAccount googleSignInAccount = await googleSignIn.signIn();
  final GoogleSignInAuthentication googleSignInAuthentication =
      await googleSignInAccount.authentication;
  final AuthCredential credential = GoogleAuthProvider.credential(
    accessToken: googleSignInAuthentication.accessToken,
    idToken: googleSignInAuthentication.idToken,
  );
  final UserCredential authResult =
      await _auth.signInWithCredential(credential);
  final User user = authResult.user;
  print("bye");
  var res;
  var phoneNumber;
  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    var currentUser = _auth.currentUser;
    print(currentUser);
    // await user.linkWithPhoneNumber("+911111111111");
    print(user);
    Map<String,dynamic> currentUser1={"uid":currentUser.uid,"xa":currentUser.refreshToken,"displayName":currentUser.displayName,"email":currentUser.email,"photoURL":currentUser.photoURL,"username":"","phoneNumber":""};
    assert(user.uid == currentUser1['uid']);
    try {
        var emailCheck = await dio.post(
          "https://us-central1-fyi-vitc.cloudfunctions.net/api/auth/emailCheck",
          data:{ "email": currentUser1["email"] }
        );
        print(emailCheck.data);
        username=emailCheck.data['username'];
        var body = {
          "google": true,
          "token": await currentUser.getIdToken(),
          "username": username,
          "name": currentUser1['displayName'],
          "email": currentUser1['email'],
          "picture": currentUser1['photoURL'],
          "phone": phoneNumber,
        };
        print(body);

        res = await dio.post(
          "https://us-central1-fyi-vitc.cloudfunctions.net/api/auth/userLogin",
          data:body,
        );
        print('signInWithGoogle succeeded: $res');
        super_signin=0;
        det = user.displayName;
        token=res.data['token'];
        print("TOKEN BS: $token");
        return '${user.displayName}';
      } catch(err) {
        print(err);
        var value = await prompt(context,title:Text("Enter a unique username"));
        while (true) {
          try {
            await dio.get(
              "https://us-central1-fyi-vitc.cloudfunctions.net/api/auth/checkUsernameAvailability/" +
                value
            );
            break;
          } catch (err) {
            value = await prompt(context,
              title:Text(value + " is Not available. Please try another one")
            );
          }
        }
        username=value;
        phoneNumber = user.phoneNumber;
        print(phoneNumber);
        if (currentUser1['phoneNumber']=='' || currentUser1['phoneNumber']==null) {
          phoneNumber = await prompt(context,title:Text("Enter your Mobile Number"));
          var phone = "+91" + phoneNumber;
          await _auth.verifyPhoneNumber(phoneNumber: phone,
           verificationCompleted:(cred){
             },
             verificationFailed: (e){
               print(e.toString());
               print("error");
              },
              codeSent: (String verificationId, int resendToken) async {
                String smsCode = await prompt(context,title:Text("Enter the OTP sent to your phone Number"));
                PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                await _auth.currentUser.linkWithCredential(phoneAuthCredential);
                var body = {
                "google": true,
                "token": await currentUser.getIdToken(),
                "username": username,
                "name": currentUser1['displayName'],
                "email": currentUser1['email'],
                "picture": currentUser1['photoURL'],
                "phone": phoneNumber,
              };
              res = await dio.post(
                "https://us-central1-fyi-vitc.cloudfunctions.net/api/auth/userLogin",
                data:body,
              );
                print('signInWithGoogle succeeded: $res');
                det = user.displayName;
                return '${user.displayName}';
             
              },
              codeAutoRetrievalTimeout: (a)=>{print(2)}
            );
        }
      }
      
  }}catch(err){
    print(err);
  }
}

void signOutGoogle() async {
  await googleSignIn.signOut();

  print("User Signed Out");
}

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  Future<void> gethttp(String userloginname) async {
    var dio = Dio();
    try {
      response = await dio.get(
        "https://us-central1-fyi-vitc.cloudfunctions.net/api/profile/$username",
        queryParameters: {"x-auth-token": token}, //?x-auth-token=$token
      );
      print("GETHHTTP fucntion print -> $response");
      var body = response.data;
      // final ids = json.decode(response.data);
      print(body);
      print("see here");
      about = body['about'];
      print(about);
      educationJson = body['education'];
      print("see here");

      skillsJson = body['skills'];
      print("see here");

      projectsJson = body['projects'];
      print("see here");

      achievementsJson = body['achievements'];
      experienceJson = body['experience'];
      print("see here");


      print("see here");

      dob = body['dob'];
      print("see here");
      phone = body['phone'];
      name = body['name'];
      image = body['picture'];
      email = body['email'];
      var tempexperience = experienceJson;
      var tempskill = skillsJson;
      var tempedu = educationJson;
      var tempach = achievementsJson;
      var temppro = projectsJson;
      print("see here");

      print(projectsJson);
      finalexp = tempexperience
          .map<ExperienceList>((json) => ExperienceList.fromJson(json))
          .toList();
      finaledu = tempedu
          .map<EducationList>((json) => EducationList.fromJson(json))
          .toList();
      finalskill = tempskill
          .map<SkillsList>((json) => SkillsList.fromJson(json))
          .toList();
      finalproject = temppro
          .map<ProjectList>((json) => ProjectList.fromJson(json))
          .toList();
      finalachievement = tempach
          .map<AchievementList>((json) => AchievementList.fromJson(json))
          .toList();
      print("${finalproject.length},${finaledu.length},${finalexp.length}, ${finalachievement.length}, ${finalskill.length}");
      for (int i = 0; i < finalexp.length; i++) {
        if (finalexp[i].status.toLowerCase() == "completed") {
          finalexp[i].status = " ";
        }
        experienceexpandlist.add(ExperienceContainer(
            finalexp[i].organization,
            finalexp[i].post,
            finalexp[i].from,
            finalexp[i].to,
            finalexp[i].status,
            finalexp[i].description));
      }
      for (int i = 0; i < finalskill.length; i++) {
        print("hello");
        skillexpandlist
            .add(SkillContainer(finalskill[i].field, finalskill[i].level.toString()));
      }
      for (int i = 0; i < finaledu.length; i++) {
        if (finaledu[i].status.toLowerCase() == "completed") {
          finaledu[i].status = " ";
        }
        educationexpandlist.add(EducationContainer(
            finaledu[i].degree,
            finaledu[i].institute,
            finaledu[i].from,
            finaledu[i].to,
            finaledu[i].status,
            finaledu[i].description));
      }
      for (int i = 0; i < finalachievement.length; i++) {
        achievementexpandlist.add(AchievementContainer(
            finalachievement[i].title,
            finalachievement[i].year,
            finalachievement[i].issuer,
            finalachievement[i].description));
      }
      for (int i = 0; i < finalproject.length; i++) {
        if (finalproject[i].status.toLowerCase() == "completed") {
          finalproject[i].status = " ";
        }
        projectexpandlist.add(ProjectContainer(
            finalproject[i].name,
            finalproject[i].link,
            finalproject[i].from,
            finalproject[i].to,
            finalproject[i].status,
            finalproject[i].description));
      }
print("see here");
      print(skillexpandlist.length);
      // var tempDir = await getTemporaryDirectory();
      // File file = new File(tempDir.path + "/" + fileName);
      // file.writeAsString(response.toString(),
      //     flush: true, mode: FileMode.write);
    } catch (e) {
      print(e);
      print("ERROR");
    }
  }

  Future<void> getcache(String userloginname) async {
    var cacheDir = await getTemporaryDirectory();
    print("getcache");
    if (await File(cacheDir.path + "/" + fileName).exists()) {
      print("Loading from cache");
      var cachedata = File(cacheDir.path + "/" + fileName).readAsStringSync();
      var cachedata1 = json.decode(cachedata);
      print(cachedata1);
      var body = cachedata1;
      // final ids = json.decode(response.data);
      educationJson = body['education'];
      about = body['about'];
      skillsJson = body['skills'];
      projectsJson = body['projects'];
      dob = body['dob'];
      phone = body['phone'];
      name = body['name'];
      achievementsJson = body['achievements'];
      image = body['picture'];
      email = body['email'];
      experienceJson = body['experience'];
      print(experienceJson.toString());
      var tempexperience = experienceJson;
      var tempskill = skillsJson;
      var tempedu = educationJson;
      var tempach = achievementsJson;
      var temppro = projectsJson;
      finalexp = tempexperience
          .map<ExperienceList>((json) => ExperienceList.fromJson(json))
          .toList();
      finaledu = tempedu
          .map<EducationList>((json) => EducationList.fromJson(json))
          .toList();
      finalskill = tempskill
          .map<SkillsList>((json) => SkillsList.fromJson(json))
          .toList();
      finalproject = temppro
          .map<ProjectList>((json) => ProjectList.fromJson(json))
          .toList();
      finalachievement = tempach
          .map<AchievementList>((json) => AchievementList.fromJson(json))
          .toList();
      for (int i = 0; i < finalexp.length; i++) {
        if (finalexp[i].status.toLowerCase() == "completed") {
          finalexp[i].status = " ";
        }
        experienceexpandlist.add(ExperienceContainer(
            finalexp[i].organization,
            finalexp[i].post,
            finalexp[i].from,
            finalexp[i].to,
            finalexp[i].status,
            finalexp[i].description));
      }
      for (int i = 0; i < finalskill.length; i++) {
        skillexpandlist
            .add(SkillContainer(finalskill[i].field, finalskill[i].level));
      }
      for (int i = 0; i < finaledu.length; i++) {
        if (finaledu[i].status.toLowerCase() == "completed") {
          finaledu[i].status = " ";
        }
        educationexpandlist.add(EducationContainer(
            finaledu[i].degree,
            finaledu[i].institute,
            finaledu[i].from,
            finaledu[i].to,
            finaledu[i].status,
            finaledu[i].description));
      }
      for (int i = 0; i < finalachievement.length; i++) {
        achievementexpandlist.add(AchievementContainer(
            finalachievement[i].title,
            finalachievement[i].year,
            finalachievement[i].issuer,
            finalachievement[i].description));
      }
      for (int i = 0; i < finalproject.length; i++) {
        print("HOLA");
        if (finalproject[i].status.toLowerCase() == "completed") {
          finalproject[i].status = " ";
        }
        projectexpandlist.add(ProjectContainer(
            finalproject[i].name,
            finalproject[i].link,
            finalproject[i].from,
            finalproject[i].to,
            finalproject[i].status,
            finalproject[i].description));
      }
      print("found");
      print(finalexp[0].organization);
      print(image);
    }
    //TODO: If the Json file does not exist, then make the API Call
    else {
      gethttp(det);
    }
  }

  Widget ExperienceContainer(String title, String post, String from, String to,
      String status, String desc) {
    return Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
            color: Colors.blue.shade100,
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  post,
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                ),
                Text(
                  from,
                  style: TextStyle(fontSize: 13),
                ),
                Text("-"),
                Text(
                  to,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  status,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 1,
              color: Colors.black45,
              padding: EdgeInsets.symmetric(horizontal: 50),
            ),

          ],
        ));
  }

  Widget SkillContainer(String field, String level) {
    return Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              field,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w400),
            ),
            SizedBox(
              height: 5,
            ),
            Row(
              children: [
                Container(
                  padding: EdgeInsets.only(right: 60),
                  height: 10,
                  width: (MediaQuery.of(context).size.width / 1.8) *
                      (int.parse(level) / 100),
                  decoration: BoxDecoration(
                      color: Colors.blue,
                      borderRadius: BorderRadius.circular(5)),
                ),
                SizedBox(
                  width: 5,
                ),
                Text(
                  "$level %",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                )
              ],
            ),
            SizedBox(
              height: 15,
            ),
          ],
        ));
  }

  Widget EducationContainer(String degree, String institute, String from,
      String to, String status, String desc) {
    return Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              degree,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Row(
              children: [
                Flexible(
                  child: Text(
                    institute,
                    style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
                  ),
                ),
                SizedBox(
                  width: 50,
                ),
                Text(
                  from,
                  style: TextStyle(fontSize: 13),
                ),
                Text("-"),
                Text(
                  to,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  status,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 1,
              color: Colors.black45,
              padding: EdgeInsets.symmetric(horizontal: 50),
            ),

          ],
        ));
  }

  Widget ProjectContainer(String name, String link, String from, String to,
      String status, String desc) {
    return Container(
        padding: EdgeInsets.all(25),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade100,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              link,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  from,
                  style: TextStyle(fontSize: 13),
                ),
                Text("-"),
                Text(
                  to,
                  style: TextStyle(fontSize: 13),
                ),
              ],
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  status,
                  style: TextStyle(fontSize: 15),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 1,
              color: Colors.black45,
              padding: EdgeInsets.symmetric(horizontal: 50),
            ),

          ],
        ));
  }

  Widget AchievementContainer(
      String title, String year, String issuer, String desc) {
    return Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.blue.shade100,
        ),
        padding: EdgeInsets.all(15),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              name,
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Text(
              issuer,
              style: TextStyle(fontSize: 17, fontWeight: FontWeight.bold),
            ),
            SizedBox(
              height: 10,
            ),
            Text(
              desc,
              style: TextStyle(fontSize: 15),
            ),
            SizedBox(
              height: 8,
            ),
            Container(
              height: 1,
              color: Colors.black45,
              padding: EdgeInsets.symmetric(horizontal: 50),
            ),

          ],
        ));
  }

  //====================================================================
  void initiateFacebookLogin(context) async {
    final result = await  FacebookAuth.instance.login();
    final FacebookAuthCredential facebookAuthCredential =
      FacebookAuthProvider.credential(result.token);
    await _auth.signInWithCredential(facebookAuthCredential);
          print(_auth.currentUser);
           final User user = _auth.currentUser;
           var dio=Dio();
  print("bye");
  var res;
  var phoneNumber;
  var username;
  if (user != null) {
    assert(!user.isAnonymous);
    assert(await user.getIdToken() != null);

    var currentUser = _auth.currentUser;
    print(currentUser);
    // await user.linkWithPhoneNumber("+911111111111");
    print(user);
    Map<String,dynamic> currentUser1={"uid":currentUser.uid,"xa":currentUser.refreshToken,"displayName":currentUser.displayName,"email":currentUser.email,"photoURL":currentUser.photoURL,"username":"","phoneNumber":""};
    assert(user.uid == currentUser1['uid']);
    try {
        var emailCheck = await dio.post(
          "https://us-central1-fyi-vitc.cloudfunctions.net/api/auth/emailCheck",
          data:{ "email": currentUser1["email"] }
        );
        print(emailCheck.data);
        username=emailCheck.data['username'];
        var body = {
          "facebook": true,
          "token": await currentUser.getIdToken(),
          "username": username,
          "name": currentUser1['displayName'],
          "email": currentUser1['email'],
          "picture": currentUser1['photoURL'],
          "phone": phoneNumber,
        };
        print("body");
        print(body);
        name=username;    //login.name
        phone=phoneNumber;
        email=currentUser1['email'];
        image=currentUser1['photoURL'];
        res = await dio.post(
          "https://us-central1-fyi-vitc.cloudfunctions.net/api/auth/userLogin",
          data:body,
        );
        print("res");
        print(res);
        
        print('signInWithFacebook succeeded: $res');
        det = user.displayName;
        token=res.data['token'];
      } catch(err) {
        print(err);
        var value = await prompt(context,title:Text("Enter a unique username"));
        while (true) {
          try {
            await dio.get(
              "https://us-central1-fyi-vitc.cloudfunctions.net/api/auth/checkUsernameAvailability/" +
                value
            );
            break;
          } catch (err) {
            value = await prompt(context,
              title:Text(value + " is Not available. Please try another one")
            );
          }
        }
        username=value;
        name=value;    //login.name
        phoneNumber = user.phoneNumber;
        email=currentUser1['email'];
        image=currentUser1['photoURL'];
        if (currentUser1['phoneNumber']=='' || currentUser1['phoneNumber']==null) {
          phoneNumber = await prompt(context,title:Text("Enter your Mobile Number"));
          var phone = "+91" + phoneNumber;
          // phone=user.phoneNumber;
          print(phone);
          print(phoneNumber);
          await _auth.verifyPhoneNumber(phoneNumber: phone,
           verificationCompleted:(cred){
             },
             verificationFailed: (e){
               print(e.toString());
               print("error phone");
              },
              codeSent: (String verificationId, int resendToken) async {
                String smsCode = await prompt(context,title:Text("Enter the OTP sent to your phone Number"));
                PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: smsCode);
                print("phoneAuthCredential"+phoneAuthCredential.toString());
                await _auth.currentUser.linkWithCredential(phoneAuthCredential);
                var body = {
                "facebook": true,
                "token": await currentUser.getIdToken(),
                "username": username,
                "name": currentUser1['displayName'],
                "email": currentUser1['email'],
                "picture": currentUser1['photoURL'],
                "phone": phoneNumber,
              };
                print("body");
              print(body);

              res = await dio.post(
                "https://us-central1-fyi-vitc.cloudfunctions.net/api/auth/userLogin",
                data:body,
              );
              print("res");
              print(res);
              
                print('signInWithFacebook succeeded: $res');
                super_signin=1;
                det = user.displayName;
                name=value;    //login.name
                phone=user.phoneNumber;
                email=currentUser1['email'];
                image=currentUser1['photoURL'];
              },
              codeAutoRetrievalTimeout: (a)=>{print(2)}
            );
          print("auth");
        }
      }
  }
    await gethttp(det);

    Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return Testing("");
              },
            ),
          );
        }
    
  

  void onLoginStatusChanged(bool isLoggedIn) {
    setState(() {
      isLoggedIn = isLoggedIn;
    });
  }

  //=====================================================================
  var loggedIn = false;
  var firebaseAuth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            // color: Colors.white,
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  // FlutterLogo(size: 150),
                  Image(image: AssetImage("images/fyi.png"), height: 210.0),
                  Text(
                    'Fraternity of Young Innovators',
                    style: TextStyle(
                        fontSize: 20,
                        color: Colors.black87,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 5),
                  Text(
                    'Emerge | Innovate | Lead',
                    style: TextStyle(
                        fontSize: 18,
                        color: Colors.grey,
                        fontWeight: FontWeight.w300),
                  ),
                  SizedBox(height: 30),
                  _googleSignInButton(),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 20),
            child: Container(
                child: Center(
              child: loggedIn
                  ? Text("Logged In! :)",
                      style: TextStyle(color: Colors.white, fontSize: 40))
                  : Stack(
                      children: <Widget>[
                        Container(
                          child: Center(
                            child: _facebookLoginButton(),
                          ),
                        )
                      ],
                    ),
            )),
          ),
        ],
      ),
    );
  }

  Widget _googleSignInButton() {
    return OutlineButton(
      splashColor: Colors.blue,
      onPressed: () async {
        signInWithGoogle(context).then((result) async {
          if (result != null) {
            await gethttp(det);
            Navigator.of(context).push(
              MaterialPageRoute(
                builder: (context) {
                  return Testing(det);
                },
              ),
            );
          }
        });
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/google_logo.png"), height: 35.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Google',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  OutlineButton _facebookLoginButton() {
    return OutlineButton(
      splashColor: Colors.blue,
      onPressed: () {
        initiateFacebookLogin(context);
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(40)),
      highlightElevation: 0,
      borderSide: BorderSide(color: Colors.blue),
      child: Padding(
        padding: const EdgeInsets.fromLTRB(0, 10, 0, 10),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image(image: AssetImage("images/fbiconbig.png"), height: 40.0),
            Padding(
              padding: const EdgeInsets.only(left: 10),
              child: Text(
                'Sign in with Facebook',
                style: TextStyle(
                  fontSize: 20,
                  color: Colors.grey,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
