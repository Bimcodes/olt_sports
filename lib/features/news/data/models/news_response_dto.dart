// =============================================================================
// NEWS RESPONSE DTO
// =============================================================================
// Response DTO from the news API endpoint.
// Contains news data returned after successful API call.
// =============================================================================

import '../../domain/entities/news.dart';

class NewsResponseDto {
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

  const NewsResponseDto({
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

  /// Creates an empty response (initial state)
  factory NewsResponseDto.empty() {
    return const NewsResponseDto(
      id: 0,
      date: '',
      slug: '',
      link: '',
      title: '',
      content: '',
      excerpt: '',
      image: '',
      author: 0,
      categories: [],
    );
  }

  /// Creates from JSON
  factory NewsResponseDto.fromJson(Map<String, dynamic> json) {
    // final data = json['data'] as Map<String, dynamic>?;
    return NewsResponseDto(
      id: json['id'] ?? 0,
      date: json['date'] ?? '',
      slug: json['slug'] ?? '',
      link: json['link'] ?? '',

      title: json['title']?['rendered'] ?? '',

      content: json['content']?['rendered'] ?? '',

      excerpt: json['excerpt']?['rendered'] ?? '',

      image:
          json['_embedded']?['wp:featuredmedia'] != null
              ? json['_embedded']['wp:featuredmedia'][0]['source_url'] ?? ''
              : '',

      author: json['author'] ?? 0,

      categories: List<int>.from(json['categories'] ?? const []),
    );
  }

  /// Converts to JSON
  Map<String, dynamic> toJson() {
    return {
      'data': {
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
      },
    };
  }

  /// Converts to domain News entity
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

  /// Creates a copy with updated values
  NewsResponseDto copyWith({
    int? id,
    String? date,
    String? slug,
    String? link,
    String? title,
    String? content,
    String? excerpt,
    String? image,
    int? author,
    List<int>? categories,
  }) {
    return NewsResponseDto(
      id: id ?? this.id,
      date: date ?? this.date,
      slug: slug ?? this.slug,
      link: link ?? this.link,
      title: title ?? this.title,
      content: content ?? this.content,
      excerpt: excerpt ?? this.excerpt,
      image: image ?? this.image,
      author: author ?? this.author,
      categories: categories ?? this.categories,
    );
  }

  /// Check if response has valid user data
  bool get hasUser => id > 0 && title.isNotEmpty;
}
