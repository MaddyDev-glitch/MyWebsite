//by maddydevglitch
import 'dart:io';
import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:my_website_1/page2.dart';
import 'package:responsive_framework/responsive_framework.dart';
import 'package:responsive_framework/responsive_wrapper.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:mailto/mailto.dart';
import 'package:url_launcher/url_launcher.dart';

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

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
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
      backgroundColor: Colors.black,
      body: Center(
        child: Stack(
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
                      'https://i.ibb.co/CtHYLtf/b1.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://i.ibb.co/4M2csXR/b2.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://i.ibb.co/yRcfBxg/b3.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://i.ibb.co/gyfgK3x/b4.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://i.ibb.co/T0PmZCY/b5.jpg',
                      fit: BoxFit.cover,
                    ),
                    Image.network(
                      'https://i.ibb.co/Wg5yrdk/b6.png',
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
            Align(
              alignment: Alignment.topRight,
              child: CustomPaint(
                painter: TrianglePainter(
                  strokeColor: Colors.black,
                  strokeWidth: 10,
                  paintingStyle: PaintingStyle.fill,
                ),
                child: Container(
                  height: SizeConfig.screenHeight / 1.1,
                  width: SizeConfig.screenWidth / 1.5,
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(SizeConfig.screenWidth / 7),
              child: ListView(
                children: [
                  AboutMe(),
                ],
              ),
            ),
            Container(
                width: SizeConfig.screenWidth,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(right: 300, top: 10),
                      child: Text(
                        "Contact",
                        style: GoogleFonts.lato(
                          fontWeight: FontWeight.w300,
                          color: Colors.white,
                          fontSize: 35,
                        ),
                      ),
                    ),
                    TextButton(
                      onPressed: () {
                        print("clicked");
                        launchMailto();
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 300, top: 10),
                        child: Text(
                          "Request CV",
                          style: GoogleFonts.lato(
                            fontWeight: FontWeight.w300,
                            color: Colors.white,
                            fontSize: 35,
                          ),
                        ),
                      ),
                    )
                  ],
                )),
            Padding(
              padding: EdgeInsets.only(left:SizeConfig.screenWidth / 7,bottom: 100),
              child: Align(
                alignment: Alignment.bottomLeft,
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
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

class AboutMe extends StatelessWidget {
  const AboutMe({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          crossAxisAlignment: CrossAxisAlignment.baseline,
          textBaseline: TextBaseline.alphabetic,
          children: [
            Text(
              'Hello,',
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
