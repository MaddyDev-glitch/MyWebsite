import 'dart:core';
import 'dart:io';
import 'package:flutter/material.dart';
import 'html_editor.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';
import 'package:html_editor/pick_image.dart';

import 'package:flutter/foundation.dart';

List<GlobalKey<HtmlEditorState>> keyEditor1 =
List<GlobalKey<HtmlEditorState>>(200);
int i = 1;
int _count = 2;
int _countimg = 1;
String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiMDlZWUpmRlQyblo5QU9jM3BvZDlHbnEwdWwwMiJ9LCJpYXQiOjE2MDE3MTQ0NzJ9.dLU-k1kJkEWNtJT9NhkciM-SJAZ-Fdrl1WZNrA24mR8";
File _image;
var _imageList = List<File>(200);
String testfd;
String url =
    "https://us-central1-fyi-vitc.cloudfunctions.net//api/article/imageUpload";
FormData formData;



class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();

}
void getHttp() async {
  var dio = Dio();
  print({_image.path});
  print(_image);
  String fileName = _image.path.split('/').last;
  print(fileName);
  try {
    formData = FormData.fromMap({
      "image": await MultipartFile.fromFile(_image.path, filename: fileName),
    });
    Response response = await dio.post(
        "https://us-central1-fyi-vitc.cloudfunctions.net//api/article/imageUpload",
        queryParameters: {"x-auth-token": token}, //?x-auth-token=$token
        data: formData); //{"image": formData}
    print(response);
    String a = response.toString();
    print("LENGTH=");
    print(a.length);
  } catch (e) {
    print(e);
    print("ERROR");
    print(formData.toString());
  }
}

getImageGallery() async {
  var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
  _image = imageFile;
}


class _MyHomePageState extends State<MyHomePage> {

  // GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  // GlobalKey<HtmlEditorState> keyEditor2 = GlobalKey();
  // List<GlobalKey<HtmlEditorState>> keyEditor0 =
  // new List.generate(_count, (int i) => new GlobalKey());

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
                                list.add( new Container(
                                  child: Container(
                                    child: HtmlEditor(
                                      showBottomToolbar:false,
                                      hint: "Your text here...<br> Paragraph ${list.length+1}",
                                      key: keyEditor1[list.length+1],
                                      height: 300,
                                    ),
                                  ),
                                ),);
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
                                list.add( new Container(
                                  child: Container(
                                    child: HtmlEditor(
                                      hint: "ADD IMAGE HERE... ""<br><b>CLICK 'Image from device'</b> in bottom panel to add image from gallery or camera <br> <b>CLICK image icon</b> from top bar for embedding URLs  ",
                                      key: keyEditor1[list.length+1],
                                      height: 300,
                                    ),
                                  ),
                                ),);
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
                          setState(() {
                          });
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
                            // final txt =
                            //     await keyEditor1[1].currentState.getText();
                            for (int j = 1; j <= list.length; j++) {
                              print("COUNT: ${list.length}");
                              var printo =
                                  await keyEditor1[j].currentState.getText();
                              print("PRINTTEXT$j :$printo");
                            }
                            // var printo =
                            // await keyEditor1[1].currentState.getText();
                            setState((){
                              // result = txt;
                              // print("LENGTH=${result.length}");
                              // print("result=$result");
                              // Navigator.pop(context, result);
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

class imgshow extends StatelessWidget {
  const imgshow({
    Key key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      width: 70,
      child: _imageList[_countimg] == null
          ? Text('No Images Selected')
          : Image.file(_image),
    );
  }
}

class input_tile extends StatelessWidget {
  const input_tile({
    Key key,
    // @required this.keyEditor,
    @required this.index
  }) : super(key: key);

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
