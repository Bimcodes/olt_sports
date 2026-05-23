// =============================================================================
// NEWS UI STATE
// =============================================================================
// 
// UIState represents all possible states the UI can be in when displaying news.
// Using sealed classes (or abstract class with subclasses) ensures type safety
// and forces us to handle all cases when building the UI.
//
// Pattern: State Management Through Immutable State Objects
// ─────────────────────────────────────────────────────────
// Instead of: bool isLoading; String? error; List<News>? news;
// We use explicit states:
//   • Initial    - No action taken yet
//   • Loading    - Fetching news from API
//   • Success    - News loaded, display them
//   • Error      - API failed, show error message
//   • Empty      - API succeeded but no news found
//
// Why immutable? Because once we emit a state, it shouldn't change.
// If data changes, we emit a NEW state object.
// =============================================================================

import 'package:olt_sports/features/news/domain/entities/news.dart';

/// Sealed class for type-safe state management.
/// 
/// In Dart, a sealed class forces all subclasses to be defined in the same file,
/// ensuring complete pattern matching when handling states in the UI.
/// 
/// Using `sealed` (Dart 3.0+) is similar to Kotlin's sealed classes.
/// If your project doesn't support sealed, use abstract class instead:
/// ```dart
/// abstract class NewsUIState {
///   const NewsUIState();
/// }
/// ```
sealed class NewsUIState {
  const NewsUIState();
}

// ─────────────────────────────────────────────────────────────────────────
// STATE 1: INITIAL
// ─────────────────────────────────────────────────────────────────────────
/// Initial state - No news fetch has been attempted yet.
/// 
/// When is this emitted?
/// - ViewModel created and hasn't called repository yet
/// - User just opened the app/news screen for the first time
/// 
/// What should the UI do?
/// - Show a placeholder or loading skeleton (optional)
/// - Or just show an empty container
class NewsUIStateInitial extends NewsUIState {
  const NewsUIStateInitial();
}

// ─────────────────────────────────────────────────────────────────────────
// STATE 2: LOADING
// ─────────────────────────────────────────────────────────────────────────
/// Loading state - News are being fetched from the API.
/// 
/// When is this emitted?
/// - ViewModel called repository.getNews() and waiting for response
/// - User pulled to refresh
/// - User scrolled to load more pages
/// 
/// What should the UI do?
/// - Show CircularProgressIndicator
/// - Show shimmer/skeleton loaders
/// - Disable user interactions
/// 
/// Note: We have two booleans:
/// - [isRefresh] = true when pulling to refresh (preserve current list)
/// - [isRefresh] = false when initial load (clear current list)
/// This helps us decide whether to show a shimmer or a refresh indicator.
class NewsUIStateLoading extends NewsUIState {
  /// If true, user is refreshing existing data (show refresh indicator)
  /// If false, initial load or pagination (show full loading screen)
  final bool isRefresh;
  final bool isPagination;

  const NewsUIStateLoading({
    this.isRefresh = false,
    this.isPagination = false,
  });
}

// ─────────────────────────────────────────────────────────────────────────
// STATE 3: SUCCESS
// ─────────────────────────────────────────────────────────────────────────
/// Success state - News data successfully fetched and ready to display.
/// 
/// When is this emitted?
/// - API returned 200 OK with news list
/// - Repository converted DTOs to domain News entities
/// - ViewModel successfully processes the data
/// 
/// What should the UI do?
/// - Display the [newsList]
/// - Enable pull-to-refresh
/// - Enable pagination/load more
/// 
/// Key fields:
/// - [newsList] - Immutable list of news articles
/// - [hasMorePages] - If true, more news available (pagination)
/// - [currentPage] - Current page number (for pagination)
class NewsUIStateSuccess extends NewsUIState {
  /// The list of news articles to display
  final List<News> newsList;

  /// Whether there are more pages available (for pagination)
  final bool hasMorePages;

  /// Current page number (for showing "Page X of Y" or analytics)
  final int currentPage;

  const NewsUIStateSuccess({
    required this.newsList,
    this.hasMorePages = false,
    this.currentPage = 1,
  });

  /// Helper to check if list is empty
  bool get isEmpty => newsList.isEmpty;

  /// Helper to get first news article (for featured article, etc)
  News? get firstNews => newsList.isNotEmpty ? newsList.first : null;
}

// ─────────────────────────────────────────────────────────────────────────
// STATE 4: ERROR
// ─────────────────────────────────────────────────────────────────────────
/// Error state - API call failed or unexpected error occurred.
/// 
/// When is this emitted?
/// - Network error (no internet, timeout)
/// - API returned error status code (500, 404, etc)
/// - JSON parsing failed
/// - Any other exception during data fetch
/// 
/// What should the UI do?
/// - Show error message to user
/// - Provide "Retry" button
/// - Log error for debugging
/// 
/// Key fields:
/// - [message] - User-friendly error message
/// - [exception] - Original exception (for logging)
/// - [shouldRetry] - Can we retry? (false for 404, true for network error)
class NewsUIStateError extends NewsUIState {
  /// User-friendly error message to display in UI
  /// Example: "Failed to load news. Please check your internet connection."
  final String message;

  /// Original exception (optional, for debugging)
  final Exception? exception;

  /// Whether the user can retry this action
  /// false = permanent error (404, 403)
  /// true = temporary error (timeout, network)
  final bool shouldRetry;

  const NewsUIStateError({
    required this.message,
    this.exception,
    this.shouldRetry = true,
  });
}

// ─────────────────────────────────────────────────────────────────────────
// STATE 5: EMPTY
// ─────────────────────────────────────────────────────────────────────────
/// Empty state - API succeeded but returned empty list.
/// 
/// When is this emitted?
/// - API returned 200 OK but with empty array []
/// - User searched for news that doesn't exist
/// - No news in selected category
/// 
/// What should the UI do?
/// - Show "No news found" message
/// - Show empty state illustration
/// - Provide action to retry/go back
/// 
/// Note: This is different from Error!
/// - Error = something went wrong
/// - Empty = success but no data
class NewsUIStateEmpty extends NewsUIState {
  /// Message to display when no news available
  final String message;

  const NewsUIStateEmpty({
    this.message = 'No news articles found.',
  });
}

// =============================================================================
// EXTENSION METHODS (Optional but helpful)
// =============================================================================
/// Extension to easily check state type
extension NewsUIStateExt on NewsUIState {
  /// Returns true if current state is loading
  bool get isLoading => this is NewsUIStateLoading;

  /// Returns true if current state is success
  bool get isSuccess => this is NewsUIStateSuccess;

  /// Returns true if current state is error
  bool get isError => this is NewsUIStateError;

  /// Returns true if current state is empty
  bool get isEmpty => this is NewsUIStateEmpty;

  /// Returns true if current state is initial
  bool get isInitial => this is NewsUIStateInitial;

  /// Get news list if state is success, otherwise empty list
  List<News> get newsList =>
      this is NewsUIStateSuccess ? (this as NewsUIStateSuccess).newsList : [];

  /// Get error message if state is error, otherwise empty string
  String get errorMessage =>
      this is NewsUIStateError ? (this as NewsUIStateError).message : '';
}
