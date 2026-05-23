// =============================================================================
// NEWS VIEWMODEL
// =============================================================================
//
// The ViewModel is the "brain" between the UI (dumb view) and the Repository 
// (data source). It:
// 
// 1. Holds the current UIState
// 2. Listens to user actions (button taps, scrolling, refreshing)
// 3. Calls the Repository to fetch data
// 4. Transforms API responses into UIState objects
// 5. Handles errors gracefully
// 6. Manages pagination (loading more pages)
//
// Using Riverpod's StateNotifier:
// - StateNotifier<NewsUIState> means we manage a state of type NewsUIState
// - When we change 'state', UI automatically rebuilds
// - Repository is injected for testability
//
// =============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olt_sports/features/news/domain/repositories/news_repository.dart';
import 'package:olt_sports/features/news/data/models/news_request_dto.dart';
import 'news_uistate.dart';

/// The News ViewModel - Manages all news-related logic and state
///
/// Think of it as a mediator:
/// ```
/// View asks:  "Can you get me news?"
///      ↓
/// ViewModel: "Sure, let me call the Repository"
///      ↓
/// ViewModel: "Got the data! Let me convert it to UIState"
///      ↓
/// View sees: New UIState, rebuilds UI
/// ```
class NewsViewModel extends StateNotifier<NewsUIState> {
  // ═══════════════════════════════════════════════════════════════════════
  // DEPENDENCIES (Injected)
  // ═══════════════════════════════════════════════════════════════════════
  // The Repository is injected via constructor (dependency injection)
  // This makes it testable - we can inject a mock Repository in tests
  final NewsRepository _newsRepository;

  // ═══════════════════════════════════════════════════════════════════════
  // INTERNAL STATE (Not UIState)
  // ═══════════════════════════════════════════════════════════════════════
  // These track pagination, search filters, etc.
  // They're NOT emitted to UI - they're just helpers for the ViewModel

  /// Current request parameters (page, search term, category, etc)
  /// Tracks what we last requested, so we know how to do pagination
  late NewsRequestDto _currentRequest;

  /// All articles loaded so far (including previous pages)
  /// Used when pagination: we append new articles to this list
  late List<dynamic> _allLoadedArticles;

  // ═══════════════════════════════════════════════════════════════════════
  // CONSTRUCTOR
  // ═══════════════════════════════════════════════════════════════════════
  /// Creates a NewsViewModel with injected Repository
  ///
  /// Initial state is [NewsUIStateInitial] - we haven't fetched anything yet
  /// The Repository is passed in by Riverpod's dependency injection
  NewsViewModel(this._newsRepository)
      : super(const NewsUIStateInitial()) {
    // Initialize the request with default parameters
    _currentRequest = NewsRequestDto.empty();
    // Start with empty list for pagination
    _allLoadedArticles = [];

    // Auto-fetch news when ViewModel is created (optional)
    // Uncomment if you want news to load automatically when screen opens
    // fetchNews();
  }

  // ═══════════════════════════════════════════════════════════════════════
  // PUBLIC METHODS - Called by UI
  // ═══════════════════════════════════════════════════════════════════════

  /// Fetches the first page of news
  ///
  /// When is this called?
  /// - User just opened the news screen
  /// - User tapped "Load News" button
  /// - Initial load
  ///
  /// What happens?
  /// 1. Emit Loading state
  /// 2. Clear previous articles (new search)
  /// 3. Call repository.getNews()
  /// 4. Handle response (Success/Error/Empty)
  Future<void> fetchNews() async {
    try {
      // Step 1: Tell UI we're loading
      // This causes UI to show spinner while waiting
      state = const NewsUIStateLoading(
        isRefresh: false,     // Not a refresh (it's initial load)
        isPagination: false,  // Not pagination (starting fresh)
      );

      // Step 2: Reset pagination trackers
      _currentRequest = NewsRequestDto.empty(); // Reset to page 1
      _allLoadedArticles = [];                   // Clear previous articles

      // Step 3: Call Repository to fetch news
      // This will:
      // - Make HTTP request via Dio
      // - Parse JSON response
      // - Convert to News entities
      final newsList = await _newsRepository.getNews(_currentRequest);

      // Step 4: Handle the response
      if (newsList.isEmpty) {
        // API succeeded but returned no articles
        state = const NewsUIStateEmpty(
          message: 'No news articles found. Check back later!',
        );
      } else {
        // API succeeded and returned articles
        _allLoadedArticles = newsList;

        // Update state with data
        // hasMorePages = true if we got exactly 10 articles
        // (meaning there might be more on next page)
        state = NewsUIStateSuccess(
          newsList: newsList,
          hasMorePages: newsList.length ==
              _currentRequest.perPage, // Assuming 10 per page
          currentPage: _currentRequest.page,
        );
      }
    } catch (error) {
      // Step 5: Handle errors
      // Convert exception to user-friendly error state
      _handleError(error);
    }
  }

  /// Handles pull-to-refresh gesture
  ///
  /// When is this called?
  /// - User pulled down on the news list
  /// - User wants fresh data
  ///
  /// Difference from fetchNews():
  /// - We show refresh indicator (not full spinner)
  /// - We preserve the old data while loading new
  /// - We start from page 1 (reset pagination)
  Future<void> onRefresh() async {
    try {
      // Step 1: Tell UI we're refreshing
      // isRefresh=true means: show small indicator, keep old data visible
      state = const NewsUIStateLoading(
        isRefresh: true,      // Refresh (pull-down gesture)
        isPagination: false,  // Not pagination
      );

      // Step 2: Reset pagination (fetch from page 1)
      _currentRequest = NewsRequestDto.empty();
      _allLoadedArticles = [];

      // Step 3: Fetch fresh data from API
      final newsList = await _newsRepository.getNews(_currentRequest);

      // Step 4: Handle response
      if (newsList.isEmpty) {
        state = const NewsUIStateEmpty(
          message: 'No news articles available.',
        );
      } else {
        _allLoadedArticles = newsList;
        state = NewsUIStateSuccess(
          newsList: newsList,
          hasMorePages: newsList.length == _currentRequest.perPage,
          currentPage: _currentRequest.page,
        );
      }
    } catch (error) {
      _handleError(error);
    }
  }

  /// Loads the next page of articles (pagination)
  ///
  /// When is this called?
  /// - User scrolled to bottom of list
  /// - User wants to see more articles
  ///
  /// What's different?
  /// - We DON'T clear previous articles (append to them)
  /// - We increment the page number
  /// - We show loading indicator at bottom
  ///
  /// Example:
  /// - First load: pages 1-10 articles
  /// - User scrolls to bottom
  /// - onLoadMore() called
  /// - Fetch page 2: articles 11-20
  /// - Final list: articles 1-20 (all combined)
  Future<void> onLoadMore() async {
    // Only load more if:
    // 1. Current state is Success (we have data)
    // 2. hasMorePages = true (API said there's more)
    final currentState = state;
    if (currentState is! NewsUIStateSuccess) return;
    if (!currentState.hasMorePages) return;

    try {
      // Step 1: Show loading indicator at bottom (pagination loading)
      state = NewsUIStateLoading(
        isRefresh: false,     // Not a refresh
        isPagination: true,   // IS pagination - show indicator at bottom
      );

      // Step 2: Increment page number for next fetch
      // If we were on page 1, now get page 2
      _currentRequest = _currentRequest.copyWith(
        page: _currentRequest.page + 1,
      );

      // Step 3: Fetch next page
      final moreNews = await _newsRepository.getNews(_currentRequest);

      // Step 4: Handle response
      if (moreNews.isEmpty) {
        // No more articles available
        state = NewsUIStateSuccess(
          newsList: _allLoadedArticles,
          hasMorePages: false, // No more pages
          currentPage: _currentRequest.page,
        );
      } else {
        // Append new articles to existing list
        _allLoadedArticles.addAll(moreNews);

        // Check if there's another page after this
        bool hasMore = moreNews.length == _currentRequest.perPage;

        state = NewsUIStateSuccess(
          newsList: _allLoadedArticles,
          hasMorePages: hasMore,
          currentPage: _currentRequest.page,
        );
      }
    } catch (error) {
      _handleError(error);
    }
  }

  /// Search for news articles
  ///
  /// Example use case:
  /// - User types "football" in search box
  /// - onSearch("football") is called
  /// - Filters or searches for articles matching "football"
  ///
  /// You can expand this later with more filters!
  Future<void> onSearch(String query) async {
    // Don't search if query is empty
    if (query.isEmpty) {
      fetchNews(); // Reset to default fetch
      return;
    }

    try {
      // Show loading while searching
      state = const NewsUIStateLoading();

      // Create search request
      _currentRequest = NewsRequestDto.empty().copyWith(
        search: query,  // Add search term
        page: 1,        // Reset to page 1
      );
      _allLoadedArticles = [];

      // Call repository with search query
      final results = await _newsRepository.getNews(_currentRequest);

      if (results.isEmpty) {
        state = NewsUIStateEmpty(
          message: 'No articles found matching "$query"',
        );
      } else {
        _allLoadedArticles = results;
        state = NewsUIStateSuccess(
          newsList: results,
          hasMorePages: results.length == _currentRequest.perPage,
          currentPage: 1,
        );
      }
    } catch (error) {
      _handleError(error);
    }
  }

  /// Retry loading news after an error
  ///
  /// When is this called?
  /// - User tapped "Retry" button after an error
  /// - Network came back online
  ///
  /// What it does:
  /// - Same as fetchNews() - start fresh from page 1
  Future<void> onRetry() async {
    fetchNews();
  }

  // ═══════════════════════════════════════════════════════════════════════
  // PRIVATE HELPER METHODS
  // ═══════════════════════════════════════════════════════════════════════

  /// Converts exceptions to user-friendly error states
  ///
  /// This is called whenever ANY operation fails
  /// It determines:
  /// - What message to show user
  /// - Whether they can retry
  /// - What kind of error it was
  ///
  /// Example errors we might get:
  /// - Network error (timeout, no internet) → shouldRetry: true
  /// - Server error (500) → shouldRetry: true
  /// - Not found (404) → shouldRetry: false
  /// - Unknown error → shouldRetry: true (be generous)
  void _handleError(dynamic error) {
    // Determine error message based on exception type
    String userFriendlyMessage = 'An unexpected error occurred';

    // Try to extract meaningful error details
    if (error is Exception) {
      final errorString = error.toString();

      if (errorString.contains('SocketException') ||
          errorString.contains('Connection refused')) {
        userFriendlyMessage =
            'No internet connection. Please check your network.';
      } else if (errorString.contains('TimeoutException')) {
        userFriendlyMessage =
            'Request took too long. Please check your connection.';
      } else if (errorString.contains('404')) {
        userFriendlyMessage = 'News not found.';
      } else if (errorString.contains('500')) {
        userFriendlyMessage = 'Server error. Please try again later.';
      } else {
        userFriendlyMessage = errorString;
      }
    }

    // Emit error state
    state = NewsUIStateError(
      message: userFriendlyMessage,
      exception: error is Exception ? error : null,
      shouldRetry: true, // Most errors are retryable
    );
  }

  // ═══════════════════════════════════════════════════════════════════════
  // OPTIONAL: Add custom getters for convenience
  // ═══════════════════════════════════════════════════════════════════════

  /// Returns current page number (useful for UI display)
  int get currentPage => _currentRequest.page;

  /// Returns whether more articles are available
  bool get hasMorePages {
    final currentState = state;
    if (currentState is NewsUIStateSuccess) {
      return currentState.hasMorePages;
    }
    return false;
  }

  /// Returns total articles loaded so far
  int get totalArticlesLoaded => _allLoadedArticles.length;
}
