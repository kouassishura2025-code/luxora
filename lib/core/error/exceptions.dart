/// Exception — erreur côté Data (technique).
///
/// Ces exceptions sont jetées par les datasources et repositories.
/// Elles sont mappées en Failure avant d'atteindre le Domain.
sealed class AppException implements Exception {
  const AppException(this.message);

  final String message;

  @override
  String toString() => '$runtimeType: $message';
}

/// Erreur de communication réseau.
class NetworkException extends AppException {
  const NetworkException([super.message = 'Erreur réseau.']);
}

/// Erreur du serveur.
class ServerException extends AppException {
  const ServerException([super.message = 'Erreur serveur.']);
}

/// Erreur d'authentification.
class AuthException extends AppException {
  const AuthException([super.message = 'Erreur d\'authentification.']);
}

/// Erreur de cache local.
class CacheException extends AppException {
  const CacheException([super.message = 'Erreur de cache.']);
}

/// Erreur de parsing (JSON invalide).
class ParseException extends AppException {
  const ParseException([super.message = 'Erreur de parsing.']);
}

/// Erreur de validation.
class ValidationException extends AppException {
  const ValidationException([super.message = 'Erreur de validation.']);
}
