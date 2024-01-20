import 'package:flutter/material.dart';
import 'package:flutter_news2/models/article_model.dart';
import 'package:flutter_news2/services/news.dart';
import 'package:flutter_news2/views/news_tile.dart';

class SearchScreen extends StatefulWidget {
  @override
  _SearchScreenState createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  List<ArticleModel>? articles;
  bool _loading = true;
  String _searchQuery = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: TextField(
          onChanged: (value) {
            _searchQuery = value;
            getNews();
          },
          decoration: InputDecoration(
            hintText: 'Search...',
          ),
        ),
      ),
      body: _loading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : articles!.isEmpty
            ? Center(child: Text('No results found.'))
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

  getNews() async {
    News newsClass = News();
    await newsClass.getNews(query: _searchQuery);
    articles = newsClass.news;
    setState(() {
      _loading = false;
    });
  }
}
