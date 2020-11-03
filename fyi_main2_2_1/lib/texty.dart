// import 'dart:core';
// import 'package:flutter/material.dart';
// import 'html_editor.dart';
// import 'package:dio/dio.dart';
// import 'package:image_picker/image_picker.dart';
// import 'package:flutter/foundation.dart';
//
// List majorSend = [];
// List type = [];
// List<GlobalKey<HtmlEditorState>> keyEditor1 =
//     List<GlobalKey<HtmlEditorState>>(200);
// int i = 1;
// String token =
//     "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiMDlZWUpmRlQyblo5QU9jM3BvZDlHbnEwdWwwMiJ9LCJpYXQiOjE2MDE3MTQ0NzJ9.dLU-k1kJkEWNtJT9NhkciM-SJAZ-Fdrl1WZNrA24mR8";
// FormData formData;
// List<String> arrayData = List<String>(200);
//
// class MyHomePage extends StatefulWidget {
//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }
//
// getImageGallery() async {
//   var imageFile = await ImagePicker.pickImage(source: ImageSource.gallery);
// }
//
// class _MyHomePageState extends State<MyHomePage> {
//   List<Widget> list = new List();
//
//   String result = "";
//
//   @override
//   void initState() {
//     super.initState();
//     for (int z = 1; z <= 100; z++) {
//       keyEditor1[z] = GlobalKey();
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     showAlertDialog(BuildContext context) {
//       // set up the buttons
//       Widget cancelButton = FlatButton(
//         child: Text("Cancel",style: TextStyle(fontSize: 20),),
//         onPressed: () {
//           Navigator.of(context).pop();
//         },
//       );
//       Widget continueButton = FlatButton(
//         child: Text("Continue anyways", style: TextStyle(
//             fontSize: 15,
//             fontWeight: FontWeight.w700,
//             color: Colors.red.shade700),),
//         onPressed: () {
//           setState(() {
//             for (int i = 1; i <= list.length; i++) {
//               keyEditor1[list.length].currentState.setEmpty();
//             }
//             list.clear();
//             // build(context);
//             Navigator.of(context).pop();
//           });
//         },
//       );
//       // set up the AlertDialog
//       AlertDialog alert = AlertDialog(
//         title: Text("RESET"),
//         content: Container(
//           height: 161,
//           width: 200,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               new Text(
//                 'Uh...',
//                 style: TextStyle(
//                     fontSize: 40,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.red.shade700),
//               ),
//               new SizedBox(
//                 height: 10,
//               ),
//               new Text(
//                 'You sure about Resetting?',
//                 style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.w700,
//                     color: Colors.red.shade700),
//               ),
//               new SizedBox(
//                 height: 20,
//               ),
//               new Text('You will lose all the content in this page!'),
//             ],
//           ),
//         ),
//         actions: [
//           cancelButton,
//           continueButton,
//         ],
//       );
//       // show the dialog
//       showDialog(
//         context: context,
//         builder: (BuildContext context) {
//           return alert;
//         },
//       );
//     }
//
//     return Scaffold(
//       resizeToAvoidBottomPadding: false,
//       appBar: AppBar(
//         title: Text("Create Content"),
//         elevation: 0,
//         actions: <Widget>[
//           Padding(
//               padding: EdgeInsets.only(right: 20.0),
//               child: GestureDetector(
//                   onTap: () async {
//                     for (int j = 1; j <= list.length; j++) {
//                       var currentStateText =
//                           await keyEditor1[j].currentState.getText();
//                       var printo = currentStateText;
//                       arrayData[j] = currentStateText;
//                       majorSend = [arrayData, list.length, type];
//                     }
//                     setState(() {
//                       Navigator.pop(context, majorSend);
//                     });
//                   },
//                   child: Row(
//                     children: [
//                       Text(
//                         "Submit",
//                         style: TextStyle(
//                             fontSize: 17, fontWeight: FontWeight.w600),
//                       ),
//                       SizedBox(
//                         width: 5,
//                       ),
//                       Icon(
//                         Icons.send_outlined,
//                         size: 26.0,
//                       ),
//                     ],
//                   ))),
//           // Padding(
//           //     padding: EdgeInsets.only(right: 20.0),
//           //     child: GestureDetector(
//           //       onTap: () {},
//           //       child: Icon(
//           //           Icons.more_vert
//           //       ),
//           //     )
//           // ),
//         ],
//       ),
//       backgroundColor: Colors.blue.shade50,
//       body: Padding(
//         padding: const EdgeInsets.all(0.0),
//         child: Stack(
//           children: <Widget>[
//             SingleChildScrollView(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: <Widget>[
//                   SizedBox(
//                     height: 500,
//                     child: Container(
//                         decoration: BoxDecoration(
//                             // color: Colors.blueGrey
//                             ),
//                         child: ListView.builder(
//                           itemBuilder: (context, index) {
//                             Widget widget = list.elementAt(index);
//                             return widget;
//                           },
//                           itemCount: list.length,
//                         )),
//                   ),
//
//                   // new Container(
//                   //   child: Container(
//                   //     child: HtmlEditor(
//                   //       hint: "Your text here...",
//                   //       key: keyEditor1[1],
//                   //       height: 300,
//                   //     ),
//                   //   ),
//                   // ),
//
// //                  input_tile(keyEditor: keyEditor1[1]),
//                   // input_tile(keyEditor: keyEditor1[2]),
//
//                   // SizedBox(
//                   //   height: 600,
//                   //   child: Container(
//                   //     child: new ListView(
//                   //       children: tiles,
//                   //       // scrollDirection: Axis.horizontal,
//                   //     ),
//                   //   ),
//                   // ),
//
//                   // new ListView.builder(itemBuilder: (context, index) {
//                   //   Widget widget = list.elementAt(index);
//                   //   return widget;
//                   // }, itemCount: list.length,),
//                   // SizedBox(
//                   //   height: 100,
//                   //   child: Container(
//                   //     child: new ListView(
//                   //       children: imgbox,
//                   //       // scrollDirection: Axis.horizontal,
//                   //     ),
//                   //   ),
//                   // ),
//                   // imgshow(),
//                   Column(
//                     children: [
//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.center,
//                         children: [
//                           FlatButton(
//                               color: Colors.blueGrey,
//                               onPressed: () {
//                                 setState(() {
//                                   // list.add( input_tile(index: list.length,));
//                                   type.add("text");
//                                   list.add(
//                                     new Container(
//                                       child: Container(
//                                         child: HtmlEditor(
//                                           showBottomToolbar: false,
//                                           hint:
//                                               "Your text here...<br> Paragraph ${list.length + 1}",
//                                           key: keyEditor1[list.length + 1],
//                                           height: 300,
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                   print("number==== ${list.length}");
//                                   print("${keyEditor1[1]}");
//                                 });
//                               },
//
//                               child: Row(
//                                 children: [
//                                   widgetIcon(Icons.text_snippet, ""),
//                                   Text("ADD TEXT",
//                                       style: TextStyle(color: Colors.white)),
//                                 ],
//                               )),
//                           SizedBox(
//                             width: 10,
//                           ),
//                           FlatButton(
//                               color: Colors.blueGrey,
//                               onPressed: () {
//                                 setState(() {
//                                   // list.add( input_tile(index: list.length,));
//                                   type.add("image");
//                                   list.add(
//                                     new Container(
//                                       child: Container(
//                                         child: HtmlEditor(
//                                           hint: "ADD IMAGE HERE... "
//                                               "<br><b>CLICK 'Image from device'</b> in bottom panel to add image from gallery or camera <br> <b>CLICK image icon</b> from top bar for embedding URLs  ",
//                                           key: keyEditor1[list.length + 1],
//                                           height: 300,
//
//                                         ),
//                                       ),
//                                     ),
//                                   );
//                                   print("number number==== ${list.length}");
//                                   print("${keyEditor1[1]}");
//                                 });
//                               },
//                               child: Row(
//                                 children: [
//                                   widgetIcon(Icons.image, ""),
//                                   Text("ADD IMAGE",
//                                       style: TextStyle(color: Colors.white)),
//                                 ],
//                               )),
//                           SizedBox(
//                             width: 10,
//                           ),
//                         ],
//                       ),
//
//                       // RaisedButton(
//                       //   child: Icon(Icons.image),
//                       //   onPressed: () => getImageGallery(),
//                       // ),
//                     ],
//                   ),
//                   // HtmlEditor(
//                   //   hint: "Your text here...",
//                   //   //value: "text content initial, if any",
//                   //   // value: "hey",
//                   //   key: keyEditor1,
//                   //   height: 300,
//                   // ),
//                   FlatButton(
//                       color: Colors.blueGrey,
//                       onPressed: () {
//                         list.removeLast();
//                         type.removeLast();
//                         setState(() {});
//                       },
//                       child: Text("REMOVE Recent Text/Image",
//                           style: TextStyle(color: Colors.white))),
//                   Padding(
//                     padding: const EdgeInsets.all(0.0),
//                     child: Row(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       children: <Widget>[
//                         FlatButton(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(12.0),
//                           ),
//                           height: 40,
//                           color: Colors.redAccent,
//                           onPressed: () {
//                             showAlertDialog(context);
//                           },
//                           child: Text("Reset",
//                               style: TextStyle(
//                                   color: Colors.white,
//                                   fontWeight: FontWeight.w300,
//                                   fontSize: 25)),
//                         ),
//                         // SizedBox(
//                         //   width: 16,
//                         // ),
//                         // FlatButton(
//                         //   shape: RoundedRectangleBorder(
//                         //     borderRadius: BorderRadius.circular(12.0),
//                         //   ),
//                         //   height: 40,
//                         //   color: Colors.lightGreenAccent.shade700,
//                         //   onPressed: () async {
//                         //     for (int j = 1; j <= list.length; j++) {
//                         //       var currentStateText =
//                         //           await keyEditor1[j].currentState.getText();
//                         //       var printo = currentStateText;
//                         //       arrayData[j] = currentStateText;
//                         //       majorSend = [arrayData, list.length, type];
//                         //     }
//                         //     setState(() {
//                         //       Navigator.pop(context, majorSend);
//                         //     });
//                         //   },
//                         //   child: Text(
//                         //     "Submit",
//                         //     style: TextStyle(
//                         //         color: Colors.white,
//                         //         fontWeight: FontWeight.w300,
//                         //         fontSize: 25),
//                         //   ),
//                         // ),
//                       ],
//                     ),
//                   ),
//                   // FlatButton(
//                   //   child: Text("click me"),
//                   //   onPressed: () {
//                   //     setState(() {
//                   //       // getHttp();
//                   //     });
//                   //   },
//                   // ),
//
//                   // Padding(
//                   //   padding: const EdgeInsets.all(8.0),
//                   //   child: Text(result),
//                   // )
//                 ],
//               ),
//             )
//           ],
//         ),
//       ),
//     );
//   }
// }
//
// class input_tile extends StatelessWidget {
//   const input_tile({Key key, @required this.index}) : super(key: key);
//   final int index;
//
//   @override
//   Widget build(BuildContext context) {
//     print("KEYEDITOR1[INDEX]====");
//     return new Container(
//       child: Container(
//         child: HtmlEditor(
//           hint: "Your text here...",
//           // key:keyEditor1[]
//           height: 300,
//         ),
//       ),
//     );
//   }
// }
//
// Widget widgetIcon(IconData icon, String title, {OnClik onKlik}) {
//   return InkWell(
//     onTap: () {
//       onKlik();
//     },
//     child: Row(
//       children: <Widget>[
//         Icon(
//           icon,
//           color: Colors.black54,
//           size: 20,
//         ),
//         Padding(
//           padding: const EdgeInsets.only(left: 4),
//           child: Text(
//             title,
//             style: TextStyle(
//                 color: Colors.black87,
//                 fontSize: 16,
//                 fontWeight: FontWeight.w400),
//           ),
//         )
//       ],
//     ),
//   );
// }
