import 'package:flutter/material.dart';

class SingleArticle extends StatelessWidget {

  final articleCard = new Container(
    height: 124.0,
    width: double.infinity,
    margin: new EdgeInsets.only(left: 46.0),
    decoration: new BoxDecoration(
      color: new Color(0xFF3466AA),
      shape: BoxShape.rectangle,
      borderRadius: new BorderRadius.circular(8.0),
      boxShadow: <BoxShadow>[
        new BoxShadow(
          color: Colors.black12,
          blurRadius: 5.0,
          offset: new Offset(0.0, 10.0),
        ),
      ],
    ),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Spacer(),
        Text("Article Title", style: TextStyle(color: Colors.white, fontSize: 24.0, fontWeight: FontWeight.bold),),
        Text("Article Content Info", style: TextStyle(color: Colors.grey.shade400, fontSize: 15.0),),
        Spacer(),
        Text("Posted on Sun 4/3 02:36", style: TextStyle(color: Colors.white, fontSize: 15.0),),
        Spacer(),

      ],
    ),
  );

  final articleThumbnail = new Container(
    margin: new EdgeInsets.symmetric(
        vertical: 16.0
    ),
    alignment: FractionalOffset.centerLeft,
    child: new Image(
      image: new AssetImage("images/mars.png"),
      height: 92.0,
      width: 92.0,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return new Container(
        margin: const EdgeInsets.symmetric(
            vertical: 12.0,
            horizontal: 20.0,
            ),
        child: new Stack(
            children: <Widget>[
              articleCard,
              articleThumbnail,
            ],
        )
    );
  }
}
