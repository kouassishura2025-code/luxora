import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../colors/luxora_colors.dart';
import 'luxora_font_weights.dart';

/// Typographie signature LUXORA.
///
/// Playfair Display pour les titres (élégance éditoriale).
/// Manrope pour le corps (lisibilité moderne).
abstract final class LuxoraTextStyles {
  // ─── Display (titres héro) ───────────────────────────────
  static TextStyle get displayLarge => GoogleFonts.playfairDisplay(
        fontSize: 40,
        fontWeight: LuxoraFontWeights.bold,
        color: LuxoraColors.textPrimary,
        letterSpacing: 0.4,
        height: 1.15,
      );

  static TextStyle get displayMedium => GoogleFonts.playfairDisplay(
        fontSize: 32,
        fontWeight: LuxoraFontWeights.semibold,
        color: LuxoraColors.textPrimary,
        letterSpacing: 0.3,
        height: 1.2,
      );

  // ─── Titres de section ───────────────────────────────────
  static TextStyle get titleLarge => GoogleFonts.playfairDisplay(
        fontSize: 24,
        fontWeight: LuxoraFontWeights.semibold,
        color: LuxoraColors.textPrimary,
        height: 1.25,
      );

  static TextStyle get titleMedium => GoogleFonts.playfairDisplay(
        fontSize: 20,
        fontWeight: LuxoraFontWeights.semibold,
        color: LuxoraColors.textPrimary,
        height: 1.3,
      );

  // ─── Corps de texte ──────────────────────────────────────
  static TextStyle get bodyLarge => GoogleFonts.manrope(
        fontSize: 16,
        fontWeight: LuxoraFontWeights.regular,
        color: LuxoraColors.textPrimary,
        height: 1.5,
      );

  static TextStyle get bodyMedium => GoogleFonts.manrope(
        fontSize: 14,
        fontWeight: LuxoraFontWeights.regular,
        color: LuxoraColors.textSecondary,
        height: 1.5,
      );

  static TextStyle get bodySmall => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: LuxoraFontWeights.regular,
        color: LuxoraColors.textTertiary,
        height: 1.5,
      );

  // ─── Labels & captions ───────────────────────────────────
  static TextStyle get labelLarge => GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: LuxoraFontWeights.semibold,
        letterSpacing: 0.6,
        color: LuxoraColors.textPrimary,
      );

  static TextStyle get labelMedium => GoogleFonts.manrope(
        fontSize: 13,
        fontWeight: LuxoraFontWeights.medium,
        letterSpacing: 0.4,
        color: LuxoraColors.textSecondary,
      );

  static TextStyle get caption => GoogleFonts.manrope(
        fontSize: 11,
        fontWeight: LuxoraFontWeights.medium,
        letterSpacing: 1.2,
        color: LuxoraColors.textTertiary,
      );

  // ─── Button label (sur fond or, texte obsidienne) ────────
  static TextStyle get buttonLabel => GoogleFonts.manrope(
        fontSize: 15,
        fontWeight: LuxoraFontWeights.semibold,
        letterSpacing: 0.8,
        color: LuxoraColors.obsidian,
      );

  // ─── Overline (petites étiquettes en or, tout en haut) ───
  static TextStyle get overline => GoogleFonts.manrope(
        fontSize: 11,
        fontWeight: LuxoraFontWeights.semibold,
        letterSpacing: 2.4,
        color: LuxoraColors.champagne,
      );
}
