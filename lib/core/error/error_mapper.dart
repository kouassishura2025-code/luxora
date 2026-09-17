import 'package:dio/dio.dart';
import 'package:firebase_auth/firebase_auth.dart';

import 'exceptions.dart';
import 'failures.dart';

/// Mapper centralisé : convertit toute erreur en `Failure`.
abstract final class ErrorMapper {
  static Failure toFailure(Object error) {
    if (error is AppException) return _fromAppException(error);
    if (error is DioException) return _fromDioException(error);
    if (error is FirebaseAuthException) return _fromFirebaseAuth(error);
    if (error is FirebaseException) return _fromFirebase(error);
    return const UnknownFailure();
  }

  static Failure _fromAppException(AppException e) {
    return switch (e) {
      NetworkException() => NetworkFailure(e.message),
      ServerException() => ServerFailure(e.message),
      AuthException() => AuthFailure(e.message),
      CacheException() => CacheFailure(e.message),
      ParseException() => const ServerFailure('Réponse invalide.'),
      ValidationException() => ValidationFailure(e.message),
    };
  }

  static Failure _fromDioException(DioException e) {
    switch (e.type) {
      case DioExceptionType.connectionTimeout:
      case DioExceptionType.receiveTimeout:
      case DioExceptionType.sendTimeout:
      case DioExceptionType.transformTimeout:
        return const NetworkFailure('Délai de connexion dépassé.');
      case DioExceptionType.connectionError:
        return const NetworkFailure('Pas de connexion internet.');
      case DioExceptionType.badResponse:
        return _fromStatusCode(e.response?.statusCode);
      case DioExceptionType.cancel:
        return const NetworkFailure('Requête annulée.');
      case DioExceptionType.badCertificate:
        return const NetworkFailure('Certificat invalide.');
      case DioExceptionType.unknown:
        return const NetworkFailure();
    }
  }

  static Failure _fromStatusCode(int? code) {
    if (code == null) return const UnknownFailure();
    if (code == 400) return const ValidationFailure();
    if (code == 401) return const AuthFailure('Session expirée.');
    if (code == 403) return const AuthFailure('Accès refusé.');
    if (code == 404) return const NotFoundFailure();
    if (code == 422) return const ValidationFailure();
    if (code >= 500) return const ServerFailure();
    return const UnknownFailure();
  }

  static Failure _fromFirebaseAuth(FirebaseAuthException e) {
    return switch (e.code) {
      'invalid-phone-number' =>
        const ValidationFailure('Numéro de téléphone invalide.'),
      'too-many-requests' =>
        const ValidationFailure('Trop de tentatives. Réessayez plus tard.'),
      'invalid-verification-code' =>
        const ValidationFailure('Code incorrect.'),
      'session-expired' =>
        const ValidationFailure('Session expirée. Renvoyez un code.'),
      'quota-exceeded' =>
        const ValidationFailure('Quota SMS dépassé. Réessayez plus tard.'),
      'user-disabled' => const AuthFailure('Compte désactivé.'),
      'user-not-found' => const NotFoundFailure('Utilisateur introuvable.'),
      'network-request-failed' => const NetworkFailure(),
      _ => const AuthFailure(),
    };
  }

  static Failure _fromFirebase(FirebaseException e) {
    return switch (e.code) {
      'unavailable' => const NetworkFailure('Service indisponible.'),
      'not-found' => const NotFoundFailure(),
      'permission-denied' => const AuthFailure('Permission refusée.'),
      'already-exists' => const ValidationFailure('Existe déjà.'),
      _ => const ServerFailure(),
    };
  }
}
