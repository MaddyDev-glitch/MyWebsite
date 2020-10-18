library html_editor;

import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:html_editor/local_server.dart';
import 'package:html_editor/pick_image.dart';
import 'package:path/path.dart' as p;
import 'package:webview_flutter/webview_flutter.dart';
import 'package:http/http.dart' as http;
import 'package:dio/dio.dart';

String token =
    "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJ1c2VyIjp7ImlkIjoiMDlZWUpmRlQyblo5QU9jM3BvZDlHbnEwdWwwMiJ9LCJpYXQiOjE2MDE3MTQ0NzJ9.dLU-k1kJkEWNtJT9NhkciM-SJAZ-Fdrl1WZNrA24mR8";
File _image;
String testfd;
String url =
    "https://us-central1-fyi-vitc.cloudfunctions.net//api/article/imageUpload";
FormData formData;
var globresponse;
/*
* Created by riyadi rb on 2/5/2020.
* link  : https://github.com/xrb21/flutter-html-editor
*/

typedef void OnClik();

class HtmlEditor extends StatefulWidget {
  final String value;
  final double height;
  final BoxDecoration decoration;
  final bool useBottomSheet;
  final String widthImage;
  final bool showBottomToolbar;
  final String hint;

  HtmlEditor(
      {Key key,
        this.value,
        this.height = 380,
        this.decoration,
        this.useBottomSheet = true,
        this.widthImage = "100%",
        this.showBottomToolbar = true,
        this.hint})
      : super(key: key);

  @override
  HtmlEditorState createState() => HtmlEditorState();
}

class HtmlEditorState extends State<HtmlEditor> {
  WebViewController _controller;
  String text = "";
  final Key _mapKey = UniqueKey();

  int port = 5321;
  LocalServer localServer;

  @override
  void initState() {
    if (!Platform.isAndroid) {
      initServer();
    }
    super.initState();
  }

  postTest(file) async {
    print("===============================================================================================================================\n");

    final uri = 'https://us-central1-fyi-vitc.cloudfunctions.net/';
    var map = new Map<String, dynamic>();
    var b=file.readAsBytesSync();
    // map['image'] = b;
    var requestBody = {
      'image':b,
    };

    http.Response response = await http.post(
      uri,
      body: json.encode(requestBody),
    );
    print("===============================================================================================================================\n");
    print(response.body);
  }

  initServer() {
    localServer = LocalServer(port);
    localServer.start(handleRequest);
  }

  void handleRequest(HttpRequest request) {
    try {
      if (request.method == 'GET' &&
          request.uri.queryParameters['query'] == "getRawTeXHTML") {
      } else {}
    } catch (e) {
      print('Exception in handleRequest: $e');
    }
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
      print("GETHHTTP fucntion print -> $response");
      // String a = response.toString();
      // print("LENGTH=");
      // print(a.length);
      globresponse=response;
    } catch (e) {
      print(e);
      print("ERROR");
      // print(formData.toString());
    }
  }

  @override
  void dispose() {
    if (_controller != null) {
      _controller = null;
    }
    if (!Platform.isAndroid) {
      localServer.close();
    }
    super.dispose();
  }

  _loadHtmlFromAssets() async {
    final filePath = 'packages/html_editor/summernote/summernote.html';
    _controller.loadUrl("http://localhost:$port/$filePath");
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height,
      decoration: widget.decoration ??
          BoxDecoration(
            borderRadius: BorderRadius.all(Radius.circular(4)),
            border: Border.all(color: Color(0xffececec), width: 1),
          ),
      child: Column(
        children: <Widget>[
          Expanded(
            child: WebView(
              key: _mapKey,
              onWebResourceError: (e) {
                print("error ${e.description}");
              },
              onWebViewCreated: (webViewController) {
                _controller = webViewController;

                if (Platform.isAndroid) {
                  final filename =
                      'packages/html_editor/summernote/summernote.html';
                  _controller.loadUrl(
                      "file:///android_asset/flutter_assets/" + filename);
                } else {
                  _loadHtmlFromAssets();
                }
              },
              javascriptMode: JavascriptMode.unrestricted,
              gestureNavigationEnabled: true,
              gestureRecognizers: [
                Factory(
                        () => VerticalDragGestureRecognizer()..onUpdate = (_) {}),
              ].toSet(),
              javascriptChannels: <JavascriptChannel>[
                getTextJavascriptChannel(context)
              ].toSet(),
              onPageFinished: (String url) {
                if (widget.hint != null) {
                  setHint(widget.hint);
                } else {
                  setHint("");
                }

                setFullContainer();
                if (widget.value != null) {
                  setText(widget.value);
                }
              },
            ),
          ),
          widget.showBottomToolbar
              ? Divider()
              : Container(
            height: 1,
          ),
          widget.showBottomToolbar
              ? Padding(
            padding: const EdgeInsets.only(
                left: 4.0, right: 4, bottom: 8, top: 2),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                widgetIcon(Icons.image, "Image from device", onKlik: () {
                  widget.useBottomSheet
                      ? bottomSheetPickImage(context)
                      : dialogPickImage(context);
                }),
                widgetIcon(Icons.content_copy, "Copy", onKlik: () async {
                  String data = await getText();
                  Clipboard.setData(new ClipboardData(text: data));
                }),
                widgetIcon(Icons.content_paste, "Paste",
                    onKlik: () async {
                      ClipboardData data =
                      await Clipboard.getData(Clipboard.kTextPlain);

                      String txtIsi = data.text
                          .replaceAll("'", '\\"')
                          .replaceAll('"', '\\"')
                          .replaceAll("[", "\\[")
                          .replaceAll("]", "\\]")
                          .replaceAll("\n", "<br/>")
                          .replaceAll("\n\n", "<br/>")
                          .replaceAll("\r", " ")
                          .replaceAll('\r\n', " ");
                      String txt =
                          "\$('.note-editable').append( '" + txtIsi + "');";
                      _controller.evaluateJavascript(txt);
                    }),
              ],
            ),
          )
              : Container(
            height: 1,
          )
        ],
      ),
    );
  }

  JavascriptChannel getTextJavascriptChannel(BuildContext context) {
    return JavascriptChannel(
        name: 'GetTextSummernote',
        onMessageReceived: (JavascriptMessage message) {
          String isi = message.message;
          if (isi.isEmpty ||
              isi == "<p></p>" ||
              isi == "<p><br></p>" ||
              isi == "<p><br/></p>") {
            isi = "";
          }
          setState(() {
            text = isi;
          });
        });
  }

  Future<String> getText() async {
    await _controller.evaluateJavascript(
        "GetTextSummernote.postMessage(document.getElementsByClassName('note-editable')[0].innerHTML);");
    return text;
  }

  setText(String v) async {
    String txtIsi = v
        .replaceAll("'", '\\"')
        .replaceAll('"', '\\"')
        .replaceAll("[", "\\[")
        .replaceAll("]", "\\]")
        .replaceAll("\n", "<br/>")
        .replaceAll("\n\n", "<br/>")
        .replaceAll("\r", " ")
        .replaceAll('\r\n', " ");
    String txt =
        "document.getElementsByClassName('note-editable')[0].innerHTML = '" +
            txtIsi +
            "';";
    _controller.evaluateJavascript(txt);
  }

  setFullContainer() {
    _controller.evaluateJavascript(
        '\$("#summernote").summernote("fullscreen.toggle");');
  }

  setFocus() {
    _controller.evaluateJavascript("\$('#summernote').summernote('focus');");
  }

  setEmpty() {
    _controller.evaluateJavascript("\$('#summernote').summernote('reset');");
  }

  setHint(String text) {
    String hint = '\$(".note-placeholder").html("$text");';
    _controller.evaluateJavascript(hint);
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
            color: Colors.black38,
            size: 20,
          ),
          Padding(
            padding: const EdgeInsets.only(left: 4),
            child: Text(
              title,
              style: TextStyle(
                  color: Colors.black54,
                  fontSize: 16,
                  fontWeight: FontWeight.w400),
            ),
          )
        ],
      ),
    );
  }

  dialogPickImage(BuildContext context) {
    return showDialog(
        context: context,
        barrierDismissible: true,
        builder: (BuildContext context) {
          return AlertDialog(
            elevation: 0,
            backgroundColor: Colors.transparent,
            content: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(8)),
              ),
              padding: const EdgeInsets.all(12),
              height: 120,
              child: PickImage(
                  color: Colors.black45,
                  callbackFile: (file) async {
                    String filename = p.basename(file.path);List<int> imageBytes = await file.readAsBytes();
                    print("--------------------\n");
                    print(imageBytes);
                    print("--------------------\n");


                    // String basedata = base64Encode(imageBytes);
                    String base64Image =
                        "<img width=\"${widget.widthImage}\" src=\"data:image/png;base64, "
                        "${base64Encode(imageBytes)}\" data-filename=\"$filename\">";

                    String txt =
                        "\$('.note-editable').append( '" + base64Image + "');";
                    _controller.evaluateJavascript(txt);
                  }),
            ),
          );
        });
  }

  bottomSheetPickImage(context) {
    showModalBottomSheet(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
        backgroundColor: Colors.white,
        context: context,
        builder: (BuildContext bc) {
          return StatefulBuilder(builder: (BuildContext context, setStatex) {
            return SingleChildScrollView(
                child: Container(
                  height: 140,
                  width: double.infinity,
                  child: PickImage(callbackFile: (file) async {
                    print("INSIDE");
                    _image=file;
                    await getHttp();
                    print("============================");
                    print(globresponse);
                    String filename = p.basename(file.path);
                    // List imageBytes = await file.readAsBytesSync();
                    // print("--------------------\n");
                    // print(imageBytes.length);
                    // print("--------------------\n");
                    // String basedata = await base64Encode(imageBytes);
                    // postTest(file);
                    String Imagetag = "<img width=\"${widget.widthImage}\" src=\"$globresponse\" data-filename=\"$filename\">";
                    String txt =
                        "\$('.note-editable').append( '" + Imagetag + "');";
                    _controller.evaluateJavascript(txt);
                  }),
                ));
          });
        });
  }
}

// <img width=50%
//     src=https://storage.googleapis.com/download/storage/v1/b/fyi-vitc.appspot.com/o/article%2F3c389a6e-7e26-4c0f-8cba-19c8ce135fe8.jpg?generation=1602906826001112&alt=media
// "${basedata}\" data-filename=\"$filename\">

//String Imagetag = " < img width=${widget.widthImage}src= $globresponse data-filename=$filename> ";
//                 String txt =
//                     "\$('.note-editable').append( '" + Imagetag + "');";

// String base64Image = "<img width=\"${widget.widthImage}\" "
//     "src=\"data:image/png;base64, "
//     "${basedata}\" data-filename=\"$filename\">";
// String txt =
//     "\$('.note-editable').append( '" + base64Image + "');";
// _controller.evaluateJavascript(txt);




// library html_editor;
//
// import 'dart:convert';
// import 'dart:io';
//
// import 'package:flutter/foundation.dart';
// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:html_editor/local_server.dart';
// import 'package:html_editor/pick_image.dart';
// import 'package:path/path.dart' as p;
// import 'package:webview_flutter/webview_flutter.dart';
//
// /*
//  * Created by riyadi rb on 2/5/2020.
//  * link  : https://github.com/xrb21/flutter-html-editor
//  */
//
// typedef void OnClik();
//
// class HtmlEditor extends StatefulWidget {
//   final String value;
//   final double height;
//   final BoxDecoration decoration;
//   final bool useBottomSheet;
//   final String widthImage;
//   final bool showBottomToolbar;
//   final String hint;
//
//   HtmlEditor(
//       {Key key,
//       this.value,
//       this.height = 380,
//       this.decoration,
//       this.useBottomSheet = true,
//       this.widthImage = "100%",
//       this.showBottomToolbar = true,
//       this.hint})
//       : super(key: key);
//
//   @override
//   HtmlEditorState createState() => HtmlEditorState();
// }
//
// class HtmlEditorState extends State<HtmlEditor> {
//   WebViewController _controller;
//   String text = "";
//   final Key _mapKey = UniqueKey();
//
//   int port = 5321;
//   LocalServer localServer;
//
//   @override
//   void initState() {
//     if (!Platform.isAndroid) {
//       initServer();
//     }
//     super.initState();
//   }
//
//   initServer() {
//     localServer = LocalServer(port);
//     localServer.start(handleRequest);
//   }
//
//   void handleRequest(HttpRequest request) {
//     try {
//       if (request.method == 'GET' &&
//           request.uri.queryParameters['query'] == "getRawTeXHTML") {
//       } else {}
//     } catch (e) {
//       print('Exception in handleRequest: $e');
//     }
//   }
//
//   @override
//   void dispose() {
//     if (_controller != null) {
//       _controller = null;
//     }
//     if (!Platform.isAndroid) {
//       localServer.close();
//     }
//     super.dispose();
//   }
//
//   _loadHtmlFromAssets() async {
//     final filePath = 'packages/html_editor/summernote/summernote.html';
//     _controller.loadUrl("http://localhost:$port/$filePath");
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       height: widget.height,
//       decoration: widget.decoration ??
//           BoxDecoration(
//             borderRadius: BorderRadius.all(Radius.circular(4)),
//             border: Border.all(color: Color(0xffececec), width: 1),
//           ),
//       child: Column(
//         children: <Widget>[
//           Expanded(
//             child: WebView(
//               key: _mapKey,
//               onWebResourceError: (e) {
//                 print("error ${e.description}");
//               },
//               onWebViewCreated: (webViewController) {
//                 _controller = webViewController;
//
//                 if (Platform.isAndroid) {
//                   final filename =
//                       'packages/html_editor/summernote/summernote.html';
//                   _controller.loadUrl(
//                       "file:///android_asset/flutter_assets/" + filename);
//                 } else {
//                   _loadHtmlFromAssets();
//                 }
//               },
//               javascriptMode: JavascriptMode.unrestricted,
//               gestureNavigationEnabled: true,
//               gestureRecognizers: [
//                 Factory(
//                     () => VerticalDragGestureRecognizer()..onUpdate = (_) {}),
//               ].toSet(),
//               javascriptChannels: <JavascriptChannel>[
//                 getTextJavascriptChannel(context)
//               ].toSet(),
//               onPageFinished: (String url) {
//                 if (widget.hint != null) {
//                   setHint(widget.hint);
//                 } else {
//                   setHint("");
//                 }
//
//                 setFullContainer();
//                 if (widget.value != null) {
//                   setText(widget.value);
//                 }
//               },
//             ),
//           ),
//           widget.showBottomToolbar
//               ? Divider()
//               : Container(
//                   height: 1,
//                 ),
//           widget.showBottomToolbar
//               ? Padding(
//                   padding: const EdgeInsets.only(
//                       left: 4.0, right: 4, bottom: 8, top: 2),
//                   child: Row(
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: <Widget>[
//                       widgetIcon(Icons.image, "Image", onKlik: () {
//                         widget.useBottomSheet
//                             ? bottomSheetPickImage(context)
//                             : dialogPickImage(context);
//                       }),
//                       widgetIcon(Icons.content_copy, "Copy", onKlik: () async {
//                         String data = await getText();
//                         Clipboard.setData(new ClipboardData(text: data));
//                       }),
//                       widgetIcon(Icons.content_paste, "Paste",
//                           onKlik: () async {
//                         ClipboardData data =
//                             await Clipboard.getData(Clipboard.kTextPlain);
//
//                         String txtIsi = data.text
//                             .replaceAll("'", '\\"')
//                             .replaceAll('"', '\\"')
//                             .replaceAll("[", "\\[")
//                             .replaceAll("]", "\\]")
//                             .replaceAll("\n", "<br/>")
//                             .replaceAll("\n\n", "<br/>")
//                             .replaceAll("\r", " ")
//                             .replaceAll('\r\n', " ");
//                         String txt =
//                             "\$('.note-editable').append( '" + txtIsi + "');";
//                         _controller.evaluateJavascript(txt);
//                       }),
//                     ],
//                   ),
//                 )
//               : Container(
//                   height: 1,
//                 )
//         ],
//       ),
//     );
//   }
//
//   JavascriptChannel getTextJavascriptChannel(BuildContext context) {
//     return JavascriptChannel(
//         name: 'GetTextSummernote',
//         onMessageReceived: (JavascriptMessage message) {
//           String isi = message.message;
//           if (isi.isEmpty ||
//               isi == "<p></p>" ||
//               isi == "<p><br></p>" ||
//               isi == "<p><br/></p>") {
//             isi = "";
//           }
//           setState(() {
//             text = isi;
//           });
//         });
//   }
//
//   Future<String> getText() async {
//     await _controller.evaluateJavascript(
//         "GetTextSummernote.postMessage(document.getElementsByClassName('note-editable')[0].innerHTML);");
//     return text;
//   }
//
//   setText(String v) async {
//     String txtIsi = v
//         .replaceAll("'", '\\"')
//         .replaceAll('"', '\\"')
//         .replaceAll("[", "\\[")
//         .replaceAll("]", "\\]")
//         .replaceAll("\n", "<br/>")
//         .replaceAll("\n\n", "<br/>")
//         .replaceAll("\r", " ")
//         .replaceAll('\r\n', " ");
//     String txt =
//         "document.getElementsByClassName('note-editable')[0].innerHTML = '" +
//             txtIsi +
//             "';";
//     _controller.evaluateJavascript(txt);
//   }
//
//   setFullContainer() {
//     _controller.evaluateJavascript(
//         '\$("#summernote").summernote("fullscreen.toggle");');
//   }
//
//   setFocus() {
//     _controller.evaluateJavascript("\$('#summernote').summernote('focus');");
//   }
//
//   setEmpty() {
//     _controller.evaluateJavascript("\$('#summernote').summernote('reset');");
//   }
//
//   setHint(String text) {
//     String hint = '\$(".note-placeholder").html("$text");';
//     _controller.evaluateJavascript(hint);
//   }
//
//   Widget widgetIcon(IconData icon, String title, {OnClik onKlik}) {
//     return InkWell(
//       onTap: () {
//         onKlik();
//       },
//       child: Row(
//         children: <Widget>[
//           Icon(
//             icon,
//             color: Colors.black38,
//             size: 20,
//           ),
//           Padding(
//             padding: const EdgeInsets.only(left: 4),
//             child: Text(
//               title,
//               style: TextStyle(
//                   color: Colors.black54,
//                   fontSize: 16,
//                   fontWeight: FontWeight.w400),
//             ),
//           )
//         ],
//       ),
//     );
//   }
//
//   dialogPickImage(BuildContext context) {
//     return showDialog(
//         context: context,
//         barrierDismissible: true,
//         builder: (BuildContext context) {
//           return AlertDialog(
//             elevation: 0,
//             backgroundColor: Colors.transparent,
//             content: Container(
//               decoration: BoxDecoration(
//                 color: Colors.white,
//                 borderRadius: BorderRadius.all(Radius.circular(8)),
//               ),
//               padding: const EdgeInsets.all(12),
//               height: 120,
//               child: PickImage(
//                   color: Colors.black45,
//                   callbackFile: (file) async {
//                     String filename = p.basename(file.path);
//                     List<int> imageBytes = await file.readAsBytes();
//                     String base64Image =
//                         "<img width=\"${widget.widthImage}\" src=\"data:image/png;base64, "
//                         "${base64Encode(imageBytes)}\" data-filename=\"$filename\">";
//
//                     String txt =
//                         "\$('.note-editable').append( '" + base64Image + "');";
//                     _controller.evaluateJavascript(txt);
//                   }),
//             ),
//           );
//         });
//   }
//
//   bottomSheetPickImage(context) {
//     showModalBottomSheet(
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
//         ),
//         backgroundColor: Colors.white,
//         context: context,
//         builder: (BuildContext bc) {
//           return StatefulBuilder(builder: (BuildContext context, setStatex) {
//             return SingleChildScrollView(
//                 child: Container(
//               height: 140,
//               width: double.infinity,
//               child: PickImage(callbackFile: (file) async {
//                 String filename = p.basename(file.path);
//                 List<int> imageBytes = await file.readAsBytes();
//                 String base64Image = "<img width=\"${widget.widthImage}\" "
//                     "src=\"data:image/png;base64, "
//                     "${base64Encode(imageBytes)}\" data-filename=\"$filename\">";
//                 String txt =
//                     "\$('.note-editable').append( '" + base64Image + "');";
//                 _controller.evaluateJavascript(txt);
//               }),
//             ));
//           });
//         });
//   }
// }
