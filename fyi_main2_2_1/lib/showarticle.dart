import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'package:dio/dio.dart';
import 'dart:core';
import 'ArticleDetails.dart';
import 'package:intl/intl.dart';

List<Article> finallist;
List<String> finaltitle;

List<Widget> list = new List();
int supercount = 0;
ScrollController _controller;

var datadetail;
String titledetail;
int datedetail;
String coverImagedetail;
List<dynamic> articledetail = [];

Future<void> gethttp(int index) async {
  // finallist[index] has all the details of the articles fetched
  var dio = Dio(); // finalist[index].attribute ==> gets the value
  try {
    Response response = await dio.get(
      "https://us-central1-fyi-vitc.cloudfunctions.net//api/article/getNextArticles/$index",
    );
    var list = response.data;
    finallist = list.map<Article>((json) => Article.fromJson(json)).toList();
  } catch (e) {
    print(e);
    print("ERROR");
  }
}

class Article {
  String title;
  String coverImage;
  String id;
  int date;

  Article({
    this.title,
    this.coverImage,
    this.id,
    this.date,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
        title: json["title"],
        coverImage: json["coverImage"],
        id: json["id"],
        date: json["date"]);
  }
}


CircleAvatar articleImage(var url) {
  if (url == "null") {
    return new CircleAvatar(
      radius: 50,
      backgroundImage: new AssetImage("images/noimage.jpeg"),
    );
  } else {
    try {
      return new CircleAvatar(
        radius: 50,
        backgroundImage: new NetworkImage(url),
      );
    } catch (Exception) {
      return new CircleAvatar(
        radius: 50,
        backgroundImage: new AssetImage("images/noimage.jpeg"),
      );
    }
  }
}

class ArticleRow extends StatefulWidget {
  @override
  _ArticleRowState createState() => _ArticleRowState();
}

class _ArticleRowState extends State<ArticleRow> {
  void startParse() async {
    await gethttp(supercount);
    setState(() {
      for (int i = 0; i < finallist.length; i++) {
        list.add(ArticleCard(
            finallist[i].title.toString(),
            finallist[i].coverImage.toString(),
            finallist[i].id.toString(),
            finallist[i].date));
      }
    });
  }

  @override
  void initState() {
    // TODO: implement initState
    print(listcont.length);
    _controller = ScrollController();
    super.initState();
    startParse();
  }

  @override
  void dispose() {
    print("dispose was called");
    _controller.dispose();
    super.dispose();
  }

  // @override
  // Widget build(BuildContext context) {
  //   return WillPopScope(
  //     onWillPop: _onBackPressed,
  //     child: new Scaffold(
  //       appBar: new AppBar(
  //         title: new Text(
  //           "On Back pressed",
  //           style: new TextStyle(color: Colors.white),
  //         ),
  //       ),
  //       body: new Center(
  //         child: new Text("Home Page"),
  //       ),
  //     ),
  //   );
  // }
  Future<bool> _exitfunction() {
    listcont.clear();
    print("lenght:");
    print("${listcont.length}");
    // Navigator.pop(context);
    Navigator.of(context).pop(false);
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: _exitfunction,
      child: Scaffold(
        backgroundColor: Color(0xfff1f1f1),
        resizeToAvoidBottomPadding: false,
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 20, top: 20, bottom: 10),
                  child: Text(
                    "Articles",
                    style: TextStyle(
                      fontSize: 55,
                      fontWeight: FontWeight.w900,
                    ),
                  ),
                ),
              ],
            ),
            SingleChildScrollView(
              child: Container(
                height: MediaQuery.of(context).size.height - 143,
                child: ListView.builder(
                  controller: _controller,
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    if (index >= list.length - 4) {
                      supercount = supercount + 1;
                      gethttp(supercount);
                      // setState(() {
                      startParse();
                      // });
                    }
                    Widget widget = list.elementAt(index);
                    return widget;
                  },
                  itemCount: list.length,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class ArticleCard extends StatelessWidget {
  String Title;
  String coverImage;
  String id;
  int date;
  ArticleCard(this.Title, this.coverImage, this.id, this.date);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(40, 0, 10, 10),
      child: FlatButton(
        onPressed: () {
          _onTapItem(context, id);
        },
        child: Container(
          decoration: BoxDecoration(
            border: Border.all(color: Colors.blueAccent),
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(50),
                topLeft: Radius.circular(50),
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
          height: 100,
          width: double.infinity,
          child: Row(
            children: [
              articleImage(coverImage),
              Padding(
                padding: const EdgeInsets.only(left: 20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "$Title",
                      style: TextStyle(
                        fontSize: 25,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    Text(
                      "Article content info",
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Text(
                      "Posted on ${readTimestamp(date)}", // ${DateTime.fromMillisecondsSinceEpoch(date)}
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
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

void _onTapItem(BuildContext context, String id) async {
  listcont.clear();
  text.clear();
  type.clear();
  print("cleared");
  await getMoreDetail(id);
  // await Navigator.of(context).push(MaterialPageRoute(
  //     builder: (BuildContext context) =>
  //         ArticleDetails(id, titledetail, coverImagedetail, datedetail,articledetail)));
  await Navigator.push(
    context,
    MaterialPageRoute(
        builder: (context) => ArticleDetails(
            id, titledetail, coverImagedetail, datedetail, articledetail)),
  );
}

Future<void> getMoreDetail(String id) async {
  var dio = Dio();
  try {
    response = await dio.get(
      "https://us-central1-fyi-vitc.cloudfunctions.net//api/article/fetchArticle/$id",
    );
    datadetail = await json.decode(response.toString());
    titledetail = datadetail['title'];
    datedetail = datadetail['date'];
    coverImagedetail = datadetail['coverImage'];
    articledetail = datadetail['article'];
    print("$titledetail,$datedetail,$coverImagedetail");
  } catch (e) {
    print(e);
    print("ERROR");
  }
}
