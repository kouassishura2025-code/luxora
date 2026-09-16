import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/motion/luxora_durations.dart';

/// Fil doré de progression du flux booking.
///
/// 5 points reliés. Le point courant est plein or. Les passés sont dorés
/// semi-opaques. Les futurs sont gris.
class BookingProgress extends StatelessWidget {
  const BookingProgress({
    super.key,
    required this.currentStep,
    this.totalSteps = 5,
  });

  final int currentStep; // 1-indexé
  final int totalSteps;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 1; i <= totalSteps; i++) ...[
          _Dot(
            isActive: i == currentStep,
            isPast: i < currentStep,
          ),
          if (i != totalSteps)
            Expanded(
              child: Container(
                height: 0.5,
                margin: const EdgeInsets.symmetric(horizontal: 4),
                color: i < currentStep
                    ? LuxoraColors.champagne.withOpacity(0.6)
                    : LuxoraColors.divider,
              ),
            ),
        ],
      ],
    );
  }
}

class _Dot extends StatelessWidget {
  const _Dot({
    required this.isActive,
    required this.isPast,
  });

  final bool isActive;
  final bool isPast;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: LuxoraDurations.standard,
      curve: Curves.easeOutCubic,
      width: isActive ? 12 : 6,
      height: isActive ? 12 : 6,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isActive
            ? LuxoraColors.champagne
            : isPast
                ? LuxoraColors.champagne.withOpacity(0.5)
                : LuxoraColors.divider,
      ),
    );
  }
}
