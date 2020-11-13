// import 'dart:html';
import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';
// import 'package:firebase_auth/firebase_auth.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

final _firestore = Firestore.instance;
final _firestoresend = Firestore.instance;
List<String> url = [
  "https://i.ibb.co/phCRCwP/dfksdfk.png",
];
List<String> name = ["name1", "name2"];

class ImgSlide extends StatefulWidget {
  @override
  _ImgSlideState createState() => _ImgSlideState();
}

class _ImgSlideState extends State<ImgSlide> {
  // int i = 2;
  @override
  Widget build(BuildContext context) {
    Widget ImageCarousel2 = Center(
      child: SizedBox(
        height: 200.0,
        width: 350.0,
        child: Carousel(
          boxFit: BoxFit.cover,
          autoplay: true,
          autoplayDuration: Duration(seconds: 3),
          animationCurve: Curves.fastOutSlowIn,
          animationDuration: Duration(milliseconds: 1000),
          dotSize: 6.0,
          dotIncreasedColor: Color(0xFFFF335C),
          dotBgColor: Colors.transparent,
          dotPosition: DotPosition.topRight,
          dotVerticalPadding: 10.0,
          showIndicator: true,
          indicatorBgPadding: 7.0,
          images: url.map((i) {
            return Builder(
              builder: (BuildContext context) {
                return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(color: Colors.lightBlue),
                    child: GestureDetector(
                        child: Image.network(i, fit: BoxFit.fill),
                        onTap: () {
                          print("NAVIGATOR");
//                          Navigator.push<Widget>(
//                            context,
//                            MaterialPageRoute(
//                              builder: (context) => ImageScreen(i),
//                            ),
//                          );
                        }));
              },
            );
          }).toList(),
        ),
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: Text('image slide show'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.only(top: 80),
            child: new Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: <Widget>[
                ImageCarousel2,
              ],
            ),
          ),
          Container(
              child: Text(
            "EVENTS",
            style: TextStyle(fontSize: 30, fontWeight: FontWeight.w600),
          )),
          Container(
            child: StreamBuilder<QuerySnapshot>(
                stream: _firestore.collection('image').snapshots(),
                builder: (context, snapshot) {
                  List<MessageBubble> messagewidgets = [];
                  if (snapshot.hasData) {
                    final messages = snapshot.data.documents;
                    for (var message in messages) {
                      // final imgtemp = message.data['url'];
                      // final texttemp = message.data['text'];
                      final imgtemp = "a";
                      final texttemp = "a";
                      print("----------=========== $imgtemp");
                      print("----------============= $texttemp");
                      url.add(imgtemp);
                      name.add(texttemp);
                      final messagewidget = MessageBubble(
                        urlM: imgtemp,
                      );
                      messagewidgets.add(messagewidget);
                    }
                  }
                  return Expanded(
                    child: ListView(
                      reverse: true,
                      children: messagewidgets,
                    ),
                  );
                }),
          ),
        ],
      ),
    );
  }
}

class MessageBubble extends StatelessWidget {
  final String urlM;
  MessageBubble({this.urlM});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: <Widget>[
        Text(
          '.',
          style: TextStyle(fontSize: 1),
        ),
      ],
    );
  }
}
