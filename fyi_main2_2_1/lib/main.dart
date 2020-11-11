import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/demo.dart';
import 'package:fyi_main2_2_1/showarticle.dart';
import 'articlepage.dart';
import 'imageslides.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FYI Mobile App',
      home: Testing(),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => MyCustomForm(),
        '/b': (BuildContext context) => ImgSlide(),
        // '/d': (BuildContext context) => MyHomePage(),
      }, //CHANGE TESTER  1. MyCustomForm() 2.ImgSlide() 3. ArticleRow()
    );
  }
}
