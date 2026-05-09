// =============================================================================
// NEWS REPOSITORY INTERFACE
// =============================================================================
// Repository interfaces define contracts between the domain and data layers.
// The domain layer depends on this abstraction, not on concrete implementations.
// This follows the Dependency Inversion Principle (DIP).
// =============================================================================



import '../../data/models/news_request_dto.dart';
import '../entities/news.dart';

/// Abstract repository for news operations
///
/// This interface defines what news operations are available
/// without specifying HOW they are implemented. The actual implementation
/// (API calls, local storage, etc.) is in the data layer.
///
/// Benefits of using an abstract repository:
/// 1. Testability - Easy to mock for unit tests
/// 2. Flexibility - Can swap implementations (API, mock, cache)
/// 3. Separation - Domain layer doesn't know about data sources


abstract class NewsRepository {
  Future<List<News>> getNews(NewsRequestDto requestDto);
}