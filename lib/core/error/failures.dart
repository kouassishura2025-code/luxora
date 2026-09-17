import 'package:equatable/equatable.dart';

/// Failure — erreur côté Domain.
///
/// Représente une erreur métier qui peut être présentée à l'utilisateur.
/// Toutes les erreurs techniques (Exception) sont mappées en Failure
/// avant d'atteindre la couche présentation.
sealed class Failure extends Equatable {
  const Failure(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}

/// Erreur réseau (timeout, pas de connexion, DNS…).
class NetworkFailure extends Failure {
  const NetworkFailure([super.message = 'Connexion impossible.']);
}

/// Erreur serveur (5xx, réponse invalide).
class ServerFailure extends Failure {
  const ServerFailure([super.message = 'Erreur serveur.']);
}

/// Erreur d'authentification (401, token expiré).
class AuthFailure extends Failure {
  const AuthFailure([super.message = 'Authentification requise.']);
}

/// Erreur de validation (400, données invalides).
class ValidationFailure extends Failure {
  const ValidationFailure([super.message = 'Données invalides.']);
}

/// Ressource non trouvée (404).
class NotFoundFailure extends Failure {
  const NotFoundFailure([super.message = 'Ressource introuvable.']);
}

/// Erreur de cache local.
class CacheFailure extends Failure {
  const CacheFailure([super.message = 'Erreur de cache.']);
}

/// Erreur inconnue (fallback).
class UnknownFailure extends Failure {
  const UnknownFailure([super.message = 'Une erreur est survenue.']);
}
