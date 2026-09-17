import 'dart:developer' as dev;

import 'package:dio/dio.dart';

/// Interceptor qui log les requêtes HTTP en développement.
///
/// Utilise `dart:developer` (pas `print`) pour apparaître dans DevTools.
class LoggingInterceptor extends Interceptor {
  @override
  void onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) {
    dev.log(
      '→ ${options.method} ${options.uri}',
      name: 'HTTP',
    );
    handler.next(options);
  }

  @override
  void onResponse(
    Response<dynamic> response,
    ResponseInterceptorHandler handler,
  ) {
    dev.log(
      '← ${response.statusCode} ${response.requestOptions.uri}',
      name: 'HTTP',
    );
    handler.next(response);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    dev.log(
      '✗ ${err.response?.statusCode ?? "?"} ${err.requestOptions.uri} '
      '— ${err.message}',
      name: 'HTTP',
      error: err,
    );
    handler.next(err);
  }
}
