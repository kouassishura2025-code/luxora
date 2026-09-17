import 'env.dart';

/// Configuration par flavor (dev/staging/prod).
///
/// Fournit les URLs, clés API et paramètres spécifiques à chaque environnement.
class FlavorConfig {
  const FlavorConfig._({
    required this.env,
    required this.apiBaseUrl,
    required this.enableAnalytics,
    required this.enableCrashlytics,
  });

  final Env env;
  final String apiBaseUrl;
  final bool enableAnalytics;
  final bool enableCrashlytics;

  /// Configuration pour l'environnement courant.
  factory FlavorConfig.current() {
    switch (Env.current) {
      case Env.dev:
        return const FlavorConfig._(
          env: Env.dev,
          apiBaseUrl: 'https://dev-api.luxora.app',
          enableAnalytics: false,
          enableCrashlytics: false,
        );
      case Env.staging:
        return const FlavorConfig._(
          env: Env.staging,
          apiBaseUrl: 'https://staging-api.luxora.app',
          enableAnalytics: true,
          enableCrashlytics: true,
        );
      case Env.prod:
        return const FlavorConfig._(
          env: Env.prod,
          apiBaseUrl: 'https://api.luxora.app',
          enableAnalytics: true,
          enableCrashlytics: true,
        );
    }
  }

  /// Instance courante — singleton.
  static FlavorConfig? _instance;

  static FlavorConfig get instance => _instance ??= FlavorConfig.current();

  /// Reset (utile en tests).
  static void reset() => _instance = null;
}
