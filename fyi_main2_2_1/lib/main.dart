import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/texty.dart';
// import 'package:fyi_main/zefyr.dart';
// import 'package:fyi_forms/articlepage.dart';
// import 'package:fyi_forms/imageslides.dart';
import 'articlepage.dart';
import 'imageslides.dart';
import 'demo.dart';
import 'package:rich_edit/rich_edit.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FYI Mobile App',
      home: MyCustomForm(),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => MyCustomForm(),
        '/b': (BuildContext context) => ImgSlide(),
        '/d': (BuildContext context) => MyHomePage(),
      }, //CHANGE TESTER  1. MyCustomForm() 2.ImgSlide()
    );
  }
}
