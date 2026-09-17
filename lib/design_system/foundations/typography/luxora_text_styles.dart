import 'package:flutter/material.dart';

import '../colors/luxora_colors.dart';
import 'luxora_font_weights.dart';

/// Typographie signature LUXORA — fonts locales (variable fonts).
abstract final class LuxoraTextStyles {
  static const String _serif = 'PlayfairDisplay';
  static const String _sans = 'Manrope';

  static TextStyle get displayLarge => const TextStyle(
        fontFamily: _serif,
        fontSize: 40,
        fontWeight: LuxoraFontWeights.bold,
        color: LuxoraColors.textPrimary,
        letterSpacing: 0.4,
        height: 1.15,
      );

  static TextStyle get displayMedium => const TextStyle(
        fontFamily: _serif,
        fontSize: 32,
        fontWeight: LuxoraFontWeights.semibold,
        color: LuxoraColors.textPrimary,
        letterSpacing: 0.3,
        height: 1.2,
      );

  static TextStyle get titleLarge => const TextStyle(
        fontFamily: _serif,
        fontSize: 24,
        fontWeight: LuxoraFontWeights.semibold,
        color: LuxoraColors.textPrimary,
        height: 1.25,
      );

  static TextStyle get titleMedium => const TextStyle(
        fontFamily: _serif,
        fontSize: 20,
        fontWeight: LuxoraFontWeights.semibold,
        color: LuxoraColors.textPrimary,
        height: 1.3,
      );

  static TextStyle get bodyLarge => const TextStyle(
        fontFamily: _sans,
        fontSize: 16,
        fontWeight: LuxoraFontWeights.regular,
        color: LuxoraColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => const TextStyle(
        fontFamily: _sans,
        fontSize: 14,
        fontWeight: LuxoraFontWeights.regular,
        color: LuxoraColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get bodySmall => const TextStyle(
        fontFamily: _sans,
        fontSize: 13,
        fontWeight: LuxoraFontWeights.regular,
        color: LuxoraColors.textTertiary,
        height: 1.5,
      );

  static TextStyle get labelLarge => const TextStyle(
        fontFamily: _sans,
        fontSize: 15,
        fontWeight: LuxoraFontWeights.semibold,
        letterSpacing: 0.6,
        color: LuxoraColors.textPrimary,
      );

  static TextStyle get labelMedium => const TextStyle(
        fontFamily: _sans,
        fontSize: 13,
        fontWeight: LuxoraFontWeights.medium,
        letterSpacing: 0.4,
        color: LuxoraColors.textSecondary,
      );

  static TextStyle get caption => const TextStyle(
        fontFamily: _sans,
        fontSize: 11,
        fontWeight: LuxoraFontWeights.medium,
        letterSpacing: 1.2,
        color: LuxoraColors.textTertiary,
      );

  static TextStyle get buttonLabel => const TextStyle(
        fontFamily: _sans,
        fontSize: 15,
        fontWeight: LuxoraFontWeights.semibold,
        letterSpacing: 0.8,
        color: LuxoraColors.obsidian,
      );

  static TextStyle get overline => const TextStyle(
        fontFamily: _sans,
        fontSize: 11,
        fontWeight: LuxoraFontWeights.semibold,
        letterSpacing: 2.4,
        color: LuxoraColors.champagne,
      );
}
