import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/page2.dart';

import 'main.dart';
bool hello=false;
class AllWorks extends StatefulWidget {
  const AllWorks({Key? key}) : super(key: key);

  @override
  _AllWorksState createState() => _AllWorksState();
}

class _AllWorksState extends State<AllWorks> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black,
        body: LayoutBuilder(
          builder: (context, constraints) {
            if (SizeConfig.screenWidth > 700)
              return ListView(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                                onPressed: () {
                                  navigatorKey.currentState!.pop();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 40,
                                ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "My Works",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Wrap(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "OpenCEMS",
                            "developed an app which incorporates edge computing and as a data point to be sent to a centralized server",
                            "https://opencems.sigappfr.org/",
                            "desktop",
                            true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "Fill My Bowl",
                            "A one of a kind community driven app to bridge the supply and demand of the homeless people",
                            "https://github.com/MaddyDev-glitch/fill_my_bowl",
                            "desktop",
                            true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "S-ABLE",
                            "(Secure attendance via Bluetooth Low Energy): A cross platform mobile application along with firebase backend and a website for fast parallelized attendance system using Bluetooth geo-validation with proxy detection. ",
                            "https://github.com/MaddyDev-glitch/attendance",
                            "desktop",
                            true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "FYI app ",
                            "(VIT students club): \n developed an app for posting, viewing the upcoming events and news.",
                            "https://www.instagram.com/fyivitc/?hl=en",
                            "desktop",
                            true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "Diary OS",
                            "Operating System Project: \nReal-Time Operating System for Personal journaling with mood tracking feature with mouse support and filesystem built using COSMOS OS",
                            "https://github.com/MaddyDev-glitch/DiaryOS",
                            "desktop",
                            true),
                      ),
                    ],
                  ),
                )
              ],
            );
            else
              return  ListView(
              children: [
                Container(
                  color: Colors.white,
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Align(
                            alignment: Alignment.topLeft,
                            child: TextButton(
                                onPressed: () {
                                  navigatorKey.currentState!.pop();
                                },
                                child: Icon(
                                  Icons.arrow_back_ios,
                                  color: Colors.black,
                                  size: 40,
                                ))),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(top: 60),
                        child: Align(
                          alignment: Alignment.topCenter,
                          child: Text(
                            "My Works",
                            style: GoogleFonts.lato(
                              fontWeight: FontWeight.w200,
                              color: Colors.black,
                              fontSize: SizeConfig.screenWidth / 8,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Center(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "OpenCEMS",
                            "developed an app which incorporates edge computing and as a data point to be sent to a centralized server",
                            "https://opencems.sigappfr.org/",
                            "desktop",
                            true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "Fill My Bowl",
                            "A one of a kind community driven app to bridge the supply and demand of the homeless people",
                            "https://github.com/MaddyDev-glitch/fill_my_bowl",
                            "desktop",
                            true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "S-ABLE",
                            "(Secure attendance via Bluetooth Low Energy): A cross platform mobile application along with firebase backend and a website for fast parallelized attendance system using Bluetooth geo-validation with proxy detection. ",
                            "https://github.com/MaddyDev-glitch/attendance",
                            "desktop",
                            true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "FYI app ",
                            "(VIT students club): \n developed an app for posting, viewing the upcoming events and news.",
                            "https://www.instagram.com/fyivitc/?hl=en",
                            "desktop",
                            true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(18.0),
                        child: MyWorks(
                            "Diary OS",
                            "Operating System Project: \nReal-Time Operating System for Personal journaling with mood tracking feature with mouse support and filesystem built using COSMOS OS",
                            "https://github.com/MaddyDev-glitch/DiaryOS",
                            "desktop",
                            true),
                      ),
                    ],
                  ),
                )
              ],
            );
          },
        ));
  }
}
