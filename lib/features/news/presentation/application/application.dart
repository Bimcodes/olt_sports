// =============================================================================
// NEWS PROVIDERS
// =============================================================================
// This file defines all Riverpod providers for the news feature.
// Providers are the backbone of dependency injection in Riverpod.
// They create and provide instances to the widget tree.
// =============================================================================

// =============================================================================
// DEPENDENCY INJECTION HIERARCHY
// =============================================================================
// Providers are organized in a dependency hierarchy:
//
// dioProvider (core)
//     ↓
// newsRemoteDataSourceProvider
//     ↓
// newsRepositoryProvider
//     ↓
// newsNotifierProvider (ViewModel)
//     ↓
// UI Widgets (via ref.watch)
// =============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import 'package:olt_sports/features/news/data/datasource/news_remote_datasource.dart';
import 'package:olt_sports/features/news/data/repositories/news_repository_impl.dart';
import 'package:olt_sports/features/news/domain/repositories/news_repository.dart';
import 'package:olt_sports/features/news/presentation/application/news_uistate_new.dart';
import 'package:olt_sports/features/news/presentation/application/news_viewmodel.dart';

import '../../../../core/network/api_client.dart';

/// Provider for the news remote data source
///
/// Creates [NewsRemoteDatasourceImpl] with the Dio client.

final newsRemoteDataSourceProvider = Provider<NewsRemoteDatasource>((ref) {
  final dio = ref.watch(dioProvider);
  return NewsRemoteDatasourceImpl(dio);
});

/// Provider for the news repository
///
/// Creates [NewsRepositoryImpl] with the data source.
final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  final dataSource = ref.watch(newsRemoteDataSourceProvider);
  return NewsRepositoryImpl(dataSource);
});

/// StateNotifierProvider for the news ViewModel
///
/// This is the main provider that the UI interacts with.
/// It provides both:
/// - The current state (via ref.watch(newsNotifierProvider))
/// - The notifier for actions (via ref.read(newsNotifierProvider.notifier))
///
/// Example usage in UI:
/// ```dart
/// // Watch state
/// final state = ref.watch(newsNotifierProvider);
///
/// // Check state
/// if (state.currentState.isLoading) { ... }
/// if (state.currentState.isSuccess) { ... }
///
/// // Call action
/// ref.read(newsNotifierProvider.notifier).loadNews();
/// ```
///
final newsNotifierProvider = StateNotifierProvider<NewsViewModel, NewsUIState>((
  ref,
) {
  final repository = ref.watch(newsRepositoryProvider);
  return NewsViewModel(repository);
});
