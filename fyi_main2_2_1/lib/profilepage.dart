import 'package:flutter/material.dart';
var imagepadtop=50.0;
class ProfileScreen extends StatefulWidget {
  static Pattern pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Widget _profileText() {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Text(
        'Profile',
        style: TextStyle(
          fontSize: 35.0,
          letterSpacing: 1.5,
          color: Colors.black87,
          fontWeight: FontWeight.w300,
        ),
      ),
    );
  }

  Widget _circleAvatar() {
    return Padding(
      padding: const EdgeInsets.only(top: 50),
      child: Container(
        width: MediaQuery.of(context).size.width / 2,
        height: MediaQuery.of(context).size.width / 2,
        padding: EdgeInsets.all(10.0),
        decoration: BoxDecoration(
          border: Border.all(color: Colors.white, width: 5),
          shape: BoxShape.circle,
          color: Colors.white,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: AssetImage('images/fyi.png'),
          ),
        ),
      ),
    );
  }

  Widget _textFormField({
    String hintText,
    IconData icon,
  }) {
    return Material(
      elevation: 1,
      shadowColor: Colors.grey,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(
          4,
        ),
      ),
      child: TextField(
        decoration: InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(
                10,
              ),
            ),
            prefixIcon: Icon(
              icon,
              color: Theme.of(context).primaryColor,
            ),
            hintText: hintText,
            hintStyle: TextStyle(
              letterSpacing: 1,
              color: Colors.black,
              fontWeight: FontWeight.w300,
              fontSize: 18
            ),
            filled: true,
            fillColor: Colors.white30),
      ),
    );
  }

  Widget _textFormFieldCalling() {
    return Padding(
      padding: const EdgeInsets.only(left: 20,right: 20),
      child: Column(
        // crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _textFormField(
              hintText: 'User Name',
              icon: Icons.person,
            ),
            SizedBox(height: 20,),
            _textFormField(
              hintText: 'Date of Birth',
              icon: Icons.calendar_today,
            ),
            SizedBox(height: 20,),

            _textFormField(
              hintText: 'E-mail',
              icon: Icons.mail,
            ),
            SizedBox(height: 20,),

            _textFormField(
              hintText: 'Phone Number',
              icon: Icons.phone,
            ),
            SizedBox(height: 20,),
            _textFormField(
              hintText: 'Education',
              icon: Icons.school,
            ),
            SizedBox(height: 20,),

            _textFormField(
              hintText: 'Experience',
              icon: Icons.work,
            ),
            SizedBox(height: 20,),
            _textFormField(
              hintText: 'Skills',
              icon: Icons.star,
            ),
            SizedBox(height: 20,),

            _textFormField(
              hintText: 'Achievements',
              icon: Icons.stars,
            ),
            SizedBox(height: 20,),

            _textFormField(
              hintText: 'Projects',
              icon: Icons.post_add,
            ),
            SizedBox(height: 20,),

          Container(
            height: 55,
            width: double.infinity,
            child: RaisedButton(
              color: Theme.of(context).primaryColor,
              child: Center(
                child: Text(
                  'Update',
                  style: TextStyle(
                    fontSize: 23,
                    color: Colors.white,
                  ),
                ),
              ),
              onPressed: () {},
            ),
          ),
            SizedBox(height: 40,),

          ],
        ),
    );
  }

  @override
  Widget build(BuildContext context) {
    imagepadtop=MediaQuery.of(context).size.width / 4;

    return SafeArea(
      child: Scaffold(
//      resizeToAvoidBottomInset: false,
//      resizeToAvoidBottomPadding: false,
        body: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                // alignment: Alignment.center,
                alignment: Alignment.topCenter,
                children: [
                  CustomPaint(
                    child: Container(
                      // width: MediaQuery.of(context).size.width,
                      // height: MediaQuery.of(context).size.height,
                    ),
                    painter: HeaderCurvedContainer(),
                  ),
                  _circleAvatar(),
                ],
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _profileText(),
                  // _circleAvatar(),
                  _textFormFieldCalling()
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Color(0xff555555)
class HeaderCurvedContainer extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    Paint paint = Paint()..color = const Color(0xff3466aa);
    Path path = Path()
      ..relativeLineTo(0, 150)
      ..quadraticBezierTo(size.width / 2, 250.0, size.width, 150)
      ..relativeLineTo(0, -150)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}
