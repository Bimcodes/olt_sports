import 'package:olt_sports/features/news/domain/entities/news.dart';

class NewsModel {
  final int id;
  final String date;
  final String slug;
  final String link;
  final String title;
  final String content;
  final String excerpt;
  final String image;
  final int author;
  final List<int> categories;

  const NewsModel({
    required this.id,
    required this.date,
    required this.slug,
    required this.link,
    required this.title,
    required this.content,
    required this.excerpt,
    required this.image,
    required this.author,
    required this.categories,
  });

  /// Creates a NewsModel from JSON
  factory NewsModel.fromJson(Map<String, dynamic> json) {
    return NewsModel(
      id: json['id'] as int,
      date: json['date'] as String,
      slug: json['slug'] as String,
      link: json['link'] as String,
      title: json['title'] as String,
      content: json['content'] as String,
      excerpt: json['excerpt'] as String,
      image: json['image'] as String,
      author: json['author'] as int,
      categories: List<int>.from(json['categories'] ?? const []),
    );
  }

  /// Converts this model to JSON
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'date': date,
      'slug': slug,
      'link': link,
      'title': title,
      'content': content,
      'excerpt': excerpt,
      'image': image,
      'author': author,
      'categories': categories,
    };
  }

  /// Converts this model to a domain [News] entity
  News toEntity() {
    return News(
      id: id,
      date: date,
      slug: slug,
      link: link,
      title: title,
      content: content,
      excerpt: excerpt,
      image: image,
      author: author,
      categories: categories,
    );
  }

  /// Creates a NewsModel from a domain [News] entity
  factory NewsModel.fromEntity(News news) {
    return NewsModel(
      id: news.id,
      date: news.date,
      slug: news.slug,
      link: news.link,
      title: news.title,
      content: news.content,
      excerpt: news.excerpt,
      image: news.image,
      author: news.author,
      categories: news.categories,
    );
  }
}
