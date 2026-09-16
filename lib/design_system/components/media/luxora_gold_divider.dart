import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_gradients.dart';

/// Séparateur doré LUXORA — fil d'or qui s'estompe aux extrémités.
class LuxoraGoldDivider extends StatelessWidget {
  const LuxoraGoldDivider({
    super.key,
    this.width = 40,
    this.thickness = 0.5,
  });

  final double width;
  final double thickness;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: width,
        height: thickness,
        decoration: const BoxDecoration(
          gradient: LuxoraGradients.goldThread,
        ),
      ),
    );
  }
}
