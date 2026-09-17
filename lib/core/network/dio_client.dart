import 'package:dio/dio.dart';

import '../error/exceptions.dart';
import 'interceptors/logging_interceptor.dart';
import 'interceptors/retry_interceptor.dart';

/// Client HTTP Dio configuré LUXORA.
///
/// - Timeouts généreux (luxe, pas pressé)
/// - Interceptors : logging + retry
/// - Base URL configurable
class DioClient {
  DioClient({
    String? baseUrl,
    bool enableLogging = false,
  }) {
    _dio = Dio(
      BaseOptions(
        baseUrl: baseUrl ?? '',
        connectTimeout: const Duration(seconds: 15),
        receiveTimeout: const Duration(seconds: 15),
        sendTimeout: const Duration(seconds: 15),
        headers: {
          'Accept': 'application/json',
          'Content-Type': 'application/json',
        },
      ),
    );

    _dio.interceptors.add(RetryInterceptor(dio: _dio));

    if (enableLogging) {
      _dio.interceptors.add(LoggingInterceptor());
    }
  }

  late final Dio _dio;

  Dio get dio => _dio;

  /// GET typé.
  Future<Response<T>> get<T>(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.get<T>(path, queryParameters: queryParameters);
    } on DioException catch (e) {
      throw _mapToAppException(e);
    }
  }

  /// POST typé.
  Future<Response<T>> post<T>(
    String path, {
    Object? data,
    Map<String, dynamic>? queryParameters,
  }) async {
    try {
      return await _dio.post<T>(
        path,
        data: data,
        queryParameters: queryParameters,
      );
    } on DioException catch (e) {
      throw _mapToAppException(e);
    }
  }

  /// PUT typé.
  Future<Response<T>> put<T>(
    String path, {
    Object? data,
  }) async {
    try {
      return await _dio.put<T>(path, data: data);
    } on DioException catch (e) {
      throw _mapToAppException(e);
    }
  }

  /// DELETE typé.
  Future<Response<T>> delete<T>(String path) async {
    try {
      return await _dio.delete<T>(path);
    } on DioException catch (e) {
      throw _mapToAppException(e);
    }
  }

  AppException _mapToAppException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.transformTimeout:
        return const NetworkException('Délai de connexion dépassé.');
      case DioExceptionType.connectionError:
        return const NetworkException('Pas de connexion internet.');
      case DioExceptionType.badResponse:
        final code = e.response?.statusCode;
        if (code == 401) return const AuthException('Session expirée.');
        if (code == 403) return const AuthException('Accès refusé.');
        if (code == 404) return const ServerException('Ressource introuvable.');
        if (code != null && code >= 500) {
          return const ServerException();
        }
        return const ServerException();
      case DioExceptionType.cancel:
        return const NetworkException('Requête annulée.');
      case DioExceptionType.badCertificate:
        return const NetworkException('Certificat invalide.');
      case DioExceptionType.unknown:
        return const NetworkException();
    }
  }
}
