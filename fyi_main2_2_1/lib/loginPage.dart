// import 'package:flutter/material.dart';
// import 'package:validate/validate.dart';
// import 'package:firebase_auth/firebase_auth.dart';
//
// String regno = '19bce1586';
//
// abstract class AuthImpl {
//   Future<FirebaseUser> signIn(String email, String password);
//   Future<FirebaseUser> signUp(String email, String password);
//   Future<FirebaseUser> googleSignIn();
//   Future<FirebaseUser> twitterSignIn();
//   Future<FirebaseUser> getCurrentUser();
//   Future<void> signOut();
// }
//
// class Auth implements AuthImpl {
//   String name;
//   final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;
//   final GoogleSignIn _googleSignIn = googleSignIn();
// //  static final TwitterLogin twitterLogin = new TwitterLogin(
// //    consumerKey: Constants.kTwitterApiKey,
// //    consumerSecret: Constants.kTwitterApiSecret,
// //  );
//
// //  Future<FirebaseUser> signIn(String email, String password) async {
// //    AuthResult user = await _firebaseAuth.signInWithEmailAndPassword(
// //        email: email, password: password);
// //    return user;
// //  }
//
//   Future<void> signOut() async {
//     return _firebaseAuth.signOut();
//   }
//
//   Future<FirebaseUser> googleSignIn() async {
//     GoogleSignInAccount googleUser = await _googleSignIn.signIn();
//     GoogleSignInAuthentication googleAuth = await googleUser.authentication;
//     final AuthCredential credential = await GoogleAuthProvider.getCredential(
//       accessToken: googleAuth.accessToken,
//       idToken: googleAuth.idToken,
//     );
//     final FirebaseUser user =
//         (await _firebaseAuth.signInWithCredential(credential)).user;
//     name = user.uid;
// //    final FirebaseUser currentUser = await FirebaseAuth.instance();
// //    assert(user.uid == currentUser.uid);
//     return user;
//   }
//
//   noSuchMethod(Invocation invocation) => super.noSuchMethod(invocation);
// }
//
// class LoginPage extends StatefulWidget {
//   LoginPage({Key key}) : super(key: key);
//
//   @override
//   _LoginPageState createState() => new _LoginPageState();
// }
//
// class _LoginData {
//   String email = '';
//   String password = '';
// }
//
// class _LoginPageState extends State<LoginPage> {
//   final GlobalKey<ScaffoldState> _scaffoldKey = new GlobalKey<ScaffoldState>();
//   final GlobalKey<FormState> _formKey = new GlobalKey<FormState>();
//   _LoginData _data = new _LoginData();
//   final AuthImpl _auth = new Auth();
//
// //  String _validateEmail(String value) {
// //    try {
// //      Validate.isEmail(value);
// //    } catch (e) {
// //      return 'Invalid email';
// //    }
// //
// //    return null;
// //  }
// //
// //  String _validatePassword(String value) {
// //    if (value.length < 6) {
// //      return 'Invalid password';
// //    }
// //
// //    return null;
// //  }
//
//   Widget _buildGoogleButton() {
//     return Container(
//       margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 10.0),
//       height: 40.0,
//       child: RaisedButton(
//         elevation: 8.0,
//         shape: RoundedRectangleBorder(),
//         color: kWhiteColor,
//         child: Row(
//           children: <Widget>[
//             Image.asset(
//               'img/google.png',
//               height: 24.0,
//             ),
//             Container(
//               margin: EdgeInsets.symmetric(horizontal: 40.0),
//               child: Text(
//                 'Continue with Google',
//                 style: TextStyle(
//                   fontSize: 18.0,
//                   fontWeight: FontWeight.bold,
//                   color: kBlueColor,
//                 ),
//               ),
//             ),
//           ],
//         ),
//         onPressed: () async {
//           _auth
//               .googleSignIn()
//               .then((FirebaseUser user) => Navigator.push(
//             context,
//             MaterialPageRoute(
//                 builder: (context) => AttendanceScreen(user: user)),
//           ))
//               .catchError((e) => print(e));
//         },
//       ),
//     );
//   }
//
// //  Widget _buildTwitterButton() {
// //    return Container(
// //      margin: EdgeInsets.symmetric(horizontal: 10.0),
// //      height: 40.0,
// //      child: RaisedButton(
// //        elevation: 8.0,
// //        shape: RoundedRectangleBorder(),
// //        color: kWhiteColor,
// //        child: Row(
// //          children: <Widget>[
// //            Image.asset(
// //              'img/twitter.png',
// //              height: 24.0,
// //            ),
// //            Container(
// //              margin: EdgeInsets.symmetric(horizontal: 40.0),
// //              child: Text(
// //                'Continue with Twitter',
// //                style: TextStyle(
// //                  fontSize: 18.0,
// //                  fontWeight: FontWeight.bold,
// //                  color: kBlueColor,
// //                ),
// //              ),
// //            ),
// //          ],
// //        ),
// //        onPressed: () {
// //          _auth
// //              .twitterSignIn()
// //              .then((FirebaseUser user) => Navigator.push(
// //                    context,
// //                    MaterialPageRoute(
// //                        builder: (context) => HomePage(user: user)),
// //                  ))
// //              .catchError((e) => print(e));
// //        },
// //      ),
// //    );
// //  }
//
// //  Widget _buildFormLogin() {
// //    return Form(
// //      key: this._formKey,
// //      child: Column(
// //        children: <Widget>[
// //          Theme(
// //            data: Theme.of(context).copyWith(primaryColor: kBlackColor),
// //            child: TextFormField(
// //                keyboardType: TextInputType.emailAddress,
// //                decoration: InputDecoration(
// //                  labelText: 'Email address',
// //                  enabledBorder: const OutlineInputBorder(
// //                    borderSide: const BorderSide(color: kWhiteColor),
// //                  ),
// //                  border: const OutlineInputBorder(),
// //                  labelStyle: TextStyle(color: kWhiteColor),
// //                  focusedBorder: const OutlineInputBorder(
// //                    borderSide: const BorderSide(color: kWhiteColor),
// //                  ),
// //                ),
// //                validator: _validateEmail,
// //                onSaved: (String value) {
// //                  this._data.email = value;
// //                }),
// //          ),
// //          SizedBox(
// //            height: 12.0,
// //          ),
// //          Theme(
// //            data: Theme.of(context).copyWith(primaryColor: kBlackColor),
// //            child: TextFormField(
// //                obscureText: true,
// //                decoration: InputDecoration(
// //                  labelText: 'Password',
// //                  enabledBorder: const OutlineInputBorder(
// //                    borderSide: const BorderSide(color: kWhiteColor),
// //                  ),
// //                  border: const OutlineInputBorder(),
// //                  labelStyle: TextStyle(color: kWhiteColor),
// //                  focusedBorder: const OutlineInputBorder(
// //                    borderSide: const BorderSide(color: kWhiteColor),
// //                  ),
// //                ),
// //                validator: _validatePassword,
// //                onSaved: (String value) {
// //                  this._data.password = value;
// //                }),
// //          ),
// //        ],
// //      ),
// //    );
// //  }
// //
// //  Widget _buildForgotPassword() {
// //    return Container(
// //      margin: new EdgeInsets.symmetric(horizontal: 15.0),
// //      height: 40.0,
// //      child: Center(
// //        child: GestureDetector(
// //          child: Text(
// //            'Forgot password?',
// //            style: TextStyle(
// //              fontSize: 14.0,
// //              color: kWhiteColor,
// //              fontWeight: FontWeight.bold,
// //            ),
// //          ),
// //          onTap: () {},
// //        ),
// //      ),
// //    );
// //  }
// //
// //  Widget _buildLoginButton() {
// //    return Container(
// //      margin: EdgeInsets.symmetric(vertical: 20.0, horizontal: 15.0),
// //      height: 40.0,
// //      child: RaisedButton(
// //        elevation: 8.0,
// //        shape: StadiumBorder(),
// //        color: kWhiteColor,
// //        child: Text(
// //          'Log In',
// //          style: TextStyle(
// //            fontSize: 18.0,
// //            fontWeight: FontWeight.bold,
// //            color: kBlueColor,
// //          ),
// //        ),
// //        onPressed: () {
// //          if (this._formKey.currentState.validate()) {
// //            _formKey.currentState.save();
// //            _auth
// //                .signIn(_data.email, _data.password)
// //                .then((FirebaseUser user) => Navigator.push(
// //                      context,
// //                      MaterialPageRoute(
// //                          builder: (context) => HomePage(user: user)),
// //                    ))
// //                .catchError((e) => print(e));
// //          }
// //        },
// //      ),
// //    );
// //  }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       key: _scaffoldKey,
//       body: Container(
//         decoration: BoxDecoration(
//           gradient: LinearGradient(
//               begin: Alignment.topRight,
//               end: Alignment.bottomLeft,
//               stops: [0.1, 0.5, 0.7, 0.9],
//               colors: kDegradedColors),
//         ),
//         child: SafeArea(
//           child: ListView(
//             padding: EdgeInsets.symmetric(horizontal: 24.0),
//             children: <Widget>[
//               SizedBox(height: 40.0),
//               _buildGoogleButton(),
//               SizedBox(height: 30.0),
//               Container(
//                 child: Text('ENTER REGNO',style: TextStyle(color: Colors.white),),
//               ),
//               Divider(
//                 color: Colors.white,
//               ),
//               SizedBox(height: 30.0),
//               SizedBox(height: 20.0),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
//
// //bool _alreadyExist=false;
// //
// //Firestore.instance
// //    .collection('testC')
// //.document('testD')
// //.get()
// //    .then((DocumentSnapshot ds) {
// ////      print(ds.data);
// //_masterDeviceName = ds.data['MDname'];
// //_masterDeviceAddress = ds.data['MDaddress'];
// //// use ds as a snapshot
// //});
