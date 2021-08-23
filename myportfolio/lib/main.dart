//by maddydevglitch
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:myportfolio/AllWorks.dart';
import 'package:myportfolio/ComingSoonPage.dart';
import 'page2.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';
// import 'package:firebase_core/firebase_core.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

GlobalKey<NavigatorState> navigatorKey = new GlobalKey<NavigatorState>();

class SizeConfig {
  static MediaQueryData _mediaQueryData = MediaQueryData();
  static double screenWidth = 0;
  static double screenHeight = 0;
  static double blockSizeHorizontal = 0;
  static double blockSizeVertical = 0;
  void init(BuildContext context) {
    _mediaQueryData = MediaQuery.of(context);
    screenWidth = _mediaQueryData.size.width;
    screenHeight = _mediaQueryData.size.height;
    blockSizeHorizontal = screenWidth / 100;
    blockSizeVertical = screenHeight / 100;
  }
}

launchMailto() async {
  final mailtoLink = Mailto(
    to: ['sri.madhaven@gmail.com'],
    cc: ['sthirum1@binghamton.edu'],
    subject: 'CV Request',
    body: 'Hey! \nWe could like to know you more.',
  );
  await launch('$mailtoLink');
}

visitorCounter() async {
  print("updated");
  final cRef = FirebaseFirestore.instance.collection('VISITS');
  await cRef.doc("visit_count") //Paste the id which was generated automatically
      .set({"count": FieldValue.increment(1)}, SetOptions(merge: true));
}

void main() {
  runApp(MyApp());
  visitorCounter();
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    print("works here too");
    return MaterialApp(
      navigatorKey: navigatorKey,
      builder: (context, widget) => ResponsiveWrapper.builder(
          BouncingScrollWrapper.builder(context, widget!),
          maxWidth: 1800,
          minWidth: 480,
          defaultScale: true,
          breakpoints: [
            ResponsiveBreakpoint.resize(450, name: MOBILE),
            ResponsiveBreakpoint.autoScale(500, name: TABLET),
            ResponsiveBreakpoint.resize(500, name: MOBILE),
            ResponsiveBreakpoint.autoScale(800, name: TABLET),
            ResponsiveBreakpoint.resize(800, name: MOBILE),
            ResponsiveBreakpoint.autoScale(1000, name: TABLET),
            ResponsiveBreakpoint.resize(1200, name: DESKTOP),
            ResponsiveBreakpoint.autoScale(2460, name: "4K"),
          ],
          background: Container(color: Color(0xFFF5F5F5))),
      initialRoute: "/page1",
      routes: {
        '/page1': (context) => MyHomePage(title: "hi"),
        '/page2': (context) => const page2(),
        '/comingsoon': (context) => const ComingSoonPage(),
        '/allworks': (context) => const AllWorks(),
      },
      title: 'Srimadhaven Thirumurthy',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return Scaffold(
      drawerScrimColor: Colors.black26,
      appBar: (SizeConfig.screenWidth < 700)
          ? AppBar(
              backgroundColor: Colors.black,
              title: Text(
                "Contact",
                style: GoogleFonts.lato(
                  fontWeight: FontWeight.w300,
                  color: Colors.white,
                  fontSize: 25,
                ),
              ))
          : null,
      drawer: (SizeConfig.screenWidth < 700)
          ? Drawer(
              child: Container(
                color: Colors.black,
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 20.0, horizontal: 8),
                  child: ListView(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    children: [
                      Text(
                        "Contacts",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: (SizeConfig.screenWidth > 700) ? 35 : 25,
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                        onPressed: () {
                          print("clicked");
                          launchMailto();
                        },
                        child: Text(
                          "Request CV",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: (SizeConfig.screenWidth > 700) ? 35 : 25,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            UrlOpen.openLink(
                                'https://www.strava.com/athletes/18947063');
                          },
                          child: Image.network(
                              "https://i.imgur.com/v9vYJkf.png",
                              height: 40)),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            UrlOpen.openLink(
                                'https://in.linkedin.com/in/srimadhaven-t');
                          },
                          child: Image.network(
                            "https://i.imgur.com/BFI4IX9.png",
                            height: 40,
                          )),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            UrlOpen.openLink(
                                'https://www.instagram.com/sri_madhaven/');
                          },
                          child: Image.network(
                              "https://i.imgur.com/H6oIr50.png",
                              height: 40)),
                      SizedBox(
                        height: 20,
                      ),
                      TextButton(
                          onPressed: () {
                            UrlOpen.openLink(
                                'https://github.com/MaddyDev-glitch');
                          },
                          child: Image.network(
                              "https://i.imgur.com/d3OjvhN.png",
                              height: 40)),
                      SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                ),
              ),
            )
          : null,
      backgroundColor: Colors.black,
      body: Stack(
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 70),
            child: Align(
              alignment: Alignment.topRight,
              child: ImageSlideshow(
                width: SizeConfig.screenWidth / 1.5,
                height: SizeConfig.screenHeight / 1.5,
                initialPage: 0,
                indicatorColor: Colors.blue,
                indicatorBackgroundColor: Colors.grey,
                isLoop: true,
                children: [
                  Image.network(
                    'https://i.imgur.com/MEPABKX.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://i.imgur.com/UaOgDAP.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://i.imgur.com/XjK1US7.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://i.imgur.com/nKtSvxw.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://i.imgur.com/GeDUtCD.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://i.imgur.com/o91ZC1i.png',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://i.imgur.com/rCVK8Hs.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://i.imgur.com/QWYfxEF.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://i.imgur.com/e457Vhc.jpg',
                    fit: BoxFit.cover,
                  ),
                  Image.network(
                    'https://i.imgur.com/pJh9i5V.jpg',
                    fit: BoxFit.cover,
                  ),
                ],
                onPageChanged: (value) {
                  print('Page changed: $value');
                },
                autoPlayInterval: 3000,
              ),
            ),
          ),
          // Align(
          //   alignment: Alignment.topRight,
          //   child: CustomPaint(
          //     painter: TrianglePainter(
          //       strokeColor: Colors.black,
          //       strokeWidth: 10,
          //       paintingStyle: PaintingStyle.fill,
          //     ),
          //     child: Container(
          //       height: SizeConfig.screenHeight / 1.1,
          //       width: SizeConfig.screenWidth / 1.5,
          //     ),
          //   ),
          // ),
          Align(
            alignment: Alignment.topRight,
            child: Container(
              height: SizeConfig.screenHeight / 1.1,
              width: SizeConfig.screenWidth / 1.5,
              child: CustomPaint(
                painter: TrianglePainter(
                  strokeColor: Colors.black,
                  strokeWidth: 10,
                  paintingStyle: PaintingStyle.fill,
                ),
                // child: Container(
                //   height: SizeConfig.screenHeight / 1.1,
                //   width: SizeConfig.screenWidth / 1.5,
                // ),
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(right: SizeConfig.screenWidth / 2.7),
            child: Align(alignment: Alignment.center, child: AboutMe()),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
              child: Container(
                  width: SizeConfig.screenWidth,
                  child: (SizeConfig.screenWidth > 700)
                      ? Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            // TextButton(
                            //   onPressed: () {
                            //     //TODO:Contact page
                            //   },
                            //   child: Text(
                            //     "Contact",
                            //     style: GoogleFonts.lato(
                            //       fontWeight: FontWeight.w300,
                            //       color: Colors.white,
                            //       fontSize:
                            //           (SizeConfig.screenWidth > 700) ? 35 : 25,
                            //     ),
                            //   ),
                            // ),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                              onPressed: () {
                                print("clicked");
                                launchMailto();
                              },
                              child: Text(
                                "Request CV",
                                style: GoogleFonts.lato(
                                  fontWeight: FontWeight.w300,
                                  color: Colors.white,
                                  fontSize:
                                      (SizeConfig.screenWidth > 700) ? 35 : 25,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  UrlOpen.openLink(
                                      'https://www.strava.com/athletes/18947063');
                                },
                                child: Image.network(
                                    "https://i.imgur.com/v9vYJkf.png",
                                    height: 40)),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  UrlOpen.openLink(
                                      'https://in.linkedin.com/in/srimadhaven-t');
                                },
                                child: Image.network(
                                  "https://i.imgur.com/BFI4IX9.png",
                                  height: 40,
                                )),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  UrlOpen.openLink(
                                      'https://www.instagram.com/sri_madhaven/');
                                },
                                child: Image.network(
                                    "https://i.imgur.com/H6oIr50.png",
                                    height: 40)),
                            SizedBox(
                              width: 20,
                            ),
                            TextButton(
                                onPressed: () {
                                  UrlOpen.openLink(
                                      'https://github.com/MaddyDev-glitch');
                                },
                                child: Image.network(
                                    "https://i.imgur.com/d3OjvhN.png",
                                    height: 40)),
                            SizedBox(
                              width: 20,
                            ),
                          ],
                        )
                      : null),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(
                right: SizeConfig.screenWidth / 6,
                top: SizeConfig.screenHeight / 1.8),
            child: Align(
              alignment: Alignment.center,
              child: TextButton(
                  onPressed: () {
                    Navigator.of(context).push(_createRoute());
                  },
                  child: Container(
                    child: Text("Know more >",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 35,
                        )),
                  )),
            ),
          )
        ],
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AboutMe extends StatelessWidget {
  AboutMe();
  @override
  Widget build(BuildContext context) {
    return Container(
      height: SizeConfig.screenHeight / 1.9,
      width: SizeConfig.screenWidth / 2.3,
      decoration: BoxDecoration(
          color: Colors.black87,
          borderRadius: BorderRadius.all(Radius.circular(40))),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.baseline,
            textBaseline: TextBaseline.alphabetic,
            children: [
              Text(
                'Hello, ',
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w500,
                    color: Colors.amber,
                    fontSize: SizeConfig.screenWidth / 19),
              ),
              Text(
                "It's me",
                style: GoogleFonts.lato(
                    fontWeight: FontWeight.w400,
                    color: Colors.amber,
                    fontSize: SizeConfig.screenWidth / 22),
              ),
            ],
          ),
          Text(
            "Srimadhaven",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w600,
                color: Colors.amber,
                fontSize: SizeConfig.screenWidth / 18),
          ),
          Text(
            "An enthusiastic upcoming software developer who loves to create. \nStudies Computer Science @ SUNY at Binghamton. \nA competitive cyclist who likes to travel and a hobby photographer  ",
            style: GoogleFonts.roboto(
                fontWeight: FontWeight.w200,
                color: Colors.white,
                height: 1.5,
                fontSize: 20),
          )
        ],
      ),
    );
  }
}

class TrianglePainter extends CustomPainter {
  final Color strokeColor;
  final PaintingStyle paintingStyle;
  final double strokeWidth;

  TrianglePainter(
      {this.strokeColor = Colors.black,
      this.strokeWidth = 3,
      this.paintingStyle = PaintingStyle.stroke});

  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()
      ..color = strokeColor
      ..strokeWidth = strokeWidth
      ..style = paintingStyle;

    canvas.drawPath(getTrianglePath(size.width, size.height), paint);
  }

  Path getTrianglePath(double x, double y) {
    return Path()
      ..moveTo(0, y)
      ..lineTo(0, 0)
      ..lineTo(x, y)
      ..lineTo(0, y);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.strokeColor != strokeColor ||
        oldDelegate.paintingStyle != paintingStyle ||
        oldDelegate.strokeWidth != strokeWidth;
  }
}

Route _createRoute() {
  return PageRouteBuilder(
    transitionDuration: Duration(seconds: 1),
    pageBuilder: (context, animation, secondaryAnimation) => const page2(),
    transitionsBuilder: (context, animation, secondaryAnimation, child) {
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.easeInOutBack;

      var tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));

      return SlideTransition(
        position: animation.drive(tween),
        child: child,
      );
    },
  );
}
