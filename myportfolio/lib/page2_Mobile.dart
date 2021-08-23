import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/main.dart';
import 'package:myportfolio/page2.dart';

Scaffold page2MobileView() {
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
            textAlign: TextAlign.center,
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
            child: Column(
              children: [
// Padding(
//   padding: EdgeInsets.only(
//       right: SizeConfig.screenWidth / 1.3, left: 50),
//   child: Align(
//     alignment: Alignment.topCenter,
//     child: Image.network(
//         "https://i.ibb.co/Fk17gS8/puzzle.png",
//         color: Color.fromRGBO(255, 255, 255, 0.25),
//         colorBlendMode: BlendMode.modulate),
//   ),
// ),
// Padding(
//   padding: EdgeInsets.only(
//       left: SizeConfig.screenWidth / 1.3, right: 50),
//   child: Align(
//     alignment: Alignment.topCenter,
//     child: Image.network("https://i.ibb.co/JjcHn8H/code.png",
//         color: Color.fromRGBO(255, 255, 255, 0.25),
//         colorBlendMode: BlendMode.modulate),
//   ),
// ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Part Hobbyist",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: SizeConfig.screenWidth / 10,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(
                      left: 20, right: 20, top: 10, bottom: 10),
                  child: SizedBox(
                    height: 1,
                    width: SizeConfig.screenWidth,
                    child: Container(color: Colors.grey.shade500),
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Part Coder",
                      style: GoogleFonts.lato(
                        fontWeight: FontWeight.w300,
                        color: Colors.black,
                        fontSize: SizeConfig.screenWidth / 10,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
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
                        fontSize: SizeConfig.screenWidth / 15,
                      ),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
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
// constraints: BoxConstraints(maxHeight: SizeConfig.screenHeight/3, minHeight: SizeConfig.screenHeight/4 ),
        Container(
          margin: EdgeInsets.symmetric(vertical: 20.0),
          constraints: BoxConstraints(
              maxHeight: SizeConfig.screenHeight / 3,
              minHeight: SizeConfig.screenHeight / 4),
          child: ListWork(),
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
              fontSize: SizeConfig.screenWidth / 8,
            ),
          ),
        ),
      ],
    ),
    backgroundColor: Colors.white,
  );
}