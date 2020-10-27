import 'dart:convert';
import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/articlepage.dart';
import 'html_editor.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:html_editor/pick_image.dart';

import 'package:flutter/foundation.dart';

List majorSend = [];
List type = [];
List<GlobalKey<HtmlEditorState>> keyEditor1 =
    List<GlobalKey<HtmlEditorState>>(200);
int i = 1;
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiMDlZWUpmRlQyblo5QU9jM3BvZDlHbnEwdWwwMiJ9LCJpYXQiOjE2MDE3MTQ0NzJ9.dLU-k1kJkEWNtJT9NhkciM-SJAZ-Fdrl1WZNrA24mR8";
FormData formData;
List<String> arrayData = List<String>(200);

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

// void getHttp() async {
//   Future<http.Response> postRequest() async {
//     var url =
//         'https://us-central1-fyi-vitc.cloudfunctions.net//api/article/createArticle';
//     var body = jsonEncode({
//       "title": "hello",
//       "coverImage":
//           "https://images.ctfassets.net/hrltx12pl8hq/5596z2BCR9KmT1KeRBrOQa/4070fd4e2f1a13f71c2c46afeb18e41c/shutterstock_451077043-hero1.jpg?fit=fill&w=800&h=400",
//       "article": [
//         {"type": "text", "content": "heyyyyy"},
//         {"type": "text", "content": "heyyyyy"}
//       ]
//     });
//
//     print("Body: " + body);
//
//     http
//         .post(url, headers: {"x-auth-token": token}, body: body)
//         .then((http.Response response) {
//       print("Response status: ${response.statusCode}");
//       print("Response body: ${response.contentLength}");
//       print(response.headers);
//       print(response.request);
//     });
//   }
// }

getImageGallery() async {
  var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
}

class _MyHomePageState extends State<MyHomePage> {
  List<Widget> list = new List();

  String result = "";

  @override
  void initState() {
    super.initState();
    for (int z = 1; z <= 100; z++) {
      keyEditor1[z] = GlobalKey();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Content"),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(0.0),
        child: Stack(
          children: <Widget>[
            SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  SizedBox(
                    height: 600,
                    child: Container(
                        child: ListView.builder(
                      itemBuilder: (context, index) {
                        Widget widget = list.elementAt(index);
                        return widget;
                      },
                      itemCount: list.length,
                    )),
                  ),

                  // new Container(
                  //   child: Container(
                  //     child: HtmlEditor(
                  //       hint: "Your text here...",
                  //       key: keyEditor1[1],
                  //       height: 300,
                  //     ),
                  //   ),
                  // ),

//                  input_tile(keyEditor: keyEditor1[1]),
                  // input_tile(keyEditor: keyEditor1[2]),

                  // SizedBox(
                  //   height: 600,
                  //   child: Container(
                  //     child: new ListView(
                  //       children: tiles,
                  //       // scrollDirection: Axis.horizontal,
                  //     ),
                  //   ),
                  // ),

                  // new ListView.builder(itemBuilder: (context, index) {
                  //   Widget widget = list.elementAt(index);
                  //   return widget;
                  // }, itemCount: list.length,),
                  // SizedBox(
                  //   height: 100,
                  //   child: Container(
                  //     child: new ListView(
                  //       children: imgbox,
                  //       // scrollDirection: Axis.horizontal,
                  //     ),
                  //   ),
                  // ),
                  // imgshow(),
                  Column(
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FlatButton(
                            color: Colors.blueGrey,
                            onPressed: () {
                              setState(() {
                                // list.add( input_tile(index: list.length,));
                                type.add("text");
                                list.add(
                                  new Container(
                                    child: Container(
                                      child: HtmlEditor(
                                        showBottomToolbar: false,
                                        hint:
                                            "Your text here...<br> Paragraph ${list.length + 1}",
                                        key: keyEditor1[list.length + 1],
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                );
                                print("number==== ${list.length}");
                                print("${keyEditor1[1]}");
                              });
                            },
                            child: Text("ADD TEXT",
                                style: TextStyle(color: Colors.white)),
                          ),
                          SizedBox(
                            width: 30,
                          ),
                          FlatButton(
                            color: Colors.blueGrey,
                            onPressed: () {
                              setState(() {
                                // list.add( input_tile(index: list.length,));
                                type.add("image");
                                list.add(
                                  new Container(
                                    child: Container(
                                      child: HtmlEditor(
                                        hint: "ADD IMAGE HERE... "
                                            "<br><b>CLICK 'Image from device'</b> in bottom panel to add image from gallery or camera <br> <b>CLICK image icon</b> from top bar for embedding URLs  ",
                                        key: keyEditor1[list.length + 1],
                                        height: 300,
                                      ),
                                    ),
                                  ),
                                );
                                print("number number==== ${list.length}");
                                print("${keyEditor1[1]}");
                              });
                            },
                            child: Text("ADD IMAGE",
                                style: TextStyle(color: Colors.white)),
                          ),
                        ],
                      ),
                      FlatButton(
                        color: Colors.blueGrey,
                        onPressed: () {
                          list.removeLast();
                          type.removeLast();
                          setState(() {});
                        },
                        child: Text("REMOVE Recent TEXT/IMAGE",
                            style: TextStyle(color: Colors.white)),
                      ),
                      // RaisedButton(
                      //   child: Icon(Icons.image),
                      //   onPressed: () => getImageGallery(),
                      // ),
                    ],
                  ),
                  // HtmlEditor(
                  //   hint: "Your text here...",
                  //   //value: "text content initial, if any",
                  //   // value: "hey",
                  //   key: keyEditor1,
                  //   height: 300,
                  // ),
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          height: 40,
                          color: Colors.redAccent,
                          onPressed: () {
                            setState(() {
                              for (int i = 1; i <= list.length; i++) {
                                keyEditor1[list.length].currentState.setEmpty();
                              }
                            });
                          },
                          child: Text("Reset",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w300,
                                  fontSize: 25)),
                        ),
                        SizedBox(
                          width: 16,
                        ),
                        FlatButton(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(12.0),
                          ),
                          height: 40,
                          color: Colors.lightGreenAccent.shade700,
                          onPressed: () async {
                            for (int j = 1; j <= list.length; j++) {
                              var currentStateText =
                                  await keyEditor1[j].currentState.getText();
                              var printo = currentStateText;
                              arrayData[j] = currentStateText;
                              majorSend = [arrayData, list.length, type];
                            }
                            setState(() {
                              Navigator.pop(context, majorSend);
                            });
                          },
                          child: Text(
                            "Submit",
                            style: TextStyle(
                                color: Colors.white,
                                fontWeight: FontWeight.w300,
                                fontSize: 25),
                          ),
                        ),
                      ],
                    ),
                  ),
                  // FlatButton(
                  //   child: Text("click me"),
                  //   onPressed: () {
                  //     setState(() {
                  //       // getHttp();
                  //     });
                  //   },
                  // ),

                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(result),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
    // This trailing comma makes auto-formatting nicer for build methods.
    // );
  }
}

class input_tile extends StatelessWidget {
  const input_tile(
      {Key key,
      // @required this.keyEditor,
      @required this.index})
      : super(key: key);

  // final GlobalKey<HtmlEditorState> keyEditor;
  // List<GlobalKey<HtmlEditorState>> keyEditor=
  // List<GlobalKey<HtmlEditorState>>(200);
  final int index;

  @override
  Widget build(BuildContext context) {
    print("KEYEDITOR1[INDEX]====");
    return new Container(
      child: Container(
        child: HtmlEditor(
          hint: "Your text here...",
          // key:keyEditor1[]
          height: 300,
        ),
      ),
    );
  }
}

// class input_tile extends StatelessWidget {
//   const input_tile({
//     Key key,
//     @required this.keyEditor,
//   }) : super(key: key);
//
//   final GlobalKey<HtmlEditorState> keyEditor;
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       children: [
//         Container(
//           child: HtmlEditor(
//             hint: "Your text here...",
//             //value: "text content initial, if any",
//             // value: "hey",
//             key: keyEditor,
//             height: 300,
//           ),
//         ),
//         SizedBox(
//           height: 30,
//           width: double.infinity,
//           child: Container(
//             color: Colors.black87,
//             child: Center(
//                 child: Text(
//                   "^^^         Scroll bar         ^^^",
//                   style: TextStyle(
//                       color: Colors.white,
//                       fontSize: 20,
//                       fontWeight: FontWeight.w100),
//                 )),
//           ),
//         ),
//       ],
//     );
//   }
// }
