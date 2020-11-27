import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/ArticleDetails.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

import 'package:dio/dio.dart';

var imagepadtop = 50.0;

String fileName = "CacheData.json";
List<ExperienceList> finalexp;
List<EducationList> finaledu;
List<SkillsList> finalskill;

Response response;
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiMDlZWUpmRlQyblo5QU9jM3BvZDlHbnEwdWwwMiJ9LCJpYXQiOjE2MDE3MTQ0NzJ9.dLU-k1kJkEWNtJT9NhkciM-SJAZ-Fdrl1WZNrA24mR8";
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
  num level;

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

class ProfileScreen extends StatefulWidget {
  String kname;
  String kimage;
  String kemail;
  String kphone;
  String kdob;
  String kabout;
  List<EducationList> kedulist;
  List<SkillsList> kskilllist;
  List<ExperienceList> kexplist;
  ProfileScreen(this.kname);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Future<void> gethttp() async {
    var dio = Dio();
    try {
      response = await dio.get(
        "https://us-central1-fyi-vitc.cloudfunctions.net/api/profile/behaal_baalak",
        queryParameters: {"x-auth-token": token}, //?x-auth-token=$token
      );
      print("GETHHTTP fucntion print -> $response");
      var body = response.data;
      // final ids = json.decode(response.data);
      print(body);
      educationJson = body['education'];
      skillsJson = body['skills'];
      projectsJson = body['projects'];
      achievementsJson = body['achievements'];
      experienceJson = body['experience'];
      about = body['about'];
      dob = body['dob'];
      phone = body['phone'];
      name = body['name'];
      image = body['image'];
      email = body['email'];
      var tempexperience = experienceJson;
      var tempskill=skillsJson;
      var tempedu=educationJson;
      finalexp = tempexperience
          .map<ExperienceList>((json) => ExperienceList.fromJson(json))
          .toList();
      finaledu = tempedu
          .map<ExperienceList>((json) => ExperienceList.fromJson(json))
          .toList();
      finalskill = tempskill
          .map<ExperienceList>((json) => ExperienceList.fromJson(json))
          .toList();

      var tempDir = await getTemporaryDirectory();
      File file = new File(tempDir.path + "/" + fileName);
      file.writeAsString(response.toString(),
          flush: true, mode: FileMode.write);
    } catch (e) {
      print(e);
      print("ERROR");
    }
  }

  Future<void> getcache() async {
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
      image = body['image'];
      email = body['email'];
      experienceJson = body['experience'];
      print(experienceJson.toString());
      var tempexperience = experienceJson;
      finalexp = tempexperience
          .map<ExperienceList>((json) => ExperienceList.fromJson(json))
          .toList();
      print(finalexp[0].organization);
    }
    //TODO: If the Json file does not exist, then make the API Call
    else {
      gethttp();
    }
  }

  List<Expanditem> items = <Expanditem>[
    Expanditem(
        false, // isExpanded ?
        'Experience', // header
        Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(children: <Widget>[
              Text(experienceJson.toString()),
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
            child: Column(children: <Widget>[
              Text("bb"),
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
            child: Container(
              child: Column(children: <Widget>[
                Text("gu"),
              ]),
            )), // body
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
            child: Container(
              child: Column(children: <Widget>[
                Text("vy"),
              ]),
            )), // body
        Icon(
          Icons.post_add,
          color: Colors.blue,
        ) // iconPic
        ),
  ];

  @override
  void initState() {
    super.initState();

    getcache();
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
            image: AssetImage('images/fyi.png'),
          ),
        ),
        // child: FadeInImage(
        //     image: NetworkImage(""),
        //     placeholder: AssetImage("images/noimage.jpeg")),
      ),
    );
  }

  Widget _textFormFieldCalling() {
    List_Criteria = ListView(
      physics: const NeverScrollableScrollPhysics(),
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
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          infocard(name, Icons.person),
          infocard(dob, Icons.calendar_today),
          infocard(email, Icons.mail),
          infocard(phone.toString(), Icons.phone),
          infocard("VIT", Icons.school),
          SizedBox(
            height: 5,
          ),
          Container(height: contheight, child: List_Criteria),
        ],
      ),
    );
  }

  ListView List_Criteria;

  @override
  Widget build(BuildContext context) {
    imagepadtop = MediaQuery.of(context).size.width / 4;

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
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _profileText(),
                  // _circleAvatar(),
                  _textFormFieldCalling(),
                ],
              ),
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
