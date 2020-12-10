import 'package:flutter/material.dart';
import 'package:fyi_main2_2_1/ArticleCardNewDesign/singlearticle.dart';

class ArticlePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Articles"),
        backgroundColor: Colors.blueGrey.shade900,
      ),
      backgroundColor: Colors.white,
      body: ListView(
        children: [
          Column(
            children: [
              new SingleArticle(),
              new SingleArticle(),
              new SingleArticle(),
              new SingleArticle(),
              new SingleArticle(),
              new SingleArticle(),
              new SingleArticle(),
              new SingleArticle(),
              new SingleArticle(),
            ],
          ),
        ],
//        child: new
//      ),
      ),
    );
  }
}
