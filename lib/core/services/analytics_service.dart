import 'dart:developer' as dev;

import '../config/env.dart';

/// Service d'analytics LUXORA.
///
/// En dev : log dans la console (dart:developer).
/// En staging/prod : envoie à Firebase Analytics (à brancher plus tard).
class AnalyticsService {
  AnalyticsService({this.enabled = false});

  final bool enabled;

  /// Log un événement utilisateur.
  void logEvent(String name, [Map<String, Object?>? parameters]) {
    if (!enabled && !Env.current.isDev) return;
    dev.log(
      '📊 $name${parameters != null ? " — $parameters" : ""}',
      name: 'Analytics',
    );
  }

  /// Log un écran consulté.
  void logScreen(String screenName) {
    logEvent('screen_view', {'screen': screenName});
  }

  // ─── Événements LUXORA ────────────────────────────────
  void logBookingCreated({
    required String vehicleId,
    required double price,
  }) {
    logEvent('booking_created', {
      'vehicle_id': vehicleId,
      'price': price,
    });
  }

  void logBookingCancelled(String bookingId) {
    logEvent('booking_cancelled', {'booking_id': bookingId});
  }

  void logConciergeMessageSent() {
    logEvent('concierge_message_sent');
  }

  void logSosTriggered() {
    logEvent('sos_triggered');
  }

  void logLanguageChanged(String locale) {
    logEvent('language_changed', {'locale': locale});
  }

  void logKycSubmitted() {
    logEvent('kyc_submitted');
  }
}
