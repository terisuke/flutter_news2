// lib/services/favorites_service.dart

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_news2/models/article_model.dart';

class FavoritesService {
  final CollectionReference _favoritesCollection =
      FirebaseFirestore.instance.collection('favorites');

  Future<void> addFavorite(ArticleModel article) {
    return _favoritesCollection.add(article.toJson());
  }

  Stream<List<ArticleModel>> getFavorites() {
    return _favoritesCollection.snapshots().map((snapshot) {
      return snapshot.docs
          .map((doc) => ArticleModel.fromJson(doc.data() as Map<String, dynamic>))
          .toList();
    });
  }
}
