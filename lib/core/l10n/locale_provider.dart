import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Langue de l'application.
///
/// - `null` → suit la langue du système
/// - `Locale('fr')` → français forcé
/// - `Locale('en')` → anglais forcé
final localeProvider = StateProvider<Locale?>((ref) => null);

/// Langues supportées par LUXORA.
const supportedLocales = <Locale>[
  Locale('fr'),
  Locale('en'),
];

/// Noms affichables pour chaque langue.
const localeNames = <String, String>{
  'fr': 'Français',
  'en': 'English',
};
