import 'dart:convert';
import 'package:fyi_main2_2_1/imageslides.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'texty.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
import 'package:keyboard_visibility/keyboard_visibility.dart';

const String submitUrl =
    'https://us-central1-fyi-vitc.cloudfunctions.net//api/article/createArticle';
int count;
var coverImgUrl;
// String jsonTags;
List<dynamic> arrays = [];
double coverHeight = 350;

class Tag {
  String type;
  String content;

  Tag(this.type, this.content);

  Map toJson() => {
        'type': type,
        'content': content,
      };
}

showAlertDialog(BuildContext context) {
  // set up the buttons
  Widget cancelButton = FlatButton(
    child: Text("Cancel"),
    onPressed: () {},
  );
  Widget continueButton = FlatButton(
    child: Text("Continue"),
    onPressed: () {},
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("RESET"),
    content: Text("Do You really want to reset?"),
    actions: [
      cancelButton,
      continueButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  Future<File> imageFile;
  TextEditingController myTitle;
  List<String> Htmldata;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  _MyHomePage(BuildContext context) async {
    // temp contains the array of objects STARTS FROM 0       count is length        typeArray is type of data
    final List data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
    count = data[1]; //count
    List temp = data[0]; //
    List typeArray = data[2];
    List<Tag> tags = [];

    for (int i = 1; i <= count; i++) {
      if (typeArray[i - 1] == 'image') {
        print('print');
        print(temp[i].toString().substring(11));
        temp[i] = temp[i].toString().substring(11);
        temp[i] = temp[i].replaceAll("amp;", "");

        print(temp[i]);
      }
    }
    print("COUNT home page=$count");
    // List<String> arrayData = [];
    for (int j = 1; j <= count; j++) {
      print("SUCCESS my home page");
      // arrayData.add(temp[j]);
      tags.add(Tag(typeArray[j - 1], temp[j]));
      // print("REGULAR CHECK ==${arrayData.toString()}");

      Tag tempTag = Tag(typeArray[j - 1], temp[j]);
      Map jsonInsert = tempTag.toJson();

      arrays.add(jsonInsert);
    }
    print("arrays");
    print(arrays);
  }

  Future<void> gethttp() async {
    var dio = Dio();
    var img = await imageFile;
    print({img.path});
    print(img);
    String fileName = img.path.split('/').last;
    print(fileName);
    try {
      formData = FormData.fromMap({
        "image": await MultipartFile.fromFile(img.path, filename: fileName),
      });
      Response response = await dio.post(
          "https://us-central1-fyi-vitc.cloudfunctions.net//api/article/imageUpload",
          queryParameters: {"x-auth-token": token}, //?x-auth-token=$token
          data: formData); //{"image": formData}
      print("GETHHTTP fucntion print -> $response");
      coverImgUrl = response;
    } catch (e) {
      print(e);
      print("ERROR");
    }
  }

  Future<http.Response> postRequest() async {
    // List xyz=[];
    // xyz.add(jsonTags);
    var url = submitUrl;
    Map data = {
      "title": myTitle.text,
      "coverImage": coverImgUrl.toString(),
      "article": arrays
    };
    // encode Map to JSON
    //TODO:here
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"x-auth-token": token, 'Content-Type': 'application/json'},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    return response;
  }

  @override
  void initState() {
    KeyboardVisibilityNotification().addNewListener(
      onChange: (bool visible) {
        print('keyboard $visible');
        setState(() {
          coverHeight = visible ? 170 : 350;
        });
      },
    );
    super.initState();
    myTitle = new TextEditingController(text: null);
    // myContent = new TextEditingController(text: null);
  }

  Widget showImage() {
    return FutureBuilder<File>(
      future: imageFile,
      builder: (BuildContext context, AsyncSnapshot<File> snapshot) {
        if (snapshot.connectionState == ConnectionState.done &&
            snapshot.data != null) {
          return Image.file(
            snapshot.data,
            width: 200,
            height: 200,
          );
        } else if (snapshot.error != null) {
          return const Text(
            'Error Picking Image',
            textAlign: TextAlign.center,
          );
        } else {
          return const Text(
            'No Image Selected',
            textAlign: TextAlign.center,
          );
        }
      },
    );
  }

  void _showAlert() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Create Article'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  'Oops :/',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.shade700),
                ),
                new SizedBox(
                  height: 10,
                ),
                new Text(
                  'Looks like you forgot to give your article a Title and Content',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.shade700),
                ),
                new SizedBox(
                  height: 20,
                ),
                new Text('Enter Title and content of your article to Submit.'),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Got It'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showConfirm() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Create Article'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  'Yaay!',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.blue.shade700),
                ),
                new SizedBox(
                  height: 10,
                ),
                new Text('Your article has been successfully submitted'),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Okay'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  void dispose() {
    // Clean up the controller when the widget is disposed.
    // myContent.dispose();
    myTitle.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      resizeToAvoidBottomPadding: false,
      body: Column(
        children: <Widget>[
          Center(
            child: Stack(
              children: [
                AnimatedContainer(
                  curve: Curves.easeInOutQuad,
                  duration: Duration(
                    milliseconds: 400,
                  ),
                  // height: 170,
                  height: coverHeight,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/CAcover.jpg'),
                        fit: BoxFit.cover),
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20),
                        bottomRight: Radius.circular(20)),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.2),
                        spreadRadius: 12,
                        blurRadius: 8,
                        offset: Offset(0, 5), // changes position of shadow
                      ),
                    ],
                  ),
                ),
                AnimatedContainer(
                    duration: Duration(milliseconds: 480),
                    curve: Curves.easeInOutQuad,
                    padding: EdgeInsets.only(top: coverHeight - 70),
                    alignment: Alignment.bottomCenter,
                    child: Text(
                      "Create Article",
                      style: TextStyle(
                          fontSize: 60,
                          color: Color.fromRGBO(255, 255, 255, 0.7),
                          fontWeight: FontWeight.bold),
                    ))
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 14, right: 14),
            child: Container(
              decoration: BoxDecoration(
                // borderRadius: BorderRadius.only(
                //     bottomLeft: Radius.circular(30),
                //     bottomRight: Radius.circular(30)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.1),
                    spreadRadius: 5,
                    blurRadius: 7,
                    offset: Offset(0, 3), // changes position of shadow
                  ),
                ],
              ),
              child: SizedBox(
                width: double.infinity,
                height: 50,
                child: FlatButton(
                  shape: RoundedRectangleBorder(
                      // borderRadius: BorderRadius.circular(12.0),
                      borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(25),
                    bottomRight: Radius.circular(25),
                  )),
                  color: Color(0xff114084),
                  child: Text("Submit",
                      style: TextStyle(
                          fontSize: 30,
                          color: Color.fromRGBO(255, 255, 255, 0.9),
                          fontWeight: FontWeight.w300)),
                  onPressed: () async {
                    if (myTitle.text != "" && arrays.length != 0) {
                      print("SUCCESS============");
                      await postRequest();
                      setState(() {
                        myTitle.clear();
                        imageFile = null;
                      });
                      _showConfirm();
                    } else {
                      _showAlert();
                    }
                  },
                ),
              ),
            ),
          ),
          // Padding(
          //     padding: const EdgeInsets.all(12.0),
          //     child: Text(
          //       'Create an Article',
          //       style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
          //     )),
          Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.only(
                    bottomLeft: Radius.circular(20),
                    bottomRight: Radius.circular(20)),
                // boxShadow: [
                //   BoxShadow(
                //     color: Colors.grey.withOpacity(0.7),
                //     spreadRadius: 12,
                //     blurRadius: 8,
                //     offset: Offset(0, 5), // changes position of shadow
                //   ),
                // ],
              ),
              margin: EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 5),
              child: TextField(
                controller: myTitle,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  fillColor: Color(0xff808080),
                  filled: true,
                ),
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                showImage(),
                FlatButton(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.0),
                  ),
                  color: Color(0xff3466aa),
                  child: Text(
                    "Select Image from Gallery",
                    style: TextStyle(
                        fontWeight: FontWeight.w300, color: Colors.white),
                  ),
                  onPressed: () {
                    pickImageFromGallery(ImageSource.gallery);
                    gethttp();
                  },
                ),
              ],
            ),
          ),
          Column(
            children: <Widget>[
              Container(
                margin: EdgeInsets.all(12),
                height: 70.0,
                width: double.infinity,
                decoration: BoxDecoration(
                  color: Color(0xff3466aa),
                ),
                child: RaisedButton(
                    color: Color(0xff3466aa),
                    child: Text("Write Content",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.w300,
                            fontSize: 30)),
                    onPressed: () {
                      _MyHomePage(context);
                    }),
              ),
              Opacity(
                opacity: 0.8,
                child: Container(
                  height: 200,
                  width: 300,
                  // color: Colors.blue,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage('images/fyi.png'),
                        fit: BoxFit.contain),
                    // borderRadius: BorderRadius.only(
                    //     bottomLeft: Radius.circular(20),
                    //     bottomRight: Radius.circular(20)),
                    // boxShadow: [
                    //   BoxShadow(
                    //     color: Colors.grey.withOpacity(0.2),
                    //     spreadRadius: 12,
                    //     blurRadius: 8,
                    //     offset: Offset(0, 5), // changes position of shadow
                    //   ),
                    // ],
                  ),
                ),
              )
              // Container(
              //   margin: EdgeInsets.all(12),
              //   height: 40.0,
              //   width: double.infinity,
              //   decoration: BoxDecoration(
              //     color: Colors.yellow.shade700,
              //   ),
              //   child: RaisedButton(
              //       color: Colors.yellow.shade700,
              //       child: Text("Image Carousel [testing][working]",
              //           style: TextStyle(
              //               color: Colors.white,
              //               fontWeight: FontWeight.w300,
              //               fontSize: 30)),
              //       onPressed: () {
              //         setState(() {
              //           Navigator.push(
              //             context,
              //             MaterialPageRoute(builder: (context) => ImgSlide()),
              //           );
              //         });
              //       }),
              // ),
            ],
          ),
        ],
      ),
    );
  }
}
