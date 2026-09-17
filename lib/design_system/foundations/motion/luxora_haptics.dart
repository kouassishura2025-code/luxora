import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

/// Service haptique LUXORA.
///
/// Fournit des retours tactiles cohérents et subtils.
/// Ignoré silencieusement sur Web et Desktop.
abstract final class LuxoraHaptics {
  /// Retour léger — tap sur un bouton, chip, item.
  static Future<void> light() async {
    if (kIsWeb) return;
    await HapticFeedback.lightImpact();
  }

  /// Retour moyen — action importante (validation, réservation).
  static Future<void> medium() async {
    if (kIsWeb) return;
    await HapticFeedback.mediumImpact();
  }

  /// Retour fort — action critique (SOS, suppression, confirmation).
  static Future<void> heavy() async {
    if (kIsWeb) return;
    await HapticFeedback.heavyImpact();
  }

  /// Retour de sélection — changement d'onglet, sélection de chip.
  static Future<void> selection() async {
    if (kIsWeb) return;
    await HapticFeedback.selectionClick();
  }

  /// Vibration longue — pour les alertes.
  static Future<void> vibrate() async {
    if (kIsWeb) return;
    await HapticFeedback.vibrate();
  }
}
