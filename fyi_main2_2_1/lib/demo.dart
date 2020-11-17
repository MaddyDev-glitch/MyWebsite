import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/articlepage.dart';
import 'package:fyi_main2_2_1/showarticle.dart';
import 'profilepage.dart';
class Testing extends StatefulWidget {
  String username;
  Testing(this.username);
  @override
  _TestingState createState() => _TestingState();
}

class _TestingState extends State<Testing> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
          backgroundColor: Color(0xfff1f1f1),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            "DEMO NAVIGATOR",
            style: TextStyle(fontSize: 60,fontWeight: FontWeight.w300),
          ),
          Text(
            "Hey ${widget.username}",
            style: TextStyle(fontSize: 30,fontWeight: FontWeight.w300),
          ),
          SizedBox(
            height: 100,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => MyCustomForm()),
                );
              });
            },
            child: Text(
              "Create Article",
              style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ArticleRow()),
                );
              });
            },
            child: Text(
              "View Article",
              style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300),
            ),
          ),
          SizedBox(
            height: 50,
          ),
          FlatButton(
            color: Colors.blue,
            onPressed: () {
              setState(() {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (context) => ProfileScreen(widget.username)),
                );
              });
            },
            child: Text(
              "View Profile",
              style: TextStyle(fontSize: 50,fontWeight: FontWeight.w300),
            ),
          ),
        ],
      ),
    ));
  }
}
