import 'package:flutter/material.dart';

import '../colors/luxora_colors.dart';

abstract final class LuxoraShadows {
  static const List<BoxShadow> soft = [
    BoxShadow(
      color: Color(0x66000000),
      blurRadius: 24,
      offset: Offset(0, 8),
    ),
  ];

  static const List<BoxShadow> elevated = [
    BoxShadow(
      color: Color(0x99000000),
      blurRadius: 48,
      offset: Offset(0, 16),
    ),
  ];

  static const List<BoxShadow> goldGlow = [
    BoxShadow(
      color: Color(0x33C9A24B),
      blurRadius: 32,
      spreadRadius: -4,
      offset: Offset(0, 8),
    ),
  ];

  static const BorderSide goldHairline = BorderSide(
    color: LuxoraColors.dividerGold,
    width: 0.5,
  );
}
