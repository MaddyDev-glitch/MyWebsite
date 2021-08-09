//maddydevglitch
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_website_1/main.dart';
import 'package:url_launcher/url_launcher.dart';

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
  const page2({Key? key}) : super(key: key);

  @override
  _page2State createState() => _page2State();
}

class _page2State extends State<page2> {
  bool selected = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: [
          Stack(
            children: <Widget>[
              Container(
                child: Image.network(
                  "https://i.ibb.co/r0wCwgb/bg1.png",
                  fit: BoxFit.fill,
                  width: SizeConfig.screenWidth,
                ),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.8),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, 3), // changes position of shadow
                    ),
                  ],
                ),
              ),
              SingleChildScrollView(
                child: Wrap(
                  children: [
                    UserCard(),
                  ],
                ),
              ),
            ],
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: Text(
              "Wait! There is more Scroll down",
              style: GoogleFonts.lato(
                fontWeight: FontWeight.w300,
                color: Colors.black,
                fontSize: 45,
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          Container(
            child: Center(
              child: Stack(
                children: [
                  Padding(
                    padding:  EdgeInsets.only(right: SizeConfig.screenWidth / 1.3,left: 50),
                    child: Align(
                        alignment: Alignment.topCenter,
                        child: Image.network("https://i.ibb.co/Fk17gS8/puzzle.png",
                            color: Color.fromRGBO(255, 255, 255, 0.25),
                            colorBlendMode: BlendMode.modulate),
                   ),
                  ),
                  Padding(
                    padding:  EdgeInsets.only(left: SizeConfig.screenWidth / 1.3,right: 50),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Image.network("https://i.ibb.co/JjcHn8H/code.png",
                          color: Color.fromRGBO(255, 255, 255, 0.25),
                          colorBlendMode: BlendMode.modulate),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(right: SizeConfig.screenWidth / 4),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Part Hobbyist",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 35,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " Cyclist",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " Runner",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " Photographer",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " Hiker",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " Swimming(sort of...)",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(left: SizeConfig.screenWidth / 4),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Part Coder",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 35,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " Flutter",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " C/C++",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " Python",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " Java",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " HTML CSS JavaScript (sort of)",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " Arguing with my code",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Text(
                            " \"Making it work!\"",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w300,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 61,
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.only(top: SizeConfig.screenHeight / 12),
                    child: Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: SizeConfig.screenHeight / 6,
                        width: 1,
                        child: Container(color: Colors.grey.shade800),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 50,
          ),
        ],
      ),
      backgroundColor: Colors.white,
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
                        backgroundImage: NetworkImage('https://i.ibb.co/mtBdkZx/maddy1.png'),
                        radius: SizeConfig.screenWidth / 11,
                      ),
                    ),
                    Text(
                      'T Srimadhaven',
                      style: TextStyle(
                        fontFamily: 'DancingScript',
                        fontSize: 30.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    Text(
                      'FLUTTER DEVELOPER',
                      style: TextStyle(
                        color: Colors.amber,
                        fontFamily: 'SourceSansPro',
                        fontSize: 20.0,
                        fontWeight: FontWeight.w200,
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
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
                          style: TextStyle(
                            fontFamily: 'SourceSansPro',
                            fontSize: 15.0,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
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
                            Icons.code,
                            color: Colors.amber,
                          ),
                          title: Text(
                            'github.com/MaddyDev-glitch',
                            style: TextStyle(
                              fontFamily: 'SourceSansPro',
                              fontSize: 15.0,
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          onTap: () => UrlOpen.openLink(
                              'https://github.com/MaddyDev-glitch')),
                    ),
                    SizedBox(
                      height: 15,
                    )
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
