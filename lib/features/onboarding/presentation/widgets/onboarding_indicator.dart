import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/motion/luxora_durations.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';

/// Indicateur de progression doré LUXORA.
///
/// Le point courant s'étire en une barre or. Les autres restent fins.
class OnboardingIndicator extends StatelessWidget {
  const OnboardingIndicator({
    super.key,
    required this.count,
    required this.currentIndex,
  });

  final int count;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(count, (index) {
        final isActive = index == currentIndex;
        return AnimatedContainer(
          duration: LuxoraDurations.standard,
          curve: Curves.easeOutCubic,
          margin: const EdgeInsets.symmetric(horizontal: 4),
          height: 4,
          width: isActive ? 28 : 8,
          decoration: BoxDecoration(
            color: isActive
                ? LuxoraColors.champagne
                : LuxoraColors.champagne.withOpacity(0.25),
            borderRadius: LuxoraRadii.brPill,
          ),
        );
      }),
    );
  }
}
