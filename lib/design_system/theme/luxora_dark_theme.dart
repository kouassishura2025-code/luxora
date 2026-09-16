import 'package:flutter/material.dart';

import '../foundations/colors/luxora_colors.dart';
import '../foundations/spacing/luxora_radii.dart';
import '../foundations/typography/luxora_text_styles.dart';

/// Thème sombre — l'expérience par défaut de LUXORA.
final ThemeData luxoraDarkTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.dark,
  scaffoldBackgroundColor: LuxoraColors.obsidian,
  primaryColor: LuxoraColors.champagne,

  colorScheme: const ColorScheme.dark(
    primary: LuxoraColors.champagne,
    onPrimary: LuxoraColors.obsidian,
    secondary: LuxoraColors.champagneLight,
    onSecondary: LuxoraColors.obsidian,
    surface: LuxoraColors.charcoal,
    onSurface: LuxoraColors.textPrimary,
    surfaceContainerHighest: LuxoraColors.graphite,
    error: LuxoraColors.error,
    onError: LuxoraColors.ivory,
    outline: LuxoraColors.divider,
  ),

  // ─── AppBar ───────────────────────────────────────────────
  appBarTheme: AppBarTheme(
    backgroundColor: LuxoraColors.obsidian,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    titleTextStyle: LuxoraTextStyles.titleMedium,
    iconTheme: const IconThemeData(
      color: LuxoraColors.textPrimary,
      size: 22,
    ),
  ),

  // ─── Texte global ─────────────────────────────────────────
  textTheme: TextTheme(
    displayLarge: LuxoraTextStyles.displayLarge,
    displayMedium: LuxoraTextStyles.displayMedium,
    titleLarge: LuxoraTextStyles.titleLarge,
    titleMedium: LuxoraTextStyles.titleMedium,
    bodyLarge: LuxoraTextStyles.bodyLarge,
    bodyMedium: LuxoraTextStyles.bodyMedium,
    bodySmall: LuxoraTextStyles.bodySmall,
    labelLarge: LuxoraTextStyles.labelLarge,
    labelMedium: LuxoraTextStyles.labelMedium,
    labelSmall: LuxoraTextStyles.caption,
  ),

  // ─── Boutons ──────────────────────────────────────────────
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LuxoraColors.champagne,
      foregroundColor: LuxoraColors.obsidian,
      disabledBackgroundColor: LuxoraColors.slate,
      disabledForegroundColor: LuxoraColors.textDisabled,
      elevation: 0,
      shadowColor: Colors.transparent,
      minimumSize: const Size.fromHeight(56),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      shape: RoundedRectangleBorder(borderRadius: LuxoraRadii.brMd),
      textStyle: LuxoraTextStyles.buttonLabel,
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: LuxoraColors.champagne,
      minimumSize: const Size.fromHeight(56),
      padding: const EdgeInsets.symmetric(horizontal: 24),
      side: const BorderSide(color: LuxoraColors.champagne, width: 1),
      shape: RoundedRectangleBorder(borderRadius: LuxoraRadii.brMd),
      textStyle: LuxoraTextStyles.buttonLabel.copyWith(
        color: LuxoraColors.champagne,
      ),
    ),
  ),

  textButtonTheme: TextButtonThemeData(
    style: TextButton.styleFrom(
      foregroundColor: LuxoraColors.champagne,
      textStyle: LuxoraTextStyles.labelLarge.copyWith(
        color: LuxoraColors.champagne,
      ),
    ),
  ),

  // ─── Inputs ───────────────────────────────────────────────
  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: LuxoraColors.charcoal,
    contentPadding: const EdgeInsets.symmetric(
      horizontal: 20,
      vertical: 18,
    ),
    border: const OutlineInputBorder(
      borderRadius: LuxoraRadii.brMd,
      borderSide: BorderSide.none,
    ),
    enabledBorder: const OutlineInputBorder(
      borderRadius: LuxoraRadii.brMd,
      borderSide: BorderSide.none,
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: LuxoraRadii.brMd,
      borderSide: BorderSide(color: LuxoraColors.champagne, width: 1),
    ),
    errorBorder: const OutlineInputBorder(
      borderRadius: LuxoraRadii.brMd,
      borderSide: BorderSide(color: LuxoraColors.error, width: 1),
    ),
    hintStyle: LuxoraTextStyles.bodyMedium.copyWith(
      color: LuxoraColors.textTertiary,
    ),
    labelStyle: LuxoraTextStyles.labelMedium,
  ),

  // ─── Cartes ───────────────────────────────────────────────
  cardTheme: const CardTheme(
    color: LuxoraColors.charcoal,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(
      borderRadius: LuxoraRadii.brLg,
    ),
  ),

  // ─── Divider ──────────────────────────────────────────────
  dividerTheme: const DividerThemeData(
    color: LuxoraColors.divider,
    thickness: 0.5,
    space: 1,
  ),

  // ─── Bottom navigation ────────────────────────────────────
  bottomNavigationBarTheme: const BottomNavigationBarThemeData(
    backgroundColor: LuxoraColors.obsidian,
    selectedItemColor: LuxoraColors.champagne,
    unselectedItemColor: LuxoraColors.textTertiary,
    selectedLabelStyle: TextStyle(fontSize: 11, letterSpacing: 0.6),
    unselectedLabelStyle: TextStyle(fontSize: 11, letterSpacing: 0.4),
    type: BottomNavigationBarType.fixed,
    elevation: 0,
    showUnselectedLabels: true,
  ),

  // ─── Dialog ───────────────────────────────────────────────
  dialogTheme: DialogTheme(
    backgroundColor: LuxoraColors.charcoal,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    shape: const RoundedRectangleBorder(
      borderRadius: LuxoraRadii.brXl,
      side: BorderSide(color: LuxoraColors.dividerGold, width: 0.5),
    ),
    titleTextStyle: LuxoraTextStyles.titleMedium,
    contentTextStyle: LuxoraTextStyles.bodyMedium,
  ),

  // ─── Bottom sheet ─────────────────────────────────────────
  bottomSheetTheme: const BottomSheetThemeData(
    backgroundColor: LuxoraColors.charcoal,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    modalBackgroundColor: LuxoraColors.charcoal,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: LuxoraRadii.xl),
    ),
  ),

  // ─── SnackBar ─────────────────────────────────────────────
  snackBarTheme: SnackBarThemeData(
    backgroundColor: LuxoraColors.graphite,
    contentTextStyle: LuxoraTextStyles.bodyMedium.copyWith(
      color: LuxoraColors.textPrimary,
    ),
    behavior: SnackBarBehavior.floating,
    shape: const RoundedRectangleBorder(borderRadius: LuxoraRadii.brMd),
    elevation: 0,
  ),

  // ─── Splash / ripple discret ──────────────────────────────
  splashColor: LuxoraColors.champagne.withOpacity(0.08),
  highlightColor: LuxoraColors.champagne.withOpacity(0.04),
);
