// lib/views/article_view.dart

import 'package:flutter/material.dart';
import 'package:flutter_news2/models/article_model.dart';
import 'package:http/http.dart' as http;
import 'package:html/parser.dart' as parser;
import 'package:html/dom.dart' as dom;
import 'package:flutter_news2/services/favorites_service.dart';

class ArticleView extends StatelessWidget {
  final ArticleModel article;

  ArticleView({required this.article});

  Future<String> fetchFullContent(String url) async {
    final response = await http.get(Uri.parse(url));
    dom.Document document = parser.parse(response.body);
    // 以下のセレクタは例であり、実際のセレクタは対象のウェブサイトによります
    dom.Element? contentElement = document.querySelector('div.article-content');
    return contentElement?.innerHtml ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<String>(
      future: fetchFullContent(article.url!),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return Scaffold(
            appBar: AppBar(
              title: Text(article.title!),
              actions: <Widget>[
                IconButton(
                  icon: Icon(Icons.favorite),
                  onPressed: () {
                    FavoritesService().addFavorite(article);
                  },
                ),
              ],
            ),
            body: Column(
              children: <Widget>[
                Image.network(article.urlToImage!),
                Text(article.description!),
                Text(snapshot.data!),
              ],
            ),
          );
        } else if (snapshot.hasError) {
          return Text("${snapshot.error}");
        }
        return CircularProgressIndicator();
      },
    );
  }
}
