import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:myportfolio/main.dart';

class ComingSoonPage extends StatelessWidget {
  const ComingSoonPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Oops! I Spilled my coffee", style: GoogleFonts.lato(
              fontWeight: FontWeight.w300,
              color: Colors.brown.shade700,
              fontSize: 30,
            ),),
            Text("Error 404", style: GoogleFonts.lato(
              fontWeight: FontWeight.w800,
              color: Colors.red,
              fontSize: 100,
            ),),
            Wrap(
              crossAxisAlignment: WrapCrossAlignment.end,
              direction: Axis.horizontal,
              children: [
                Text("Well, ", style: GoogleFonts.lato(
                  fontWeight: FontWeight.w400,
                  color: Colors.red,
                  fontSize: 50,
                ),),
                Text("actually its Future(200) ", style: GoogleFonts.lato(
                  fontWeight: FontWeight.w300,
                  color: Colors.black,
                  fontSize: 40,
                ),),
              ],
            ),
            SizedBox(height: 50,),
            Text("ahh I need a coffee.. \n Will be right back :)", style: GoogleFonts.lato(
              fontWeight: FontWeight.w300,
              color: Colors.brown.shade700,
              fontSize: 30,
            ),),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: Align(
                  alignment: Alignment.topLeft,
                  child: TextButton(onPressed: (){
                    navigatorKey.currentState!.pop();
                  }, child:Text("Back to home page"),)),
            ),
          ],
        ),
      ),
    );
  }
}
