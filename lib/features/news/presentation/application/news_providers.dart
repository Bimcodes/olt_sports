// =============================================================================
// NEWS RIVERPOD PROVIDERS
// =============================================================================
//
// Providers are "recipe cards" that tell Riverpod how to create and manage
// instances of our classes (Datasource, Repository, ViewModel).
//
// Think of this file as a factory that creates objects on demand:
// - Someone asks for Datasource? → Provider creates it
// - Someone asks for Repository? → Provider creates it with Datasource
// - Someone asks for ViewModel? → Provider creates it with Repository
// - UI watches ViewModel? → Provider keeps it alive and updated
//
// DEPENDENCY CHAIN:
// Datasource ← Repository ← ViewModel ← UI
//
// Each level depends on the level below it.
// Riverpod manages all the wiring automatically!
//
// =============================================================================

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';
import '../../data/datasource/news_remote_datasource.dart';
import '../../data/repositories/news_repository_impl.dart';
import '../../domain/repositories/news_repository.dart';
import '../../../core/network/api_client.dart';
import 'news_viewmodel.dart';
import 'news_uistate.dart';

// ═══════════════════════════════════════════════════════════════════════════
// LEVEL 1: NEWS REMOTE DATASOURCE PROVIDER
// ═══════════════════════════════════════════════════════════════════════════
//
// PURPOSE: Create the HTTP client (Dio) and the datasource
//
// ANALOGY: This is the KITCHEN in our restaurant
// - It has all the tools (pans, knives, stove)
// - It can make food (fetch data from API)
//
// WHAT THIS PROVIDER DOES:
// 1. Creates a Dio instance (HTTP client)
// 2. Creates NewsRemoteDatasourceImpl with the Dio instance
// 3. Returns the datasource to whoever needs it
// 4. Keeps the same instance (doesn't recreate every time)
//
// When someone calls:
//   ref.watch(newsRemoteDatasourceProvider)
// They get: NewsRemoteDatasource instance ready to make API calls
//

final newsRemoteDatasourceProvider = Provider<NewsRemoteDatasource>((ref) {
  // Step 1: Create a Dio instance (HTTP client)
  // Dio is what actually makes requests to the API
  final dio = DioClient.createDio();

  // Step 2: Create the datasource with the Dio instance
  // NewsRemoteDatasourceImpl knows HOW to call the API using Dio
  final datasource = NewsRemoteDatasourceImpl(dio);

  // Step 3: Return it
  // Now anyone who needs NewsRemoteDatasource gets this instance
  return datasource;
});

// ═══════════════════════════════════════════════════════════════════════════
// LEVEL 2: NEWS REPOSITORY PROVIDER
// ═══════════════════════════════════════════════════════════════════════════
//
// PURPOSE: Create the repository, which uses the datasource
//
// ANALOGY: This is the MANAGER in our restaurant
// - The manager uses the kitchen to prepare food
// - The manager takes orders (from UI)
// - The manager tells the kitchen what to do
//
// WHAT THIS PROVIDER DOES:
// 1. Gets the datasource from Level 1 (newsRemoteDatasourceProvider)
// 2. Creates NewsRepositoryImpl with that datasource
// 3. Returns the repository
//
// KEY CONCEPT: ref.watch()
// When you write: final datasource = ref.watch(newsRemoteDatasourceProvider)
// You're saying: "Riverpod, give me the datasource from Level 1"
// If that datasource ever changes, this provider updates too!
//
// When someone calls:
//   ref.watch(newsRepositoryProvider)
// They get: NewsRepository instance ready to fetch and transform data
//

final newsRepositoryProvider = Provider<NewsRepository>((ref) {
  // Step 1: Ask Riverpod for the datasource from Level 1
  // This is called "watching" a dependency
  final datasource = ref.watch(newsRemoteDatasourceProvider);

  // Step 2: Create the repository with the datasource
  // NewsRepositoryImpl takes the datasource and:
  // - Calls it to fetch raw data
  // - Converts DTOs to domain entities
  // - Returns clean data to ViewModel
  final repository = NewsRepositoryImpl(datasource);

  // Step 3: Return it
  // Now anyone who needs NewsRepository gets this instance
  return repository;
});

// ═══════════════════════════════════════════════════════════════════════════
// LEVEL 3: NEWS VIEWMODEL PROVIDER (StateNotifierProvider)
// ═══════════════════════════════════════════════════════════════════════════
//
// PURPOSE: Create the ViewModel and manage its state
//
// ANALOGY: This is the DIRECTOR in our restaurant
// - Takes orders from customers (user actions from UI)
// - Tells the manager what to do
// - Manages the show (state changes)
// - Makes sure everything runs smoothly
//
// WHAT THIS PROVIDER DOES:
// 1. Gets the repository from Level 2 (newsRepositoryProvider)
// 2. Creates NewsViewModel with that repository
// 3. Returns the ViewModel
// 4. **SPECIAL**: Watches for state changes and notifies UI
//
// WHY StateNotifierProvider (not just Provider)?
// - Regular Provider: Returns a value that doesn't change
// - StateNotifierProvider: Returns something that CAN change (our state!)
//
// Think of it like:
// - Provider = A book (read-only)
// - StateNotifierProvider = A notebook (you can write new pages)
//
// SYNTAX BREAKDOWN:
// StateNotifierProvider<Type1, Type2>
//                      ↓      ↓
//                    Notifier State
//
// Type1 (NewsViewModel) = The thing that CHANGES state
// Type2 (NewsUIState) = The state that GETS CHANGED
//
// When someone calls:
//   ref.watch(newsProvider)
// They get: NewsUIState (current UI state)
//
// When someone calls:
//   ref.read(newsProvider.notifier)
// They get: NewsViewModel (the controller that changes state)
//

final newsProvider =
    StateNotifierProvider<NewsViewModel, NewsUIState>((ref) {
  // Step 1: Ask Riverpod for the repository from Level 2
  final repository = ref.watch(newsRepositoryProvider);

  // Step 2: Create the ViewModel with the repository
  // NewsViewModel receives the repository and:
  // - Holds the current UIState
  // - Has methods like fetchNews(), onRefresh(), etc.
  // - Calls repository when user interacts with UI
  // - Emits new states (Loading → Success/Error/Empty)
  final viewModel = NewsViewModel(repository);

  // Step 3: Return it
  // Now the UI can:
  // - Watch this provider to get current state
  // - Read the notifier to call methods (fetch, refresh, etc.)
  return viewModel;
});

// ═══════════════════════════════════════════════════════════════════════════
// HOW TO USE THESE PROVIDERS IN YOUR UI
// ═══════════════════════════════════════════════════════════════════════════
//
// The following examples show how to use these providers in your widgets.
// You'll implement these in Step 4 when we connect the UI.
//
// ───────────────────────────────────────────────────────────────────────────
// Example 1: WATCH state in UI (automatic rebuild when state changes)
// ───────────────────────────────────────────────────────────────────────────
//
// class NewsListScreen extends ConsumerWidget {
//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     // Watch the provider - UI rebuilds whenever state changes
//     final state = ref.watch(newsProvider);
//     
//     return state when {
//       NewsUIStateLoading() => CircularProgressIndicator(),
//       NewsUIStateSuccess(:final newsList) => ListView(...),
//       NewsUIStateError(:final message) => Text(message),
//       ...
//     };
//   }
// }
//
// ───────────────────────────────────────────────────────────────────────────
// Example 2: READ notifier to call methods (doesn't rebuild)
// ───────────────────────────────────────────────────────────────────────────
//
// onPressed: () {
//   // Read (not watch) the notifier to call methods
//   ref.read(newsProvider.notifier).fetchNews();
// }
//
// ───────────────────────────────────────────────────────────────────────────
// Example 3: REFRESH provider (invalidate and recreate)
// ───────────────────────────────────────────────────────────────────────────
//
// onPressed: () {
//   // This invalidates the provider and creates a new instance
//   ref.refresh(newsProvider);
// }
//
// ═══════════════════════════════════════════════════════════════════════════

// ═══════════════════════════════════════════════════════════════════════════
// SUMMARY: THE PROVIDER PYRAMID
// ═══════════════════════════════════════════════════════════════════════════
//
//                      LEVEL 3
//                   ┌─────────────┐
//                   │ newsProvider│  ← UI Watches This
//                   │ (ViewModel) │    ref.watch(newsProvider)
//                   └──────┬──────┘
//                          │ needs
//                          ↓
//                      LEVEL 2
//                   ┌─────────────┐
//                   │ Repository  │
//                   │  Provider   │
//                   └──────┬──────┘
//                          │ needs
//                          ↓
//                      LEVEL 1
//                   ┌─────────────┐
//                   │ Datasource  │
//                   │  Provider   │
//                   └─────────────┘
//
// Each level is created automatically by Riverpod.
// Riverpod wires them together: Datasource → Repository → ViewModel → UI
//
// ═══════════════════════════════════════════════════════════════════════════
