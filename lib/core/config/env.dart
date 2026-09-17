/// Environnement d'exécution de l'application.
enum Env {
  dev('dev', 'LUXORA Dev'),
  staging('staging', 'LUXORA Staging'),
  prod('prod', 'LUXORA');

  const Env(this.key, this.appName);

  final String key;
  final String appName;

  /// Environnement courant — modifié par `--dart-define=ENV=staging`.
  static Env get current {
    const raw = String.fromEnvironment('ENV', defaultValue: 'dev');
    return Env.values.firstWhere(
      (e) => e.key == raw,
      orElse: () => Env.dev,
    );
  }

  bool get isDev => this == Env.dev;
  bool get isStaging => this == Env.staging;
  bool get isProd => this == Env.prod;

  /// Logs activés en dev et staging.
  bool get enableLogging => !isProd;

  /// Analytics activés en staging et prod.
  bool get enableAnalytics => !isDev;
}
