import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';

/// Bloc skeleton LUXORA — pour les états de chargement.
class LuxoraSkeleton extends StatelessWidget {
  const LuxoraSkeleton({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = LuxoraRadii.brSm,
  });

  final double? width;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: LuxoraColors.charcoal,
        borderRadius: borderRadius,
      ),
    );
  }
}
