import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/motion/luxora_durations.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Barre de progression dorée du dossier KYC.
class KycProgressBar extends StatelessWidget {
  const KycProgressBar({super.key, required this.progress});

  /// Valeur entre 0.0 et 1.0.
  final double progress;

  @override
  Widget build(BuildContext context) {
    final percent = (progress * 100).round();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Text(
              'AVANCEMENT',
              style: LuxoraTextStyles.overline.copyWith(
                fontSize: 10,
                color: LuxoraColors.textSecondary,
              ),
            ),
            const Spacer(),
            Text(
              '$percent %',
              style: LuxoraTextStyles.labelMedium.copyWith(
                color: LuxoraColors.champagne,
                fontSize: 12,
              ),
            ),
          ],
        ),
        const SizedBox(height: 10),
        ClipRRect(
          borderRadius: LuxoraRadii.brPill,
          child: Stack(
            children: [
              Container(
                height: 4,
                color: LuxoraColors.divider,
              ),
              AnimatedFractionallySizedBox(
                duration: LuxoraDurations.standard,
                curve: Curves.easeOutCubic,
                widthFactor: progress.clamp(0.0, 1.0),
                alignment: Alignment.centerLeft,
                child: Container(
                  height: 4,
                  decoration: BoxDecoration(
                    color: LuxoraColors.champagne,
                    borderRadius: LuxoraRadii.brPill,
                  ),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
