// =============================================================================
// NEWS REMOTE DATA SOURCE
// =============================================================================
// Data sources handle the actual data retrieval/storage.
// Remote data sources make API calls using Dio.
// They throw exceptions on errors (caught by ViewModel).
// =============================================================================

import 'package:dio/dio.dart';
import 'package:olt_sports/features/news/data/models/news_request_dto.dart';
import 'package:olt_sports/features/news/data/models/news_response_dto.dart';

import '../../../../core/network/api_client.dart';

/// Abstract interface for auth data source
///
/// Using an interface allows us to:
/// 1. Easily swap implementations (real API vs mock)
/// 2. Create test doubles for unit testing
/// 3. Follow Dependency Inversion Principle
abstract class NewsRemoteDatasource {
  Future<List<NewsResponseDto>> fetchNews(NewsRequestDto request);
}

/// Implementation of [NewsRemoteDatasource] that makes real API calls
///
/// This class:
/// 1. Makes HTTP requests using Dio
/// 2. Parses JSON responses into models
/// 3. Throws appropriate exceptions on errors

class NewsRemoteDatasourceImpl implements NewsRemoteDatasource {
  // final Dio _dio;

  /// Creates the data source with a Dio client
  ///
  /// The Dio client is injected for testability.
  NewsRemoteDatasourceImpl([Dio? dio]) ;

  @override
  Future<List<NewsResponseDto>> fetchNews(NewsRequestDto request) async {
    try {
      final response = await dio.get(
        '/posts',
        queryParameters: request.toJson(),
      );
      if (response.statusCode == 200) {
        final data = response.data as List<dynamic>;
        return data
            .map(
              (json) => NewsResponseDto.fromJson(json as Map<String, dynamic>),
            )
            .toList();
      } else {
        throw Exception('Failed to load news: ${response.statusCode}');
      }
    } on DioException catch (e) {
      throw Exception('Network error: ${e.message}');
    } catch (e) {
      throw Exception('Unexpected error: $e');
    }
  }
}
