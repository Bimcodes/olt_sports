// =============================================================================
// NEWS LIST SCREEN
// =============================================================================
//
// UPDATED: Now uses Riverpod to display REAL news data from API
//
// Changes from previous version:
// 1. Extends ConsumerWidget (not StatelessWidget)
// 2. Takes WidgetRef parameter in build method
// 3. Watches newsProvider to get current state
// 4. Shows different UI based on state (Loading, Success, Error, Empty)
// 5. Displays real news data instead of hardcoded
// 6. Supports pull-to-refresh
// 7. Supports pagination (load more at bottom)
//
// =============================================================================

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:olt_sports/features/news/presentation/application/news_providers.dart';
import 'package:olt_sports/features/news/presentation/application/news_uistate_new.dart';
import 'package:olt_sports/features/news/presentation/screens/news_article_screen.dart';

import '../../../../core/theme/theme.dart';
import '../../../../core/widgets/news_card.dart';

/// News List Screen - Displays all news articles
///
/// CHANGE 1: Now extends ConsumerWidget instead of StatelessWidget
/// - ConsumerWidget gives us access to Riverpod providers
/// - Allows us to watch and read providers
class NewsListScreen extends ConsumerWidget {
  final String title;
  final bool hasPreviousSection;

  const NewsListScreen({
    super.key,
    required this.title,
    this.hasPreviousSection = false,
  });

  @override
  // CHANGE 2: Build method now has WidgetRef parameter
  // WidgetRef is Riverpod's tool for watching/reading providers
  Widget build(BuildContext context, WidgetRef ref) {
    // CHANGE 3: Watch the newsProvider to get current state
    // This automatically rebuilds when state changes
    final state = ref.watch(newsProvider);

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      // CHANGE 4: Use RefreshIndicator for pull-to-refresh
      body: RefreshIndicator(
        onRefresh: () async {
          // Call onRefresh when user pulls down
          await ref.read(newsProvider.notifier).onRefresh();
        },
        child: _buildBody(context, ref, state),
      ),
    );
  }

  /// Build the body based on current state
  ///
  /// This method handles all 5 possible UIStates:
  /// - Initial: Show empty (or skeleton)
  /// - Loading: Show spinner
  /// - Success: Show articles grid
  /// - Error: Show error message with retry button
  /// - Empty: Show "no news found" message
  Widget _buildBody(BuildContext context, WidgetRef ref, NewsUIState state) {
    return switch (state) {
      // STATE 1: Initial - Nothing loaded yet
      NewsUIStateInitial() => _buildInitialState(context, ref),

      // STATE 2: Loading - Fetching data
      NewsUIStateLoading() => _buildLoadingState(),

      // STATE 3: Success - Data loaded, show articles
      NewsUIStateSuccess(:final newsList, :final hasMorePages) =>
        _buildSuccessState(context, ref, newsList, hasMorePages),

      // STATE 4: Error - Something went wrong
      NewsUIStateError(:final message, :final shouldRetry) => _buildErrorState(
        context,
        ref,
        message,
        shouldRetry,
      ),

      // STATE 5: Empty - API returned no articles
      NewsUIStateEmpty(:final message) => _buildEmptyState(message),
    };
  }

  /// Initial state - Show empty or prompt user to load
  Widget _buildInitialState(BuildContext context, WidgetRef ref) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Text('No news loaded yet'),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: () {
              ref.read(newsProvider.notifier).fetchNews();
            },
            child: const Text('Load News'),
          ),
        ],
      ),
    );
  }

  /// Loading state - Show spinner
  Widget _buildLoadingState() {
    return const Center(child: CircularProgressIndicator());
  }

  /// Success state - Show articles in grid
  ///
  /// This is the main UI - displays news articles that came from API
  Widget _buildSuccessState(
    BuildContext context,
    WidgetRef ref,
    List<dynamic> newsList,
    bool hasMorePages,
  ) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: AppTextStyles.authHeadline.copyWith(fontSize: 20),
            ),
            const SizedBox(height: 24),

            // Display articles grid
            _buildArticlesGrid(newsList),

            // If there are more pages, show "Load More" button
            if (hasMorePages) ...[
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    ref.read(newsProvider.notifier).onLoadMore();
                  },
                  child: const Text('Load More Articles'),
                ),
              ),
            ],

            const SizedBox(height: 48),
          ],
        ),
      ),
    );
  }

  /// Error state - Show error message with retry button
  Widget _buildErrorState(
    BuildContext context,
    WidgetRef ref,
    String message,
    bool shouldRetry,
  ) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Error icon
          const Icon(Icons.error_outline, color: Colors.red, size: 48),
          const SizedBox(height: 16),

          // Error message
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
          const SizedBox(height: 24),

          // Retry button (only if retryable)
          if (shouldRetry)
            ElevatedButton(
              onPressed: () {
                ref.read(newsProvider.notifier).onRetry();
              },
              child: const Text('Retry'),
            ),
        ],
      ),
    );
  }

  /// Empty state - Show "no news found" message
  Widget _buildEmptyState(String message) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Empty icon
          const Icon(Icons.newspaper, color: Colors.grey, size: 48),
          const SizedBox(height: 16),

          // Empty message
          Text(
            message,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  /// Build the articles grid from news list
  ///
  /// Takes a list of News entities and displays them in a 2-column grid
  Widget _buildArticlesGrid(List<dynamic> articles) {
    if (articles.isEmpty) {
      return const Center(child: Text('No articles to display'));
    }

    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        childAspectRatio: 0.70,
      ),
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final news = articles[index];

        return NewsCard(
          // Display REAL data from API instead of hardcoded
          title: news.title ?? 'No title',
          subtitle: news.excerpt ?? 'No excerpt',
          dateString: news.date ?? 'Unknown date',
          imagePath: news.image ?? 'assets/caf_president.png',
          onTap: () {
            // Navigate to article screen with real data
            Navigator.push(
              context,
              MaterialPageRoute(
                builder:
                    (_) => NewsArticleScreen(
                      title: news.title ?? 'No title',
                      dateString: news.date ?? 'Unknown date',

                      content: news.content,
                      excerpt: news.excerpt,
                      imagePath: news.image,
                    ),
              ),
            );
          },
        );
      },
    );
  }
}
