import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/motion/luxora_durations.dart';
import '../../../../design_system/foundations/motion/luxora_haptics.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/booking_entities.dart';

/// Chip cochable pour une préférence chauffeur.
class ChauffeurPreferenceChip extends StatefulWidget {
  const ChauffeurPreferenceChip({
    super.key,
    required this.preference,
    required this.selected,
    required this.onTap,
  });

  final ChauffeurPreference preference;
  final bool selected;
  final VoidCallback onTap;

  @override
  State<ChauffeurPreferenceChip> createState() =>
      _ChauffeurPreferenceChipState();
}

class _ChauffeurPreferenceChipState extends State<ChauffeurPreferenceChip> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        LuxoraHaptics.selection();
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: LuxoraDurations.instant,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: widget.selected
                ? LuxoraColors.champagne.withOpacity(0.12)
                : LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brPill,
            border: Border.all(
              color: widget.selected
                  ? LuxoraColors.champagne
                  : LuxoraColors.divider,
              width: widget.selected ? 1 : 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.preference.icon,
                size: 15,
                color: widget.selected
                    ? LuxoraColors.champagne
                    : LuxoraColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                widget.preference.label,
                style: LuxoraTextStyles.labelMedium.copyWith(
                  fontSize: 13,
                  color: widget.selected
                      ? LuxoraColors.champagne
                      : LuxoraColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
