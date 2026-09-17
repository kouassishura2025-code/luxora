import 'dart:developer' as dev;

import 'package:flutter/foundation.dart';

import '../config/env.dart';

/// Service Crashlytics LUXORA.
///
/// En dev : log l'erreur dans la console.
/// En staging/prod : envoie à Firebase Crashlytics (à brancher plus tard).
class CrashlyticsService {
  CrashlyticsService({this.enabled = false});

  final bool enabled;

  /// Enregistre une erreur non fatale.
  Future<void> recordError(
    Object error,
    StackTrace? stack, {
    String? reason,
    bool fatal = false,
  }) async {
    if (!enabled && !Env.current.isDev) return;

    dev.log(
      '💥 ${fatal ? "FATAL" : "ERROR"} — ${reason ?? error}',
      name: 'Crashlytics',
      error: error,
      stackTrace: stack,
    );

    // TODO: brancher Firebase Crashlytics
    // await FirebaseCrashlytics.instance.recordError(
    //   error, stack, reason: reason, fatal: fatal,
    // );
  }

  /// Enregistre un message de log.
  void log(String message) {
    if (!enabled && !Env.current.isDev) return;
    dev.log('📝 $message', name: 'Crashlytics');
  }

  /// Définit l'identifiant utilisateur.
  void setUserIdentifier(String userId) {
    log('user=$userId');
    // TODO: FirebaseCrashlytics.instance.setUserIdentifier(userId);
  }

  /// Définit une clé custom.
  void setCustomKey(String key, Object value) {
    log('$key=$value');
    // TODO: FirebaseCrashlytics.instance.setCustomKey(key, value);
  }

  /// Force un crash (dev seulement, pour tester).
  void crash() {
    if (!kDebugMode) return;
    throw StateError('Test crash LUXORA');
  }
}
