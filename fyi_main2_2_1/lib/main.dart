import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/already_loggedin_loader.dart';
import 'package:fyi_main2_2_1/login_page.dart';
import 'package:fyi_main2_2_1/profilepage.dart';
import 'StateDriver.dart';
import 'articlepage.dart';
import 'imageslides.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:shared_preferences/shared_preferences.dart';
bool already_sign_in=false;

CheckloggedIn() async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  int intValue = prefs.getInt('intValue');
  if(intValue==1 || intValue==2)
    {
      already_sign_in=true;
    }
  else
    {
      already_sign_in=false;
    }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await CheckloggedIn();
  print("NEW");
  print(already_sign_in);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FYI Mobile App',
      home: (already_sign_in)?AlreadyLoggedLoaderScreen():LoginPage(),
      routes: <String, WidgetBuilder>{
        '/a': (BuildContext context) => MyCustomForm(),
        '/b': (BuildContext context) => ImgSlide(),
        // '/d': (BuildContext context) => MyHomePage(),
      }, //CHANGE TESTER  1. MyCustomForm() 2.ImgSlide() 3. ArticleRow()  4.Testing() 5.LoginPage()
    );
  }
}
