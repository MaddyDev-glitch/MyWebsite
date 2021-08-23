import 'dart:html';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mailto/mailto.dart';
import 'package:myportfolio/page2_Desktop.dart';
import 'package:myportfolio/page2_Mobile.dart';
import 'main.dart';
import 'package:url_launcher/url_launcher.dart';

int a = 0;

class UrlOpen {
  UrlOpen._();

  static Future<void> openLink(String URL) async {
    String gitUrlp = '$URL';
    if (await canLaunch(gitUrlp)) {
      await launch(gitUrlp);
    } else {
      throw 'Could not open Git';
    }
  }
}

class page2 extends StatefulWidget {
  // void didChangeMetrics() {
  //   super.didChangeMetrics();
  //   print('changed size');
  //
  //   // setState(() {
  //   //   print("hi");
  //   // });
  // }

  const page2({Key? key}) : super(key: key);

  @override
  _page2State createState() => _page2State();
}

class _page2State extends State<page2> {
  bool selected = false;

  void initState() {
    super.initState();
  }

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        if (SizeConfig.screenWidth > 700) //DESKTOP VIEW
          return page2DesktopView();
        else //MOBILE VIEW
          return page2MobileView();
      }),
    );
    // WidgetsBinding.instance!.addObserver(page2());
    // void update(){
    //   setState(() {
    //     print("hi");
    //   });
    // }
    if (SizeConfig.screenWidth > 700) //DESKTOP VIEW
      return page2DesktopView();
    else //MOBILE VIEW
      return page2MobileView();
  }
}

class ListWork extends StatelessWidget {
  const ListWork({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyWorks(
                "OpenCEMS",
                "developed an app which incorporates edge computing and as a data point to be sent to a centralized server",
                "https://opencems.sigappfr.org/",
                "desktop",false),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyWorks(
                "Fill My Bowl",
                "A one of a kind community driven app to bridge the supply and demand of the homeless people",
                "https://github.com/MaddyDev-glitch/fill_my_bowl",
                "desktop",false),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyWorks(
                "S-ABLE",
                "(Secure attendance via Bluetooth Low Energy): A cross platform mobile application along with firebase backend and a website for fast parallelized attendance system using Bluetooth geo-validation with proxy detection. ",
                "https://github.com/MaddyDev-glitch/attendance",
                "desktop",false),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: MyWorks(
                "FYI app ",
                "(VIT students club): \n developed an app for posting, viewing the upcoming events and news.",
                "https://www.instagram.com/fyivitc/?hl=en",
                "desktop",false),
          ),
        ],
      ),
    );
  }
}

class MyWorks extends StatelessWidget {
  MyWorks(this.title, this.content, this.url, this.view,this.all);
  String title, content, url, view;
  bool all;
  double factor = 0;
  @override
  Widget build(BuildContext context) {
    if (view == "mobile") {
      factor = 1.3;
    }
    if (view == "desktop") {
      factor = 2.5;
    }
    return TextButton(
      onPressed: () {
        UrlOpen.openLink('$url');
      },
      child: Container(
        width: SizeConfig.screenWidth / factor,
        color: (all==false)?Colors.black12:Colors.white12,
        child: Padding(
          padding: const EdgeInsets.all(30.0),
          child: Container(
            constraints: BoxConstraints(minHeight: 200, maxHeight: 200),
            // height: 40,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  FittedBox(
                    fit: BoxFit.contain,
                    child: Text(
                      "$title",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w300,
                        color: (all==false)?Colors.black:Colors.white,
                        fontSize: 70,
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 10,
                  ),
                  Text(
                    "$content",
                    style: GoogleFonts.lato(
                      fontWeight: FontWeight.w300,
                      color: (all==false)?Colors.black:Colors.white,
                      fontSize: 18,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: Text("Know more >",style: TextStyle(color: Colors.blue),),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class UserCard extends StatelessWidget {
  const UserCard({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Center(
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 50),
              child: Container(
                constraints: BoxConstraints(minWidth: 100, maxWidth: 400),
                decoration: BoxDecoration(
                    color: Color(0xc064584f),
                    border: Border.all(
                      color: Colors.brown.shade800,
                    ),
                    borderRadius: BorderRadius.all(Radius.circular(20))),
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: CircleAvatar(
                        backgroundImage:
                            NetworkImage('https://i.imgur.com/4kVQ4Uk.png'),
                        radius: SizeConfig.screenWidth / 11,
                      ),
                    ),
                    Text(
                      'T Srimadhaven',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                        fontSize: 32,
                      ),
                    ),
                    Text(
                      'FLUTTER DEVELOPER',
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w400,
                        color: Colors.amber,
                        fontSize: 20,
                      ),
                    ),
                    SizedBox(
                      height: 10.0,
                      width: 100.0,
                      child: Divider(
                        color: Colors.white,
                      ),
                    ),
                    Card(
                      color: Colors.black54,
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.add_call,
                          color: Colors.amber,
                        ),
                        title: Text(
                          '+1 (919) 931-7369',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                      ),
                    ),
                    Card(
                      color: Colors.black54,
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                      child: ListTile(
                        leading: Icon(
                          Icons.email,
                          color: Colors.amber,
                        ),
                        title: Text(
                          'sri.madhaven@gmail.com',
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w500,
                            color: Colors.white,
                            fontSize: 15,
                          ),
                        ),
                        onTap: (){
                          launchMailto();
                        },
                      ),
                    ),
                    Card(
                      color: Colors.black54,
                      margin:
                          EdgeInsets.symmetric(vertical: 5.0, horizontal: 30.0),
                      child: ListTile(
                          leading: Icon(
                            Icons.code,
                            color: Colors.amber,
                          ),
                          title: Text(
                            'github.com/MaddyDev-glitch',
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w500,
                              color: Colors.white,
                              fontSize: 15,
                            ),
                          ),
                          onTap: () => UrlOpen.openLink(
                              'https://github.com/MaddyDev-glitch')),
                    ),
                    SizedBox(
                      height: 15,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
