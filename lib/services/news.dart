import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter_news2/models/article_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class News {
  List<ArticleModel>? news = [];

  Future<void> getNews({String? category, String? query}) async {
    String? apiKey = dotenv.env['NewsApiKey'];
    String url =
        'https://newsapi.org/v2/top-headlines?country=jp&apiKey=$apiKey';
    if (category != null) {
      url += '&category=$category';
    }
    if (query != null) {
      url += '&q=$query';
    }
    var response = await http.get(Uri.parse(url));
    var jsonData = jsonDecode(response.body);

    if (jsonData['status'] == 'ok') {
      jsonData['articles'].forEach((element) {
        if (element['urlToImage'] != null && element['description'] != null) {
          ArticleModel article = ArticleModel(
              title: element['title'],
              author: element['author'],
              description: element['description'],
              url: element['url'],
              urlToImage: element['urlToImage'],
              content: element['content']);
          news?.add(article);
        }
      });
    }
  }
}
