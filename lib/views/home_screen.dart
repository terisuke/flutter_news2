import 'package:flutter/material.dart';
import 'package:flutter_news2/models/article_model.dart';
import 'package:flutter_news2/services/news.dart';
import 'package:flutter_news2/views/news_tile.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<ArticleModel>? articles;
  bool _loading = true;
  String _category = 'all';

  @override
  void initState() {
    super.initState();
    getNews();
  }

  getNews() async {
    News newsClass = News();
    await newsClass.getNews(category: _category);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter News'),
        actions: <Widget>[
          DropdownButton<String>(
            value: _category,
            icon: Icon(Icons.filter_list),
            onChanged: (String? newValue) {
              setState(() {
                _category = newValue!;
                _loading = true;
                getNews();
              });
            },
            items: <String>['all', 'business', 'entertainment', 'health', 'science', 'sports', 'technology']
              .map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              })
              .toList(),
          ),
        ],
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: articles!.length,
              itemBuilder: (context, index) {
                return NewsTile(
                  imageUrl: articles![index].urlToImage,
                  title: articles![index].title,
                  desc: articles![index].description,
                  content: articles![index].content,
                );
              },
            ),
    );
  }
}
