// lib/views/news_tile.dart

import 'package:flutter/material.dart';

class NewsTile extends StatelessWidget {
  final String? imageUrl, title, desc, content;

  NewsTile({this.imageUrl, this.title, this.desc, this.content});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: <Widget>[
          Image.network(imageUrl!),
          Text(title!),
          Text(desc!),
        ],
      ),
    );
  }
}
