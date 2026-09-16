import 'package:flutter/material.dart';

import 'luxora_dark_theme.dart';
import 'luxora_light_theme.dart';

/// Thème LUXORA — point d'entrée unique.
///
/// Utilisation dans MaterialApp :
/// ```dart
/// MaterialApp(
///   theme: LuxoraTheme.light,
///   darkTheme: LuxoraTheme.dark,
///   themeMode: ThemeMode.dark, // signature par défaut
/// )
/// ```
abstract final class LuxoraTheme {
  static ThemeData get dark => luxoraDarkTheme;
  static ThemeData get light => luxoraLightTheme;
}
