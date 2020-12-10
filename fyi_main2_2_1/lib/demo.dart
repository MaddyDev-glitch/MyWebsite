import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/articlepage.dart';
import 'package:fyi_main2_2_1/showarticle.dart';
import 'profilepage.dart';
import 'login_page.dart' as login;

class Testing extends StatefulWidget {
  String username;
  Testing(this.username);
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xfff1f1f1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "DEMO NAVIGATOR",
            style: TextStyle(fontSize: 60,fontWeight: FontWeight.w300),
          ),
          Text(
            "Hey ${widget.username}",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 100,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyCustomForm()),
                );
              });
            },
            child: Text(
              "Create Article",
              style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleRow()),
                );
              });
            },
            child: Text(
              "View Article",
              style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              setState(() {
print("HELOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOoo ${login.image} , ${login.finalproject}");
if(login.image==null)
  {
    login.image="https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg";
  }
if(login.finalproject==null)
  {login.finalproject=[];}
if(login.finalachievement==null)
  {login.finalachievement=[];}
if(login.finalskill==null)
  {login.finalskill=[];}
if(login.finaledu==null)
  {login.finaledu=[];}
if(login.finalexp==null)
  {login.finalexp=[];}
if(login.about==null)
  {
    login.about="";
  }
if(login.dob==null)
{
  login.dob="";
}
if(login.email==null)
{
  login.email="";
}
if(login.name==null)
{
  login.name="";
}
if(login.phone==null)
{
  login.phone="";
}
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(login.about,login.dob,login.finaledu,login.email,login.finalexp,login.image,login.name,login.phone,login.finalskill,login.experienceexpandlist,login.skillexpandlist,login.educationexpandlist,login.achievementexpandlist,login.projectexpandlist,login.finalachievement,login.finalproject)),
                );
              });
            },
            child: Text(
              "View Profile",
              style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    ));
  }
}
