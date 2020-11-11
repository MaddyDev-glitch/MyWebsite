import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:core';
import 'package:intl/intl.dart';
// import 'package:flutter_html/flutter_html.dart';
// import 'package:css_text/css_text.dart';
import 'package:flutter_widget_from_html/flutter_widget_from_html.dart';

var id;
Response response;
String title;
int date;
String coverImage;
List<dynamic> contentlocal = [];
List<String> text = [];
List<String> type = [];
List<Widget> listcont = new List();
int superindex = 0;
BuildContext ctxt;
// class TagContent {
//   String type;
//   String content;
//
//   TagContent(this.type, this.content);
// }

void con() async {
  for (int i = 0; i < contentlocal.length; i++) {
    print("hello");
    var x = jsonEncode(contentlocal[i]);
    Details userDetails = Details.fromJson(jsonDecode(x));
    text.add(userDetails.content);
    type.add(userDetails.type);
    // print(userDetails.type);
    // print(userDetails.content);
    // print("${text[i]}   ${type[i]}");
    // buildBody(ctxt, index);
    // index = index + 1;
  }
  buildBody();
}

class Details {
  String content;
  String type;

  Details({
    this.content,
    this.type,
  });

  Details.fromJson(Map<String, dynamic> json) {
    content = json['content'];
    type = json['type'];
  }

  Map<String, String> toJson() {
    final Map<String, String> data = new Map<String, dynamic>();
    data['content'] = this.content;
    data['type'] = this.type;
    return data;
  }
}

class ArticleDetails extends StatefulWidget {
  String id;
  String title;
  int date;
  String coverImage;
  List<dynamic> content = [];

  ArticleDetails(this.id, this.title, this.coverImage, this.date, this.content);
  @override
  _ArticleDetailsState createState() => _ArticleDetailsState();
}

class _ArticleDetailsState extends State<ArticleDetails> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    id = widget.id;
    title = widget.title;
    coverImage = widget.coverImage;
    date = widget.date;
    contentlocal = widget.content;
    con();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: [
          Container(
              height: MediaQuery.of(context).size.height - 60,
              child: Container(
                height: 600,
                child: Column(
                  children: [
                    ArticleContent(title, coverImage, 111),
                    Container(
                      height: 300,
                      child: new ListView.builder(
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          // con();

                          Widget widget = listcont.elementAt(index);
                          return widget;
                        },
                        itemCount: listcont.length,
                      ),
                    )




                  ],
                ),
              )),
        ],
      ),
    ));
  }
}

class ArticleContent extends StatelessWidget {
  String title;
  int datetime;
  String coverImage;
  ArticleContent(this.title, this.coverImage, this.datetime);
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.fromLTRB(10, 10, 10, 10),
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(20),
                topLeft: Radius.circular(20),
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20)),
            boxShadow: [
              BoxShadow(
                color: Colors.blue.withOpacity(0.1),
                spreadRadius: 1,
                blurRadius: 2,
                offset: Offset(0, 1), // changes position of shadow
              ),
            ],
          ),
          height: MediaQuery.of(context).size.height - 500,
          width: double.infinity,
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$title",
                      style: TextStyle(
                        fontSize: 45,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Posted on ${readTimestamp(date)}", // ${DateTime.fromMillisecondsSinceEpoch(date)}
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Text(
                      "By @Author", // ${DateTime.fromMillisecondsSinceEpoch(date)}
                      style: TextStyle(
                        fontSize: 17,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    Container(
                        height: 150,
                        // width: double.infinity-15,
                        child: FadeInImage(
                            image: NetworkImage(coverImage),
                            placeholder: AssetImage("images/noimage.jpeg"))),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}

String readTimestamp(int timestamp) {
  var now = DateTime.now();
  var format = DateFormat('EEE d/M: HH:mm');
  var date = DateTime.fromMillisecondsSinceEpoch(timestamp * 1000);
  var diff = now.difference(date);
  var time = '';

  if (diff.inSeconds <= 0 ||
      diff.inSeconds > 0 && diff.inMinutes == 0 ||
      diff.inMinutes > 0 && diff.inHours == 0 ||
      diff.inHours > 0 && diff.inDays == 0) {
    time = format.format(date);
  } else if (diff.inDays > 0 && diff.inDays < 7) {
    if (diff.inDays == 1) {
      time = diff.inDays.toString() + ' DAY AGO';
    } else {
      time = diff.inDays.toString() + ' DAYS AGO';
    }
  } else {
    if (diff.inDays == 7) {
      time = (diff.inDays / 7).floor().toString() + ' WEEK AGO';
    } else {
      time = (diff.inDays / 7).floor().toString() + ' WEEKS AGO';
    }
  }

  return time;
}

Widget buildBody() {
  String finalString;
  for (int i = 0; i < contentlocal.length; i++) {
    print("hello123");
    var x = i;
    if (type[x] == "text") {
      print(type[x]);
      // var myRichText = HTML.toRichText(ctxt, type[x], linksCallback: (link) {
      //   print("You clicked on $link");
      // });
      listcont.add(Container(
        // child: myRichText,
        // child: (Text("${text[x]}",style: TextStyle(fontSize: 20),)),
        child: HtmlWidget(text[x],
        webView: true,
        webViewJs: true,),
        // child: Html(
        //   data:text[x],
        //   onLinkTap: (url) {
        //     print("Opening $url...");
        //   },
        // ),
      ));
    } else {
      listcont.add(
        Container(
            height: 250,
            child: FadeInImage(
                image: NetworkImage(coverImage),
                placeholder: AssetImage("images/noimage.jpeg"))),
      );
    }
  }

  // return new Container(
  //   child: (Text("hello")),
  // );
  // return new Text(litems[index]);
}
