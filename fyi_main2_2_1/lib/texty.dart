import 'dart:convert';
import 'dart:io';
import 'package:dio_flutter_transformer/dio_flutter_transformer.dart';
import 'package:flutter/material.dart';
import 'package:html_editor/html_editor.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiMDlZWUpmRlQyblo5QU9jM3BvZDlHbnEwdWwwMiJ9LCJpYXQiOjE2MDE3MTQ0NzJ9.dLU-k1kJkEWNtJT9NhkciM-SJAZ-Fdrl1WZNrA24mR8";
File _image;
String testfd;
String url =
    "https://us-central1-fyi-vitc.cloudfunctions.net//api/article/imageUpload";
FormData formData;

class MyHomePage extends StatefulWidget {
  // MyHomePage({Key key, this.title}) : super(key: key);
  // final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

void getHttp() async {
  var dio = Dio();
  // dio.transformer = FlutterTransformer(); // replace dio default transformer
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
  GlobalKey<HtmlEditorState> keyEditor = GlobalKey();
  String result = "";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Create Content"),
        elevation: 0,
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              HtmlEditor(
                hint: "Your text here...",
                //value: "text content initial, if any",
                // value: "hey",
                key: keyEditor,
                height: 400,
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: <Widget>[
                    FlatButton(
                      color: Colors.blueGrey,
                      onPressed: () {
                        setState(() {
                          keyEditor.currentState.setEmpty();
                        });
                      },
                      child:
                          Text("Reset", style: TextStyle(color: Colors.white)),
                    ),
                    SizedBox(
                      width: 16,
                    ),
                    // Container(
                    //   height: 130,
                    //   width: 130,
                    //   child: _image == null
                    //       ? Text('No Images Selected')
                    //       : Image.file(_image),
                    // ),
                    FlatButton(
                      color: Colors.lightBlueAccent,
                      onPressed: () async {
                        final txt = await keyEditor.currentState.getText();
                        setState(() {
                          result = txt;
                          print("LENGTH=${result.length}");

                          print("result=$result");
                          Navigator.pop(context, result);
                        });
                      },
                      child: Text(
                        "Submit",
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ),
              // FlatButton(
              //   child: Text("click me"),
              //   onPressed: () {
              //     setState(() {
              //       getHttp();
              //     });
              //   },
              // ),
              // RaisedButton(
              //   child: Icon(Icons.image),
              //   onPressed: () => getImageGallery(),
              // ),
              // Padding(
              //   padding: const EdgeInsets.all(8.0),
              //   child: Text(result),
              // )
            ],
          ),
        ),
      ),
      // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
