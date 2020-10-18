import 'package:image_picker/image_picker.dart';
import 'dart:io';
import 'dart:async';
import 'dart:io';
import 'texty.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/basic.dart';
import 'package:flutter/src/widgets/container.dart';

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
  TextEditingController myContent;
  TextEditingController myTitle;
  String Htmldata;

  pickImageFromGallery(ImageSource source) {
    setState(() {
      imageFile = ImagePicker.pickImage(source: source);
    });
  }

  _MyHomePage(BuildContext context) async {
    final data = await Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => MyHomePage()),
    );
    Htmldata = data;
  }

  @override
  void initState() {
    super.initState();
    myTitle = new TextEditingController(text: null);
    myContent = new TextEditingController(text: null);
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
    myContent.dispose();
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
                  print("my=====${myTitle.text}");
                  print("SUCCESS============ $Htmldata");
                  // if (myTitle == "" || myContent == "") {
                  //   _showcontent();
                  //
                  // }
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
