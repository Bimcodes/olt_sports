// =============================================================================
// News REQUEST DTO
// =============================================================================
// Data Transfer Object for news request parameters.
// =============================================================================

// DTO for news request containing relevant parameters

class NewsRequestDto {
  final int page;
  final int perPage;
  final String? search;
  final int? category;
  final bool embed;
  final String order;
  final String orderBy;

  const NewsRequestDto({
    this.page = 1,
    this.perPage = 10,
    this.search,
    this.category,
    this.embed = true,
    this.order = 'desc',
    this.orderBy = 'date',
  });

  /// Creates an empty request (initial state)
  factory NewsRequestDto.empty() {
    return const NewsRequestDto(
      page: 1,
      perPage: 10,
      search: null,
      category: null,
      embed: true,
      order: 'desc',
      orderBy: 'date',
    );
  }

  /// Converts to JSON for API request
  Map<String, dynamic> toJson() {
    return {
      'page': page,
      'per_page': perPage,
      if (search != null) 'search': search,
      if (category != null) 'categories': category,
      if (embed) '_embed': true,

      'order': order,
      'orderby': orderBy,
    };
  }

  /// Creates a copy with updated values
  NewsRequestDto copyWith({
    int? page,
    int? perPage,
    String? search,
    int? category,
    bool? embed,
    String? order,
    String? orderBy,
  }) {
    return NewsRequestDto(
      page: page ?? this.page,
      perPage: perPage ?? this.perPage,
      search: search ?? this.search,
      category: category ?? this.category,
      embed: embed ?? this.embed,
      order: order ?? this.order,
      orderBy: orderBy ?? this.orderBy,
    );
  }

  /// validates the request
  bool get isValid => page > 0 && perPage > 0;
}
