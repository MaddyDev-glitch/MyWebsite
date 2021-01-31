import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;
// import 'package:keyboard_visibility/keyboard_visibility.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'dart:core';
import 'html_editor.dart';
import 'package:flutter/foundation.dart';
import 'login_page.dart' as login;

const String submitUrl =
    'https://us-central1-fyi-vitc.cloudfunctions.net//api/article/createArticle';
int count;
var coverImgUrl;
// String jsonTags;
List<dynamic> arrays = [];
double coverHeight = 350;
double editorHeight = 0;
int delete_count = 0;
List majorSend = [];
List type = [];
List<GlobalKey<HtmlEditorState>> keyEditor1 =
    List<GlobalKey<HtmlEditorState>>(200);
// List<String> closeChecker = List<String>(200);
int i = 1;
String token =login.token;
FormData formData;
List<String> arrayData = List<String>(200);
String cls = "X";
var status;

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

// getImageGallery() async {
//   var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
// }
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  Future<File> imageFile;
  TextEditingController myTitle;
  List<String> Htmldata;
  List<Widget> list = new List();

  String result = "";

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
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
    status = response.statusCode;
    print("${response.body}");
    return response;
  }

  // @override
  // void initState() {
  //   KeyboardVisibilityNotification().addNewListener(
  //     onChange: (bool visible) {
  //       print('keyboard $visible');
  //       setState(() {
  //         coverHeight = visible ? 170 : 350;
  //       });
  //     },
  //   );
  //   super.initState();
  //   for (int z = 1; z <= 100; z++) {
  //     keyEditor1[z] = GlobalKey();
  //   }
  //   myTitle = new TextEditingController(text: null);
  //   // myContent = new TextEditingController(text: null);
  // }

  @override
  void initState() {
    // KeyboardVisibilityNotification().addNewListener(
    //   onChange: (bool visible) {
    //     print('keyboard $visible');
    //     setState(() {
    //       coverHeight = visible ? 170 : 350;
    //     });
    //   },
    // );
    KeyboardVisibility.onChange.listen((bool visible) {
      setState(() {
        coverHeight = visible ? 170 : 350;
      });
    });
    super.initState();
    for (int z = 1; z <= 100; z++) {
      keyEditor1[z] = GlobalKey();
    }
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
  void _showError() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Create Article'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  'Ah Snap :/',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.shade700),
                ),
                new SizedBox(
                  height: 10,
                ),
                new Text(
                  'Looks like something went wrong',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.shade700),
                ),
                new SizedBox(
                  height: 20,
                ),
                new Text('Try resubmitting your article'),
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

  void _nullremoveError() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Remove Text/Image'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  'Well... I can\'t do that,',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.yellow.shade800),
                ),
                new SizedBox(
                  height: 10,
                ),
                new Text(
                  '"You got to create something to destroy..."',
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w700,
                      color: Colors.yellow.shade800),
                ),
                new SizedBox(
                  height: 10,
                ),
                new Text(
                  'Add Text or Image to remove it',
                  style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      color: Colors.black),
                ),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Alright!'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _removeConfirm() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('Remove Text/Image'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text(
                  'Ummm....',
                  style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.shade700),
                ),
                new SizedBox(
                  height: 10,
                ),
                new Text(
                  'You sure about deleting? Its irreversible!',
                  style: TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.w700,
                      color: Colors.red.shade700),
                ),
                Container(
                    width: 280,
                    padding: EdgeInsets.all(10.0),
                    child: TextField(
                      maxLength: (list.length < 10) ? 1 : 2,
                      controller: number,
                      autocorrect: true,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                          hintText: 'Box number you wish to remove'),
                    )),
                // new Text('Your article has been successfully submitted'),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Nah, I\'d like to keep it'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            new FlatButton(
              child: new Text(
                'Delete it!',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.w700,
                    color: Colors.red.shade700),
              ),
              onPressed: () {
                // list.removeLast();
                // type.removeLast();
                String num = number.text;
                int numMinusone = int.parse(num) - 1;
                print(num);
                setState(() {
                  list.removeAt(numMinusone);
                  type.removeAt(numMinusone);
                  if (list.length == 0) {
                    editorHeight = 0;
                  }
                  Navigator.of(context).pop();
                });
              },
            ),
          ],
        );
      },
    );
  }

  final number = TextEditingController();

  @override
  Widget build(BuildContext context) {
    showAlertDialog(BuildContext context) {
      // set up the buttons
      Widget cancelButton = FlatButton(
        child: Text(
          "Cancel",
          style: TextStyle(fontSize: 20),
        ),
        onPressed: () {
          Navigator.of(context).pop();
        },
      );
      Widget continueButton = FlatButton(
        child: Text(
          "Continue anyways",
          style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w700,
              color: Colors.red.shade700),
        ),
        onPressed: () {
          setState(() {
            for (int i = 1; i <= list.length; i++) {
              keyEditor1[list.length].currentState.setEmpty();
            }
            list.clear();
            // build(context);
            Navigator.of(context).pop();
          });
        },
      );
      // set up the AlertDialog
      AlertDialog alert = AlertDialog(
        title: Text("RESET"),
        content: Container(
          height: 161,
          width: 200,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              new Text(
                'Uh...',
                style: TextStyle(
                    fontSize: 40,
                    fontWeight: FontWeight.w700,
                    color: Colors.red.shade700),
              ),
              new SizedBox(
                height: 10,
              ),
              new Text(
                'You sure about Resetting?',
                style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.w700,
                    color: Colors.red.shade700),
              ),
              new SizedBox(
                height: 20,
              ),
              new Text('You will lose all the content in this page!'),
            ],
          ),
        ),
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

    return Scaffold(
      backgroundColor: Color(0xfff1f1f1),
      resizeToAvoidBottomPadding: false,
      body: SingleChildScrollView(
        child: Column(
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
                      List temp;
                      List typeArray;
                      list.length = list.length + delete_count;
                      print("${list.length}");
                      // print("${list.}");
                      for (int j = 1; j <= list.length; j++) {
                        var currentStateText;
                        try {
                          currentStateText =
                              await keyEditor1[j].currentState.getText();
                        } catch (xyz) {
                          if (typeArray[j - 1] == 'image') {
                            currentStateText =
                                "https://upload.wikimedia.org/wikipedia/commons/3/3d/1_120_transparent.png";
                          } else {
                            currentStateText = "<br>";
                            // continue;}
                          }
                        }

                        var printo = currentStateText;
                        print("printo==$printo");

                        arrayData[j] = currentStateText;
                        majorSend = [arrayData, list.length, type];

                        final List data = majorSend;
                        count = data[1]; //count
                        temp = data[0]; //
                        typeArray = data[2];
                      }
                      print("count=${count}");
                      print("temp=${temp}");
                      print("typearray=${typeArray}");

                      // List<Tag> tags = [];

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
                        // tags.add(Tag(typeArray[j - 1], temp[j]));
                        // print("REGULAR CHECK ==${arrayData.toString()}");
                        Tag tempTag = Tag(typeArray[j - 1], temp[j]);
                        Map jsonInsert = tempTag.toJson();
                        print(jsonInsert);
                        arrays.add(jsonInsert);
                      }
                      print("arrays");
                      print(arrays);

                      if (myTitle.text != "" &&editorHeight!=0) {
                        print("SUCCESS============");
                        await postRequest();
                        if (status>=200 && status<300) {
                          setState(() {
                            myTitle.clear();
                            imageFile = null;
                            list.clear();
                            editorHeight=0;
                          });
                          _showConfirm();
                        } else {
                          _showError();
                        }
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
                margin:
                    EdgeInsets.only(top: 12, left: 12, right: 12, bottom: 5),
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
                Scrollbar(
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        AnimatedContainer(
                          duration: Duration(milliseconds: 480),
                          curve: Curves.easeInOutQuad,
                          height: editorHeight,
                          child: Container(
                              decoration: BoxDecoration(
                                // color: Colors.blueGrey
                                color: Color(0x3382b7dc),
                              ),
                              child: ListView.builder(
                                cacheExtent: 2000000,
                                addAutomaticKeepAlives: true,
                                addRepaintBoundaries: false,
                                itemBuilder: (context, index) {
                                  Widget widget = list.elementAt(index);
                                  // return widget;
                                  // return Dismissible(
                                  //   key: Key(index.toString()),
                                  //   child: widget,
                                  // );
                                  return  Dismissible(
                                      key: ValueKey(list.length),

                                      onDismissed: (direction) {
                                        list.removeAt(index);
                                        delete_count = delete_count + 1;
                                        setState(() {
                                          if (list.length == 0) {
                                            editorHeight = 0;
                                          }
                                        });
                                      },
                                      // Show a red background as the item is swiped away.
                                      // background: Container(color: Colors.red),
                                    background: Container(
                                    color: Colors.red.shade800,
                                    padding: EdgeInsets.symmetric(horizontal: 20),
                                    alignment: AlignmentDirectional.centerStart,
                                    child: Icon(
                                    Icons.delete,
                                    size: 50,
                                    color: Colors.white,
                                    ),),
                                      child: ListTile(title: widget),
                                    );

                                },
                                itemCount: list.length,
                              )),
                        ),

                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                FlatButton(
                                    color: Colors.blueGrey,
                                    onPressed: () {
                                      setState(() {
                                        editorHeight = 500;
                                        // list.add( input_tile(index: list.length,));
                                        type.add("text");
                                        list.add(
                                          Column(
                                            children: [
                                              Container(
                                                child: HtmlEditor(
                                                  showBottomToolbar: false,
                                                  hint:
                                                      "Your text here...<br> Paragraph ${list.length + 1}",
                                                  key: keyEditor1[
                                                      list.length + 1],
                                                  height: 300,
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                        print("number==== ${list.length}");
                                        print("${keyEditor1[1]}");
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        widgetIcon(Icons.text_snippet, ""),
                                        Text("ADD TEXT",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                                FlatButton(
                                    color: Colors.blueGrey,
                                    onPressed: () {
                                      setState(() {
                                        editorHeight = 500;
                                        // list.add( input_tile(index: list.length,));
                                        type.add("image");
                                        list.add(
                                          new Container(
                                            child: Container(
                                              child: HtmlEditor(
                                                hint: "ADD IMAGE HERE... ",
                                                key:
                                                    keyEditor1[list.length + 1],
                                                height: 100,
                                              ),
                                            ),
                                          ),
                                        );
                                        print(
                                            "number number==== ${list.length}");
                                        print("${keyEditor1[1]}");
                                      });
                                    },
                                    child: Row(
                                      children: [
                                        widgetIcon(Icons.image, ""),
                                        Text("ADD IMAGE",
                                            style:
                                                TextStyle(color: Colors.white)),
                                      ],
                                    )),
                                SizedBox(
                                  width: 10,
                                ),
                              ],
                            ),

                            // RaisedButton(
                            //   child: Icon(Icons.image),
                            //   onPressed: () => getImageGallery(),
                            // ),
                          ],
                        ),
                        //
                        // FlatButton(
                        //     color: Colors.blueGrey,
                        //     onPressed: () {
                        //       if (list.length == 0) {
                        //         _nullremoveError();
                        //       } else {
                        //         _removeConfirm();
                        //       }
                        //       // list.removeLast();
                        //       // type.removeLast();
                        //       setState(() {
                        //         if (list.length == 0) {
                        //           editorHeight = 0;
                        //         }
                        //       });
                        //     },
                        //     child: Text("REMOVE Recent Text/Image",
                        //         style: TextStyle(color: Colors.white))),
                        Padding(
                          padding: const EdgeInsets.all(0.0),
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
                                  showAlertDialog(context);
                                  editorHeight = 0;
                                },
                                child: Text("Reset",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w300,
                                        fontSize: 25)),
                              ),
                              // SizedBox(
                              //   width: 16,
                              // ),
                              // FlatButton(
                              //   shape: RoundedRectangleBorder(
                              //     borderRadius: BorderRadius.circular(12.0),
                              //   ),
                              //   height: 40,
                              //   color: Colors.lightGreenAccent.shade700,
                              //   onPressed: () async {
                              //     for (int j = 1; j <= list.length; j++) {
                              //       var currentStateText =
                              //           await keyEditor1[j].currentState.getText();
                              //       var printo = currentStateText;
                              //       arrayData[j] = currentStateText;
                              //       majorSend = [arrayData, list.length, type];
                              //     }
                              //     setState(() {
                              //       Navigator.pop(context, majorSend);
                              //     });
                              //   },
                              //   child: Text(
                              //     "Submit",
                              //     style: TextStyle(
                              //         color: Colors.white,
                              //         fontWeight: FontWeight.w300,
                              //         fontSize: 25),
                              //   ),
                              // ),
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

                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Text(result),
                        // )
                      ],
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
      ),
    );
  }
}

class input_tile extends StatelessWidget {
  const input_tile({Key key, @required this.index}) : super(key: key);
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

Widget widgetIcon(IconData icon, String title, {OnClik onKlik}) {
  return InkWell(
    onTap: () {
      onKlik();
    },
    child: Row(
      children: <Widget>[
        Icon(
          icon,
          color: Colors.black54,
          size: 20,
        ),
        Padding(
          padding: const EdgeInsets.only(left: 4),
          child: Text(
            title,
            style: TextStyle(
                color: Colors.black87,
                fontSize: 16,
                fontWeight: FontWeight.w400),
          ),
        )
      ],
    ),
  );
}
