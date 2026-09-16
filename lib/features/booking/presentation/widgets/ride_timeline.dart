import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Une étape de la timeline de course.
class RideTimelineStep {
  const RideTimelineStep({
    required this.label,
    required this.subtitle,
    required this.done,
    required this.active,
  });

  final String label;
  final String subtitle;
  final bool done;
  final bool active;
}

/// Timeline verticale de la course.
class RideTimeline extends StatelessWidget {
  const RideTimeline({super.key, required this.steps});

  final List<RideTimelineStep> steps;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        for (var i = 0; i < steps.length; i++)
          _TimelineRow(
            step: steps[i],
            isLast: i == steps.length - 1,
          ),
      ],
    );
  }
}

class _TimelineRow extends StatelessWidget {
  const _TimelineRow({required this.step, required this.isLast});

  final RideTimelineStep step;
  final bool isLast;

  @override
  Widget build(BuildContext context) {
    final dotColor = step.done
        ? LuxoraColors.champagne
        : step.active
            ? LuxoraColors.champagne
            : LuxoraColors.divider;

    return IntrinsicHeight(
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Point + ligne ──────────────────────────────
          Column(
            children: [
              Container(
                width: step.active ? 12 : 8,
                height: step.active ? 12 : 8,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: step.done || step.active
                      ? dotColor
                      : Colors.transparent,
                  border: Border.all(color: dotColor, width: 1),
                ),
              ),
              if (!isLast)
                Expanded(
                  child: Container(
                    width: 0.5,
                    color: step.done
                        ? LuxoraColors.champagne.withOpacity(0.5)
                        : LuxoraColors.divider,
                  ),
                ),
            ],
          ),
          const SizedBox(width: 16),

          // ─── Contenu ────────────────────────────────────
          Expanded(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 20, top: 2),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    step.label,
                    style: LuxoraTextStyles.labelLarge.copyWith(
                      fontSize: 14,
                      color: step.done || step.active
                          ? LuxoraColors.textPrimary
                          : LuxoraColors.textTertiary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    step.subtitle,
                    style: LuxoraTextStyles.bodySmall.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
