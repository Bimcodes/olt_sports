// =============================================================================
// USER ENTITY
// =============================================================================
// Domain entities represent core business objects.
// They are independent of any framework and contain only business logic.
// Entities should be immutable and contain no dependencies on external layers.
// =============================================================================

// User entity representing an authenticated user
//
// This is a domain entity - it contains only the data and logic
// that the business domain cares about. It's framework-agnostic
// and doesn't know about APIs, databases, or UI.

class News {
  /// Unique identifier for the post
  final int id;

  /// Date the post was published
  final String date;

  /// URL-friendly version of the title
  final String slug;

  /// URL to the full post
  final String link;

  /// Title of the post
  final String title;

  /// Full content of the post
  final String content;

  /// Short excerpt of the post
  final String excerpt;

  /// URL to the post's featured image
  final String image;

  /// ID of the author
  final int author;

  /// List of category IDs the post belongs to
  final List<dynamic> categories;

  const News({
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

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      other is News &&
          runtimeType == other.runtimeType &&
          id == other.id &&
          date == other.date &&
          slug == other.slug &&
          link == other.link &&
          title == other.title &&
          content == other.content &&
          excerpt == other.excerpt &&
          image == other.image &&
          author == other.author &&
          categories == other.categories;

  @override
  int get hashCode => Object.hash(
    id,
    date,
    slug,
    link,
    title,
    content,
    excerpt,
    image,
    author,
    categories,
  );

  @override
  String toString() =>
      'News(id: $id, date: $date, slug: $slug, link: $link, title: $title, content: $content, excerpt: $excerpt, image: $image, author: $author, categories: $categories ,)';
}
