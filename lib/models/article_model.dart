// lib/models/article_model.dart

class ArticleModel {
  String? title;
  String? author;
  String? description;
  String? url;
  String? urlToImage;
  String? content;

  ArticleModel({
    this.title,
    this.author,
    this.description,
    this.url,
    this.urlToImage,
    this.content,
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'author': author,
      'description': description,
      'url': url,
      'urlToImage': urlToImage,
      'content': content,
    };
  }

  factory ArticleModel.fromJson(Map<String, dynamic> json) {
    return ArticleModel(
      title: json['title'],
      author: json['author'],
      description: json['description'],
      url: json['url'],
      urlToImage: json['urlToImage'],
      content: json['content'],
    );
  }
}
