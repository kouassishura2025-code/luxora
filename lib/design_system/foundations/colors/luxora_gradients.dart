import 'package:flutter/material.dart';

import 'luxora_colors.dart';

abstract final class LuxoraGradients {
  static const LinearGradient champagne = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [LuxoraColors.champagneLight, LuxoraColors.champagne],
  );

  static const LinearGradient champagneDeep = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [LuxoraColors.champagne, LuxoraColors.champagneDeep],
  );

  static const LinearGradient veilBottom = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [Colors.transparent, LuxoraColors.obsidian],
  );

  static const LinearGradient obsidianVeil = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [LuxoraColors.charcoal, LuxoraColors.obsidian],
  );

  static const LinearGradient goldThread = LinearGradient(
    colors: [
      Colors.transparent,
      LuxoraColors.champagne,
      Colors.transparent,
    ],
    stops: [0.0, 0.5, 1.0],
  );
}
