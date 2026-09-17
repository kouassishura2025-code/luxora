/// Constantes globales de l'application.
abstract final class AppConfig {
  // ─── Identité ──────────────────────────────────────────
  static const String appName = 'LUXORA';
  static const String appVersion = '0.1.0';
  static const String appTagline = 'Chauffeur privé & conciergerie de luxe';

  // ─── Contact ───────────────────────────────────────────
  static const String supportEmail = 'support@luxora.app';
  static const String supportPhone = '+225 07 00 00 00 00';

  // ─── URLs légales ──────────────────────────────────────
  static const String termsUrl = 'https://luxora.app/terms';
  static const String privacyUrl = 'https://luxora.app/privacy';

  // ─── Limites ───────────────────────────────────────────
  static const int maxBookingHistory = 50;
  static const int maxFavoriteDrivers = 20;
  static const int maxRecentDestinations = 5;
  static const int otpLength = 6;

  // ─── Timeouts ──────────────────────────────────────────
  static const Duration otpTimeout = Duration(seconds: 60);
  static const Duration searchDebounce = Duration(milliseconds: 400);
  static const Duration splashDuration = Duration(milliseconds: 2400);

  // ─── Contact d'urgence ─────────────────────────────────
  static const String emergencyNumber = '112'; // Europe
  static const String emergencyNumberCI = '180'; // Côte d'Ivoire
}
