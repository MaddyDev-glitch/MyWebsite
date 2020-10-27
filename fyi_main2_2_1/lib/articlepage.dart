import 'dart:convert';
import 'dart:convert';
import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'texty.dart';
import 'package:flutter/material.dart';
import 'package:dio/dio.dart';
import 'package:http/http.dart' as http;

const String submitUrl =
    'https://us-central1-fyi-vitc.cloudfunctions.net//api/article/createArticle';
int count;
var coverImgUrl;
String jsonTags;

class packet {
  String type;
  String content;
  packet(@required this.type, @required this.content);
}

class Tag {
  String type;
  String content;

  Tag(this.type, this.content);

  Map toJson() => {
        'type': type,
        'content': content,
      };
}

// Define a custom Form widget.
class MyCustomForm extends StatefulWidget {
  @override
  _MyCustomFormState createState() => _MyCustomFormState();
}

// Define a corresponding State class.
// This class holds the data related to the Form.
class _MyCustomFormState extends State<MyCustomForm> {
  // Create a text controller and use it to retrieve the current value
  // of the TextField.
  Future<File> imageFile;
  // TextEditingController myContent;
  TextEditingController myTitle;
  List<String> Htmldata;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  _MyHomePage(BuildContext context) async {
    // arrayData contains the array of objects STARTS FROM 0       count is length
    final List data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
    count = data[1];
    List temp = data[0];
    List typeArray = data[2];
    List<Tag> tags = [];
    print("COUNT home page=$count");
    List<String> arrayData = [];
    List<packet> packetSendData = [];
    for (int j = 1; j <= count; j++) {
      print("SUCCESS my home page");
      // print(temp[j]);
      arrayData.add(temp[j]);
      tags.add(Tag(typeArray[j - 1], temp[j]));
      print("REGULAR CHECK ==${arrayData.toString()}");
      packetSendData.add(packet("text", "hello"));
      // print("arraydata=${arrayData[j-1]}");
    }

    // tags.add(Tag('tagA', 3));
    // tags.add(Tag('tagA', 3));
    // tags.add(Tag('tagA', 3));
    jsonTags = jsonEncode(tags);
    print("jsonTags");
    print(jsonTags);
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

  // void sendArticle()
  // {
  //   Map map = {
  //     "title": myTitle.value,
  //     "coverImage": coverImgUrl.toString(),
  //     "article": arrayData
  //   };
  //
  //   print(apiRequest(submitUrl, map));
  // }
  //
  // Future<String> apiRequest(String url, Map jsonMap) async {
  //   HttpClient httpClient = new HttpClient();
  //   HttpClientRequest request = await httpClient.postUrl(Uri.parse(url));
  //   request.headers.set('content-type', 'application/json');
  //   request.add(utf8.encode(json.encode(jsonMap)));
  //   HttpClientResponse response = await request.close();
  //   print(response.statusCode);
  //   String reply = await response.transform(utf8.decoder).join();
  //   httpClient.close();
  //   return reply;
  // }
  Future<http.Response> postRequest() async {
    var url = submitUrl;
    Map data = {
      "title": myTitle.text,
      "coverImage": coverImgUrl.toString(),
      "article": jsonTags
    };
    //encode Map to JSON
    var body = json.encode(data);

    var response = await http.post(url,
        headers: {"x-auth-token": token, 'Content-Type': 'application/json'},
        body: body);
    print("${response.statusCode}");
    print("${response.body}");
    // return response;
  }

  @override
  void initState() {
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
            width: 300,
            height: 300,
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

  void _showcontent() {
    showDialog(
      context: context, barrierDismissible: false, // user must tap button!

      builder: (BuildContext context) {
        return new AlertDialog(
          title: new Text('You clicked on'),
          content: new SingleChildScrollView(
            child: new ListBody(
              children: [
                new Text('This is a Dialog Box. Click OK to Close.'),
              ],
            ),
          ),
          actions: [
            new FlatButton(
              child: new Text('Ok'),
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
      appBar: AppBar(
        title: Text('Retrieve Text Input'),
      ),
      body: Column(
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.all(12.0),
            child: SizedBox(
              width: double.infinity,
              child: RaisedButton(
                child: Text("Submit"),
                onPressed: () {
                  print("title=====${myTitle.text}");
                  print("SUCCESS============");
                  postRequest();
                },
              ),
            ),
          ),
          Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text(
                'Create an Article',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.w500),
              )),
          Container(
              margin: EdgeInsets.all(12),
              child: TextField(
                controller: myTitle,
                decoration: InputDecoration(
                  hintText: "Enter Title",
                  fillColor: Colors.grey[300],
                  filled: true,
                ),
              )),
          Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                showImage(),
                RaisedButton(
                  child: Text("Select Image from Gallery"),
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
                color: Colors.lightBlue,
                // child: TextField(
                //   controller: myContent,
                //   maxLines: null,
                //   decoration: InputDecoration(
                //     hintText: "Enter Content",
                //     fillColor: Colors.grey[300],
                //     filled: true,
                //   ),
                // ),
                child: RaisedButton(
                    child: Text("Write Content"),
                    onPressed: () {
                      // Navigator.pushNamed(context, '/d');
                      _MyHomePage(context);
                    }),
              ),
            ],
          ),
        ],
      ),
//      floatingActionButton: FloatingActionButton(
//        // When the user presses the button, show an alert dialog containing
//        // the text that the user has entered into the text field.
//        onPressed: () {
//          return showDialog(
//            context: context,
//            builder: (context) {
//              return AlertDialog(
//                // Retrieve the text the that user has entered by using the
//                // TextEditingController.
//                content: Text(myTitle.text),
//              );
//            },
//          );
//        },
//        tooltip: 'Show me the value!',
//        child: Icon(Icons.text_fields),
//      ),
    );
  }
}
