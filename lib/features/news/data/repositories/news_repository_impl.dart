// =============================================================================
// NEWS REPOSITORY IMPLEMENTATION
// =============================================================================
// Repository implementations bridge the domain and data layers.
// They handle data source calls and convert DTOs to domain entities.
// =============================================================================

import 'package:olt_sports/features/news/data/datasource/news_remote_datasource.dart';

import '../../domain/entities/news.dart';
import '../../domain/repositories/news_repository.dart';
import '../models/news_request_dto.dart';

/// Implementation of [NewsRepository]
/// 
/// This class:
/// 1. Calls the data source to fetch/store data
/// 2. Converts data models to domain entities
/// 3. Propagates errors to the ViewModel layer
/// 
/// Data Flow:
/// ```
/// ViewModel calls Repository
///     ↓
/// Repository calls DataSource
///     ↓
/// DataSource makes API call, returns Model
///     ↓
/// Repository converts Model to Entity
///     ↓
/// Entity returned to ViewModel
/// ```
/// 

class NewsRepositoryImpl implements NewsRepository {
  final NewsRemoteDatasource _remoteDatasource;

  NewsRepositoryImpl(this._remoteDatasource);

  @override
  Future<List<News>> getNews(NewsRequestDto requestDto) async {
    final newsModel = await _remoteDatasource.fetchNews(requestDto);
    return newsModel.map((dto) => dto.toEntity()).toList();
  }

}