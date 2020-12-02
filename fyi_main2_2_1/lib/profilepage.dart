import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/ArticleDetails.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';
import 'login_page.dart' as login;
import 'package:dio/dio.dart';

var imagepadtop = 50.0;
String fileName = "CacheData.json";
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
List<Expanditem> items;
Response response;
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiYmVoYWFsX2JhYWxhayJ9LCJpYXQiOjE2MDY4MTA0NDJ9.nNqNv9KkAGoO59dVQOZrdezSJ58CeoH5RtRnt-lQOGY";
double contheight = 300;
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

class Expanditem {
  bool isExpanded;
  final String header;
  final Widget body;
  final Icon iconpic;
  Expanditem(this.isExpanded, this.header, this.body, this.iconpic);
}

class ProfileScreen extends StatefulWidget {
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
  ProfileScreen(
      this.kabout,
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
  _ProfileScreenState createState() => _ProfileScreenState();
}
class EduTag {
  String degree;
  String institute;
  String from;
  String to;
  String status;
  String desc;

  EduTag(this.degree, this.institute,this.from,this.to,this.status,this.desc);

  Map toJson() => {
    "degree": degree,
    "description": desc,
    "from": from,
    "to": to,
    "status": status,
    "institute": institute,
  };
}
class ExpTag {
  String organization;
  String post;
  String from;
  String to;
  String status;
  String desc;

  ExpTag(this.organization, this.post,this.from,this.to,this.status,this.desc);

  Map toJson() => {
    "organization": organization,
    "description": desc,
    "from": from,
    "to": to,
    "status": status,
    "post": post,
  };
}
class SkillsTag {
  String field;
  String value;


  SkillsTag(this.field, this.value);

  Map toJson() => {
    "field": field,
    "value":value,
  };
}
class ProjectsTag {
  String status;
  String to;
  String from;
  String link;
  String desc;
  String name;


  ProjectsTag(this.desc, this.status,this.from,this.to,this.link,this.name);

  Map toJson() => {
    "description": desc,
    "status":status,
    "from": from,
    "to":to,
    "link": link,
    "name":name,
  };
}
class AchieveTag {
  String issuer;
  String year;
  String desc;
  String title;


  AchieveTag(this.desc, this.title,this.year,this.issuer);

  Map toJson() => {
    "description": desc,
    "title":title,
    "year": year,
    "issuer":issuer,
      };
}

class _ProfileScreenState extends State<ProfileScreen> {
  // Future<void> gethttp() async {
  //   var dio = Dio();
  //   try {
  //     response = await dio.get(
  //       "https://us-central1-fyi-vitc.cloudfunctions.net/api/profile/behaal_baalak",
  //       queryParameters: {"x-auth-token": token}, //?x-auth-token=$token
  //     );
  //     print("GETHHTTP fucntion print -> $response");
  //     var body = response.data;
  //     // final ids = json.decode(response.data);
  //     print(body);
  //     educationJson = body['education'];
  //     skillsJson = body['skills'];
  //     projectsJson = body['projects'];
  //     achievementsJson = body['achievements'];
  //     experienceJson = body['experience'];
  //     about = body['about'];
  //     dob = body['dob'];
  //     phone = body['phone'];
  //     name = body['name'];
  //     image = body['image'];
  //     email = body['email'];
  //     var tempexperience = experienceJson;
  //     var tempskill=skillsJson;
  //     var tempedu=educationJson;
  //     finalexp = tempexperience
  //         .map<ExperienceList>((json) => ExperienceList.fromJson(json))
  //         .toList();
  //     finaledu = tempedu
  //         .map<ExperienceList>((json) => ExperienceList.fromJson(json))
  //         .toList();
  //     finalskill = tempskill
  //         .map<ExperienceList>((json) => ExperienceList.fromJson(json))
  //         .toList();
  //
  //     var tempDir = await getTemporaryDirectory();
  //     File file = new File(tempDir.path + "/" + fileName);
  //     file.writeAsString(response.toString(),
  //         flush: true, mode: FileMode.write);
  //   } catch (e) {
  //     print(e);
  //     print("ERROR");
  //   }
  // }
  //
  // Future<void> getcache() async {
  //   var cacheDir = await getTemporaryDirectory();
  //   print("getcache");
  //   if (await File(cacheDir.path + "/" + fileName).exists()) {
  //     print("Loading from cache");
  //     var cachedata = File(cacheDir.path + "/" + fileName).readAsStringSync();
  //     var cachedata1 = json.decode(cachedata);
  //     print(cachedata1);
  //     var body = cachedata1;
  //     // final ids = json.decode(response.data);
  //     educationJson = body['education'];
  //     about = body['about'];
  //     skillsJson = body['skills'];
  //     projectsJson = body['projects'];
  //     dob = body['dob'];
  //     phone = body['phone'];
  //     name = body['name'];
  //     achievementsJson = body['achievements'];
  //     image = body['image'];
  //     email = body['email'];
  //     experienceJson = body['experience'];
  //     print(experienceJson.toString());
  //     var tempexperience = experienceJson;
  //     finalexp = tempexperience
  //         .map<ExperienceList>((json) => ExperienceList.fromJson(json))
  //         .toList();
  //     print(finalexp[0].organization);
  //   }
  //   //TODO: If the Json file does not exist, then make the API Call
  //   else {
  //     gethttp();
  //   }
  // }

  @override
  void initState() {
    name = widget.kname;
    phone = widget.kphone;
    image = widget.kimage;
    email = widget.kemail;
    dob = widget.kdob;
    about = widget.kabout;
    finaledu = widget.kedulist;
    finalskill = widget.kskilllist;
    finalexp = widget.kexplist;
    finalachieve=widget.kachlist;
    finalproject=widget.kprolist;
    experienceexpandlist = widget.experiencewidget;
    skillexpandlist = widget.skillwidget;
    educationexpandlist = widget.educationwidget;
    achievementexpandlist = widget.achievementwidget;
    projectexpandlist = widget.projectwidget;
    print(projectexpandlist[0]);
    print(finalexp[0].organization);
    print(widget.kexplist[0].organization);
    print(image);
    print(widget.kimage);

    super.initState();
    items = <Expanditem>[
      Expanditem(
          false, // isExpanded ?
          'Education', // header
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: educationexpandlist.length,
                        itemBuilder: (context, int index) {
                          Widget widget = educationexpandlist.elementAt(index);
                          return widget;
                        })
                    // functioneducation(),
                  ])), // body
          Icon(
            Icons.school,
            color: Colors.blue,
          ) // iconPic
          ),
      Expanditem(
          false, // isExpanded ?
          'Experience', // header
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: experienceexpandlist.length,
                        itemBuilder: (context, int index) {
                          Widget widget = experienceexpandlist.elementAt(index);
                          return widget;
                        })
                  ])), // body
          Icon(
            Icons.work,
            color: Colors.blue,
          ) // iconPic
          ),
      Expanditem(
          false, // isExpanded ?
          'Skills', // header
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: skillexpandlist.length,
                        itemBuilder: (context, int index) {
                          Widget widget = skillexpandlist.elementAt(index);
                          return widget;
                        })
                    // functioneducation(),
                  ])), // body
          Icon(
            Icons.star,
            color: Colors.blue,
          ) // iconPic
          ),
      Expanditem(
          false, // isExpanded ?
          'Achievements', // header
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: achievementexpandlist.length,
                        itemBuilder: (context, int index) {
                          Widget widget =
                              achievementexpandlist.elementAt(index);
                          return widget;
                        })
                    // functioneducation(),
                  ])), // body
          Icon(
            Icons.stars,
            color: Colors.blue,
          ) // iconPic
          ),
      Expanditem(
          false, // isExpanded ?
          'Projects', // header
          Padding(
              padding: EdgeInsets.all(8.0),
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        itemCount: projectexpandlist.length,
                        itemBuilder: (context, int index) {
                          Widget widget = projectexpandlist.elementAt(index);
                          return widget;
                        })
                    // functioneducation(),
                  ])), // body
          Icon(
            Icons.post_add,
            color: Colors.blue,
          ) // iconPic
          ),
    ];

    // Map mapedu = {
    //   "degree": finaledu[0].degree,
    //   "description": finaledu[0].description,
    //   "from": finaledu[0].from,
    //   "to": finaledu[0].to,
    //   "status": finaledu[0].status,
    //   "institute": finaledu[0].institute,
    // };
  }

  Widget _profileText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Profile',
        style: TextStyle(
          fontSize: 35.0,
          letterSpacing: 1.5,
          color: Colors.black87,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _circleAvatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 5),
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: NetworkImage(widget.kimage),
          ),
        ),
        // child: FadeInImage(
        //     image: NetworkImage(""),
        //     placeholder: AssetImage("images/noimage.jpeg")),
      ),
    );
  }

  Widget _textFormFieldCalling() {
    List_Criteria = Column(
      children: [
        ExpansionPanelList(
          elevation: 0,
          dividerColor: Colors.white,
          expansionCallback: (int index, bool isExpanded) {
            setState(() {
              items[index].isExpanded = !items[index].isExpanded;
            });
          },
          children: items.map((Expanditem item) {
            return ExpansionPanel(
              canTapOnHeader: true,
              headerBuilder: (BuildContext context, bool isExpanded) {
                return Container(
                  child: ListTile(
                      leading: item.iconpic,
                      title: Text(
                        item.header,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                          fontSize: 18.0,
                          fontWeight: FontWeight.w300,
                        ),
                      )),
                );
              },
              isExpanded: item.isExpanded,
              body: item.body,
            );
          }).toList(),
        ),
      ],
    );
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: SingleChildScrollView(
        child: Column(
          // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            infocard(name, Icons.person),
            infocard(dob, Icons.calendar_today),
            infocard(email, Icons.mail),
            infocard(phone.toString(), Icons.phone),
            // infocard("VIT", Icons.school),
            SizedBox(
              height: 5,
            ),
            List_Criteria,
          ],
        ),
      ),
    );
  }

  Column List_Criteria;

  @override
  Widget build(BuildContext context) {
    imagepadtop = MediaQuery.of(context).size.width / 4;

    void _editprofile() {
      print(finaledu);
      print(finalproject);
      List<EduTag> edutags = [];
      List<ExpTag> exptags = [];
      List<SkillsTag> skitags = [];
      List<ProjectsTag> protags = [];
      List<AchieveTag> achtags = [];

      for(int i=0;i<finaledu.length;i++)
        {
          edutags.add(EduTag(finaledu[i].degree, finaledu[i].institute, finaledu[i].from, finaledu[i].to, finaledu[i].status, finaledu[i].description));
        }
      String jsonEdu = jsonEncode(edutags);
      for(int i=0;i<finalexp.length;i++)
      {
        exptags.add(ExpTag( finalexp[i].organization,finalexp[i].post, finalexp[i].from, finalexp[i].to, finalexp[i].status, finalexp[i].description));
      }
      String jsonExp = jsonEncode(exptags);
      for(int i=0;i<finalskill.length;i++)
      {
        skitags.add(SkillsTag( finalskill[i].field,finalskill[i].level));
      }
      String jsonskill = jsonEncode(skitags);
      for(int i=0;i<finalproject.length;i++)
      {
        protags.add(ProjectsTag(finalproject[i].description, finalproject[i].status,finalproject[i].from,finalproject[i].to,finalproject[i].link,finalproject[i].name));
      }
      String jsonproject = jsonEncode(protags.toString());
      for(int i=0;i<finalachieve.length;i++)
      {
        achtags.add(AchieveTag(finalachieve[i].description,finalachieve[i].title,finalachieve[i].year,finalachieve[i].issuer));
      }
      String jsonachive = jsonEncode(achtags);
      // List<dynamic> arrays_education = [];
      List<dynamic> arrays_experience = [];
      List<dynamic> arrays_skills = [];
      List<dynamic> arrays_achievement = [];
      List<dynamic> arrays_project = [];

      DateTime selectedDate = DateTime.now();
      _selectDate(BuildContext context) async {
        final DateTime picked = await showDatePicker(
          context: context,
          initialDate: selectedDate, // Refer step 1
          firstDate: DateTime(1900),
          lastDate: DateTime(2050),
        );
        if (picked != null && picked != selectedDate)
          setState(() {
            selectedDate = picked;
          });
      }

      final nameController = TextEditingController();
      final phoneController = TextEditingController();
      final aboutController = TextEditingController();
      final emailController = TextEditingController();
      final dobController = TextEditingController();

      nameController.text = widget.kname;
      phoneController.text = widget.kphone.toString();
      aboutController.text = widget.kabout;
      emailController.text = widget.kemail;
      dobController.text = widget.kdob;

      void updateprofile() async {
        var dio = Dio();
        dio.options.headers['content-Type'] = 'application/json';
        dio.options.headers["x-auth-token"] = "$token";
        Map data = {
          "name": nameController.text,
          "about": aboutController.text,
          "picture": widget.kimage,
          "email": emailController.text,
          "phone": phoneController.text,
          "dob": dobController.text,
          "education": jsonEdu,
          "achievements":jsonachive ,
          "skills": jsonskill,
          "projects": jsonproject,
          "experience": jsonExp,
          "google": true,
        };
        Map finaldata = {"profile": data};
        print(finaldata);
        try {
          print("SUPER TRY");
          Response response = await dio.put(
            "https://us-central1-fyi-vitc.cloudfunctions.net/api/profile",
          data:finaldata,
          );
          var result = response.data;
          print(result);
        } catch (e) {
          print(e);
          print("ERROR");
        }
      }

      showDialog(
        context: context, barrierDismissible: false, // user must tap button!
        builder: (BuildContext context) {
          return new AlertDialog(
            insetPadding: EdgeInsets.all(5),
            title: new Text('Edit profile'),
            content: Container(
              height: MediaQuery.of(context).size.width,
              width: MediaQuery.of(context).size.width,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Name",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      controller: nameController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Phone",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextField(
                      controller: phoneController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text("About",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    TextField(
                      maxLines: 5,
                      controller: aboutController,
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    FlatButton(
                        onPressed: () {
                          setState(() {
                            _selectDate(context);
                          });
                        },
                        child: Text("Date of Birth",
                            style: TextStyle(fontWeight: FontWeight.bold))),
                    SizedBox(
                      height: 10,
                    ),
                    Text("Education",
                        style: TextStyle(fontWeight: FontWeight.bold)),
                    Container(
                      height: 200,
                      child: ListView.builder(
                        cacheExtent: 2000000,
                        addAutomaticKeepAlives: true,
                        addRepaintBoundaries: false,
                        itemBuilder: (context, index) {
                          Widget widget = educationexpandlist.elementAt(index);
                          // return widget;
                          // return Dismissible(
                          //   key: Key(index.toString()),
                          //   child: widget,
                          // );
                          return KeepAlive(
                            keepAlive: true,
                            child: Dismissible(
                              key: ValueKey(educationexpandlist.length),

                              onDismissed: (direction) {
                                educationexpandlist.removeAt(index);
                                // delete_count = delete_count + 1;
                                setState(() {
                                  // if (list.length == 0) {
                                  //   // editorHeight = 0;
                                  // }
                                });
                              },
                              // Show a red background as the item is swiped away.
                              // background: Container(color: Colors.red),
                              background: Container(
                                color: Colors.red.shade800,
                                padding: EdgeInsets.symmetric(horizontal: 20),
                                alignment: AlignmentDirectional.centerStart,
                                child: Icon(
                                  Icons.delete,
                                  size: 50,
                                  color: Colors.white,
                                ),
                              ),
                              child: ListTile(title: widget),
                            ),
                          );
                        },
                        itemCount: educationexpandlist.length,
                      ),
                    )
                  ],
                ),
              ),
            ),
            actions: [
              new FlatButton(
                child: new Text('Nah, I\'d like to keep it'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              new FlatButton(
                child: new Text(
                  'Save Changes',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue.shade700),
                ),
                onPressed: () async{
                  await updateprofile();
                  setState(() {
                    Navigator.of(context).pop();
                  });
                },
              ),
            ],
          );
        },
      );
    }

    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                alignment: Alignment.topCenter,
                children: [
                  CustomPaint(
                    child: Container(),
                    painter: HeaderCurvedContainer(),
                  ),
                  _circleAvatar(),
                ],
              ),
              _profileText(),
              FlatButton(
                  onPressed: () {
                    setState(() {
                      _editprofile();
                    });
                  },
                  child: Text("EDIT")),
              // _circleAvatar(),
              _textFormFieldCalling(),
            ],
          ),
        ),
      ),
    );
  }
}

class infocard extends StatelessWidget {
  String data;
  IconData icon;
  infocard(this.data, this.icon);
  @override
  Widget build(BuildContext context) {
    return Material(
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          4,
        ),
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(
            10,
          ),
          // color: Colors.blue
        ),
        width: MediaQuery.of(context).size.width,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Row(
            children: [
              Icon(
                icon,
                color: Theme.of(context).primaryColor,
              ),
              SizedBox(
                width: 35,
              ),
              Text(
                data,
                style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w300,
                    color: Colors.black),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Color(0xff555555)
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff3466aa);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
