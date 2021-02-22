import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/login_page.dart' as login;
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fyi_main2_2_1/profilepage.dart';
import 'package:dio/dio.dart';
var det=login.det;
var username=login.username;
class LoadingScreen extends StatefulWidget {
  @override
  _LoadingScreenState createState() => _LoadingScreenState();

}
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
List<login.ExperienceList> finalexp=[];
List<login.EducationList> finaledu=[];
List<login.SkillsList> finalskill=[];
List<login.ProjectList> finalproject=[];
List<login.AchievementList> finalachievement=[];

List<Widget> experienceexpandlist = new List();
List<Widget> skillexpandlist = new List();
List<Widget> educationexpandlist = new List();
List<Widget> projectexpandlist = new List();
List<Widget> achievementexpandlist = new List();

class _LoadingScreenState extends State<LoadingScreen> {
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
          .map<login.ExperienceList>((json) => login.ExperienceList.fromJson(json))
          .toList();
      finaledu = tempedu
          .map<login.EducationList>((json) => login.EducationList.fromJson(json))
          .toList();
      finalskill = tempskill
          .map<login.SkillsList>((json) => login.SkillsList.fromJson(json))
          .toList();
      finalproject = temppro
          .map<login.ProjectList>((json) => login.ProjectList.fromJson(json))
          .toList();
      finalachievement = tempach
          .map<login.AchievementList>((json) => login.AchievementList.fromJson(json))
          .toList();
      print("${finalproject.length},${finaledu.length},${finalexp.length}, ${finalachievement.length}, ${finalskill.length}");
      experienceexpandlist.clear();
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
      skillexpandlist.clear();
      for (int i = 0; i < finalskill.length; i++) {
        print("hello");
        skillexpandlist
            .add(SkillContainer(finalskill[i].field, finalskill[i].level.toString()));
      }
      educationexpandlist.clear();
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
      achievementexpandlist.clear();
      for (int i = 0; i < finalachievement.length; i++) {
        achievementexpandlist.add(AchievementContainer(
            finalachievement[i].title,
            finalachievement[i].year,
            finalachievement[i].issuer,
            finalachievement[i].description));
      }
      projectexpandlist.clear();
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

  @override
  void initState() {
    super.initState();
    Reload();
    gethttp(det);
    print('init state called');
  }
  Future Reload() async {
    print('hello');
    await login.signInWithGoogle(context);

    // Navigator.push(context, MaterialPageRoute(builder: (context) {
    //   return LocationScreen(locationWeather: weatherData);
    // }));
    print("HELOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOOoo ${login.image} , ${login.finalproject}");
    if(login.image==null)
    {
      login.image="https://moonvillageassociation.org/wp-content/uploads/2018/06/default-profile-picture1.jpg";
    }
    if(finalproject==null)
    {finalproject=[];}
    if(finalachievement==null)
    {finalachievement=[];}
    if(finalskill==null)
    {finalskill=[];}
    if(finaledu==null)
    {finaledu=[];}
    if(finalexp==null)
    {finalexp=[];}
    if(about==null)
    {
      about="";
    }
    if(dob==null)
    {
      dob="";
    }
    if(email==null)
    {
      email="";
    }
    if(name==null)
    {
      name="";
    }
    if(phone==null)
    {
      phone="";
    }
    print("LIST");
    print(finalskill);
    print(skillexpandlist.length);
    Navigator.push(
      context,
      MaterialPageRoute(
          builder: (context) => ProfileScreen(about,dob,finaledu,email,finalexp,image,name,phone,finalskill,experienceexpandlist,skillexpandlist,educationexpandlist,achievementexpandlist,projectexpandlist,finalachievement,finalproject)),
    );
  }

  @override
  void deactivate() {
    // TODO: implement deactivate
    print('deactivate called');
    super.deactivate();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Center(
              child: SpinKitCubeGrid(
                color: Colors.blue.shade300,
                size: 200,
              )),
          SizedBox(height: 10,),
          Center(child: Text("Loading...",style: TextStyle(fontSize: 25,fontWeight:FontWeight.w400))),
          Padding(
            padding: const EdgeInsets.all(10.0),
            child: Center(child: Text("Please wait till we finish scribbling the changes onto your profile",style: TextStyle(fontSize: 18,fontWeight:FontWeight.w300,color: Colors.black26,),textAlign: TextAlign.center,)),
          )

        ],
      ),
    );
  }
}


