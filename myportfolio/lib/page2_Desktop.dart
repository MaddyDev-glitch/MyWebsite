import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/ComingSoonPage.dart';
import 'package:myportfolio/main.dart';
import 'package:myportfolio/page2.dart';

Scaffold page2DesktopView(){
  return Scaffold(
    body: ListView(
      children: [
        Stack(
          children: <Widget>[
            Container(
              child: Image.network(
                "https://i.imgur.com/XqRkSsY.png",
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
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(onPressed: (){
                    navigatorKey.currentState!.pop();
                  }, child:Icon(Icons.arrow_back_ios,color: Colors.white,size: 40,))),
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
                  padding: EdgeInsets.only(
                      right: SizeConfig.screenWidth / 1.3, left: 50),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                        "https://i.ibb.co/Fk17gS8/puzzle.png",
                        color: Color.fromRGBO(255, 255, 255, 0.25),
                        colorBlendMode: BlendMode.modulate),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(
                      left: SizeConfig.screenWidth / 1.3, right: 50),
                  child: Align(
                    alignment: Alignment.topCenter,
                    child: Image.network(
                        "https://i.ibb.co/JjcHn8H/code.png",
                        color: Color.fromRGBO(255, 255, 255, 0.25),
                        colorBlendMode: BlendMode.modulate),
                  ),
                ),
                Padding(
                  padding:
                  EdgeInsets.only(right: SizeConfig.screenWidth / 4),
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
                  padding:
                  EdgeInsets.only(left: SizeConfig.screenWidth / 4),
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
                  padding:
                  EdgeInsets.only(top: SizeConfig.screenHeight / 12),
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
        Center(
          child: Text(
            "My Works",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w300,
              color: Colors.black,
              fontSize: 45,
            ),
          ),
        ),
        SizedBox(
          height: 20,
        ),
        ConstrainedBox(
          constraints: BoxConstraints(
              maxHeight: SizeConfig.screenHeight / 2.5,
              minHeight: SizeConfig.screenHeight / 2.8),
          child: Container(
            margin: EdgeInsets.symmetric(vertical: 20.0),
            child: ListWork(),
          ),
        ),
        Padding(
          padding: const EdgeInsets.all(15.0),
          child: Align(
            alignment: Alignment.bottomRight,
            child: Container(
              child: TextButton(
                onPressed: (){
                  navigatorKey.currentState!.pushNamed('/allworks');
                  // navigatorKey.currentState!.pushNamed('/comingsoon');
                },
                child: Text(
                  "View All Works >>",
                  style: GoogleFonts.lato(
                    fontWeight: FontWeight.w300,
                    color: Colors.black,
                    fontSize: 35,
                  ),
                ),
              ),
            ),
          ),
        ),
        SizedBox(
          height: 50,
        ),
        Center(
          child: Text(
            "#MoreToCome",
            style: GoogleFonts.lato(
              fontWeight: FontWeight.w200,
              color: Colors.black,
              fontSize: SizeConfig.screenWidth / 20,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.white,
  );
}