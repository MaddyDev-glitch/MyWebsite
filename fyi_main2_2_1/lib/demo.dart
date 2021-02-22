import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/articlepage.dart';
import 'package:fyi_main2_2_1/showarticle.dart';
import 'profilepage.dart';
import 'login_page.dart' as login;
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
List<login.ExperienceList> finalexp;
List<login.EducationList> finaledu;
List<login.SkillsList> finalskill;
List<login.ProjectList> finalproject;
List<login.AchievementList> finalachieve;
List<Widget> experienceexpandlist = new List();
List<Widget> skillexpandlist = new List();
List<Widget> educationexpandlist = new List();
List<Widget> projectexpandlist = new List();
List<Widget> achievementexpandlist = new List();


class Testing extends StatefulWidget {
  String username;
  String kname;
  String kimage;
  String kemail;
  String kphone;
  String kdob;
  String kabout;
  List<login.EducationList> kedulist;
  List<login.SkillsList> kskilllist;
  List<login.ExperienceList> kexplist;
  List<login.AchievementList> kachlist;
  List<login.ProjectList> kprolist;

  List<Widget> experiencewidget;
  List<Widget> skillwidget;
  List<Widget> educationwidget;
  List<Widget> achievementwidget;
  List<Widget> projectwidget;
  Testing(this.username,this.kabout,
      this.kdob,
      this.kedulist,
      this.kemail,
      this.kexplist,
      this.kimage,
      this.kname,
      this.kphone,
      this.kskilllist,
      this.experiencewidget,
      this.skillwidget,
      this.educationwidget,
      this.achievementwidget,
      this.projectwidget,
      this.kachlist,
      this.kprolist);
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    name = widget.kname;
    phone = widget.kphone;
    image = widget.kimage;
    email = widget.kemail;
    dob = widget.kdob;
    about = widget.kabout;
    finaledu = widget.kedulist;
    finalskill = widget.kskilllist;
    finalexp = widget.kexplist;
    finalachieve = widget.kachlist;
    finalproject = widget.kprolist;
    experienceexpandlist = widget.experiencewidget;
    skillexpandlist = widget.skillwidget;
    educationexpandlist = widget.educationwidget;
    achievementexpandlist = widget.achievementwidget;
    projectexpandlist = widget.projectwidget;

    print(projectexpandlist.length);
    print(experienceexpandlist.length);
    print(skillexpandlist.length);
    // print(finalexp[0].organization);
    // print(widget.kexplist[0].organization);
    print(image);
  }
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
                      builder: (context) => ProfileScreen(about,dob,finaledu,email,finalexp,image,name,phone,finalskill,experienceexpandlist,skillexpandlist,educationexpandlist,achievementexpandlist,projectexpandlist,finalachieve,finalproject)),
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
