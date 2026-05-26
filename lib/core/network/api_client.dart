// ignore_for_file: unused_element, avoid_print

import 'dart:convert';
import 'dart:math';

import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../error/exceptions.dart';

/// Provider for the Dio HTTP client
///
/// This creates a single instance of Dio that can be shared across the app.
/// Using Riverpod for dependency injection makes testing easier.
final dioProvider = Provider<Dio>((ref) {
  return DioClient.createDio();
});

class DioClient {
  static const String baseUrl = 'https://oltsport.com/wp-json/wp/v2';

  static Dio createDio() {
    final dio = Dio(
      BaseOptions(
        baseUrl: baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
        },
      ),
    );
    dio.interceptors.addAll([
      _LoggingInterceptor(),
      // Add more interceptors as needed:
      // _AuthInterceptor(),
      // _RetryInterceptor(),
    ]);

    return dio;
  }
}

class _LoggingInterceptor extends Interceptor {
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    print('📤 REQUEST: ${options.method} ${options.path}');
    print('   Headers: ${options.headers}');
    if (options.data != null) {
      print('   Body: ${options.data}');
    }
    handler.next(options);
  }

  @override
  void onResponse(Response response, ResponseInterceptorHandler handler) {
    print(
      '📥 RESPONSE: ${response.statusCode} ${response.requestOptions.path}',
    );
    if (response.data != null) {
      print(
        '   Data: ${const JsonEncoder.withIndent('  ').convert(response.data)}',
      );
    }
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    print('❌ ERROR: ${err.type} ${err.message}');
    handler.next(err);
  }
}

/// Extension to convert DioException to ApiException
///
/// This helper converts Dio's exceptions to our app-specific exceptions,
/// maintaining a clean separation between network layer and business logic.
extension DioExceptionX on DioException {
  ApiException toApiException() {
    switch (type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.connectionError:
        return const NetworkException();

      case DioExceptionType.badResponse:
        final statusCode = response?.statusCode;
        final message = _extractErrorMessage(response);

        return switch (statusCode ?? 400) {
          400 => BadRequestException(message: message),
          401 => const UnauthorizedException(),
          >= 500 && < 600 => ServerException(
            message: message,
            statusCode: statusCode,
          ),
          _ => ServerException(message: message, statusCode: statusCode),
        };

      case DioExceptionType.cancel:
        return const ServerException(message: 'Request cancelled');

      default:
        return ServerException(message: message ?? 'Unknown error');
    }
  }

  /// Extracts error message from API response
  String _extractErrorMessage(Response? response) {
    try {
      final data = response?.data;
      if (data is Map<String, dynamic>) {
        return data['message'] as String? ??
            data['error'] as String? ??
            'An error occurred';
      }
      return 'An error occurred';
    } catch (_) {
      return 'An error occurred';
    }
  }
}

class _AuthInterceptor extends Interceptor {
  final String? token;
  _AuthInterceptor(this.token);
  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) {
    if (token != null && token!.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
      print('🔐 Added Authorization header: Bearer $token');
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      print('Session expired. Please log in again.');
    }
    handler.next(err);
  }
}

class _RetryInterceptor extends Interceptor {
  final Dio dio;
  final int maxRetries;
  final Duration retryDelay;

  _RetryInterceptor({
    required this.dio,
    // ignore: unused_element_parameter
    this.maxRetries = 3,
    // ignore: unused_element_parameter
    this.retryDelay = const Duration(seconds: 2),
  });
  bool _shouldRetry(DioException err) {
    if (err.type == DioExceptionType.connectionTimeout ||
        err.type == DioExceptionType.sendTimeout ||
        err.type == DioExceptionType.receiveTimeout) {
      return true;
    }
    final status = err.response?.statusCode ?? 0;
    return status >= 500 && status < 600;
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final options = err.requestOptions;
    final method = options.method.toUpperCase();

    // Only retry if it is safe i.e it is a get request or head or options. If it is none of the above don't retry just pass the error as next
    if (!(method == 'GET' || method == 'HEAD' || method == 'OPTIONS')) {
      handler.next(err);
      return;
    }
    if (!_shouldRetry(err)) {
      handler.next(err);
      return;
    }
    final int retryCount = (options.extra['retryCount'] as int?) ?? 0;
    if (retryCount >= maxRetries) {
      handler.next(err);
      return;
    }

    final nextEntry = retryCount + 1;
    options.extra['retry_count'] = nextEntry;

    // exponential backoff: baseDelay * 2^(retryCount)
    final waitMs = (retryDelay.inMilliseconds * pow(2, retryCount)).toInt();
    await Future.delayed(Duration(milliseconds: waitMs));

    try {
      // Re-send the original request
      final response = await dio.fetch(options);
      handler.resolve(response);
    } catch (e) {
      // If fetch throws, pass original error along (or you could recurse)
      handler.next(err);
    }
  }
}

class _CacheInterceptor extends Interceptor {}

class _RefreshTokenInterceptor extends Interceptor {}
