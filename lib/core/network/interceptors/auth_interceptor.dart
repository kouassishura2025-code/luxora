import 'package:dio/dio.dart';

/// Interceptor qui ajoute automatiquement le token d'auth
/// à chaque requête (si disponible).
///
/// Le token est récupéré via un callback fourni par la couche auth
/// (pour ne pas coupler le Core à Firebase directement).
class AuthInterceptor extends Interceptor {
  AuthInterceptor({
    required this.tokenProvider,
    required this.onUnauthorized,
  });

  /// Fonction qui retourne le token courant (null si non connecté).
  final Future<String?> Function() tokenProvider;

  /// Callback appelé si le serveur retourne 401.
  final void Function() onUnauthorized;

  @override
  Future<void> onRequest(
    RequestOptions options,
    RequestInterceptorHandler handler,
  ) async {
    final token = await tokenProvider();
    if (token != null && token.isNotEmpty) {
      options.headers['Authorization'] = 'Bearer $token';
    }
    handler.next(options);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) {
    if (err.response?.statusCode == 401) {
      onUnauthorized();
    }
    handler.next(err);
  }
}
