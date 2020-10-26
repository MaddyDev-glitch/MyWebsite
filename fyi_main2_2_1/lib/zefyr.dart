// import 'package:flutter/material.dart';
// // import 'package:fyi_main/zefyr.dart';
// import 'package:zefyr/zefyr.dart';
// import 'package:quill_delta/quill_delta.dart';
// import 'package:image_picker/image_picker.dart';
//
// class zefyr extends StatefulWidget {
//   @override
//   _zefyrState createState() => _zefyrState();
// }
//
// class _zefyrState extends State<zefyr> {
//   ZefyrController _controller;
//   FocusNode _focusNode;
//
//   @override
//   void initState() {
//     super.initState();
//     final document = _loaddocument();
//     _controller = ZefyrController(document);
//     _focusNode = FocusNode();
//   }
//
//   NotusDocument _loaddocument() {
//     final Delta delta = Delta()..insert("Zefyr quick start\n");
//     return NotusDocument.fromDelta(delta);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     // return MaterialApp(
//     //   home: Scaffold(
//     //     appBar: AppBar(
//     //       title: Text("Editor"),
//     //     ),
//     //     body: ZefyrEditor(
//     //       padding: EdgeInsets.all(16.0),
//     //       controller: _controller,
//     //       focusNode: _focusNode,
//     //     ),
//     //   ),
//     // );
//     return ZefyrScaffold(
//       child: SafeArea(
//         child: Container(
//           color: Colors.white,
//           padding: EdgeInsets.fromLTRB(16, 50, 16, 16),
//           child: ZefyrEditor(
//             controller: _controller,
//             focusNode: _focusNode,
//           ),
//         ),
//       ),
//     );
//   }
// }
