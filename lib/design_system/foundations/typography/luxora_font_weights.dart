import 'package:flutter/material.dart';

/// Poids de police LUXORA.
///
/// Règle : jamais en dessous de `w400`. LUXORA ne chuchote pas, elle parle.
abstract final class LuxoraFontWeights {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight medium = FontWeight.w500;
  static const FontWeight semibold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}
