import 'package:flutter/material.dart';

import '../foundations/colors/luxora_colors.dart';
import '../foundations/spacing/luxora_radii.dart';
import '../foundations/typography/luxora_text_styles.dart';

/// Thème clair — option dans les réglages.
final ThemeData luxoraLightTheme = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  scaffoldBackgroundColor: LuxoraColors.ivory,
  primaryColor: LuxoraColors.obsidian,

  colorScheme: const ColorScheme.light(
    primary: LuxoraColors.obsidian,
    onPrimary: LuxoraColors.ivory,
    secondary: LuxoraColors.champagne,
    onSecondary: LuxoraColors.obsidian,
    surface: Colors.white,
    onSurface: LuxoraColors.obsidian,
    error: LuxoraColors.error,
    onError: LuxoraColors.ivory,
    outline: Color(0xFFE5E1D8),
  ),

  appBarTheme: AppBarTheme(
    backgroundColor: LuxoraColors.ivory,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    scrolledUnderElevation: 0,
    centerTitle: true,
    titleTextStyle: LuxoraTextStyles.titleMedium.copyWith(
      color: LuxoraColors.obsidian,
    ),
    iconTheme: const IconThemeData(color: LuxoraColors.obsidian, size: 22),
  ),

  textTheme: TextTheme(
    displayLarge: LuxoraTextStyles.displayLarge.copyWith(
      color: LuxoraColors.obsidian,
    ),
    displayMedium: LuxoraTextStyles.displayMedium.copyWith(
      color: LuxoraColors.obsidian,
    ),
    titleLarge: LuxoraTextStyles.titleLarge.copyWith(
      color: LuxoraColors.obsidian,
    ),
    titleMedium: LuxoraTextStyles.titleMedium.copyWith(
      color: LuxoraColors.obsidian,
    ),
    bodyLarge: LuxoraTextStyles.bodyLarge.copyWith(
      color: LuxoraColors.obsidian,
    ),
    bodyMedium: LuxoraTextStyles.bodyMedium.copyWith(
      color: LuxoraColors.textSecondary,
    ),
  ),

  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      backgroundColor: LuxoraColors.obsidian,
      foregroundColor: LuxoraColors.ivory,
      elevation: 0,
      minimumSize: const Size.fromHeight(56),
      shape: RoundedRectangleBorder(borderRadius: LuxoraRadii.brMd),
      textStyle: LuxoraTextStyles.buttonLabel.copyWith(
        color: LuxoraColors.ivory,
      ),
    ),
  ),

  outlinedButtonTheme: OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      foregroundColor: LuxoraColors.obsidian,
      minimumSize: const Size.fromHeight(56),
      side: const BorderSide(color: LuxoraColors.obsidian, width: 1),
      shape: RoundedRectangleBorder(borderRadius: LuxoraRadii.brMd),
    ),
  ),

  inputDecorationTheme: InputDecorationTheme(
    filled: true,
    fillColor: Colors.white,
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
      borderSide: BorderSide(color: Color(0xFFE5E1D8), width: 0.5),
    ),
    focusedBorder: const OutlineInputBorder(
      borderRadius: LuxoraRadii.brMd,
      borderSide: BorderSide(color: LuxoraColors.obsidian, width: 1),
    ),
    hintStyle: LuxoraTextStyles.bodyMedium,
  ),

  cardTheme: const CardTheme(
    color: Colors.white,
    surfaceTintColor: Colors.transparent,
    elevation: 0,
    margin: EdgeInsets.zero,
    shape: const RoundedRectangleBorder(borderRadius: LuxoraRadii.brLg),
  ),

  dividerTheme: const DividerThemeData(
    color: Color(0xFFE5E1D8),
    thickness: 0.5,
    space: 1,
  ),
);
