// lib/views/favorites_screen.dart

import 'package:flutter/material.dart';
import 'package:flutter_news2/models/article_model.dart';
import 'package:flutter_news2/services/favorites_service.dart';
import 'package:flutter_news2/views/news_tile.dart';

class FavoritesScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Favorites'),
      ),
      body: StreamBuilder<List<ArticleModel>>(
        stream: FavoritesService().getFavorites(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.length,
              itemBuilder: (context, index) {
                return NewsTile(
                  imageUrl: snapshot.data![index].urlToImage,
                  title: snapshot.data![index].title,
                  desc: snapshot.data![index].description,
                  content: snapshot.data![index].content,
                );
              },
            );
          } else if (snapshot.hasError) {
            return Text("${snapshot.error}");
          }
          return CircularProgressIndicator();
        },
      ),
    );
  }
}
