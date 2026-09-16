import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/booking_entities.dart';

/// Chip cochable pour une préférence chauffeur.
class ChauffeurPreferenceChip extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: LuxoraRadii.brPill,
        splashColor: LuxoraColors.champagne.withOpacity(0.08),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 12),
          decoration: BoxDecoration(
            color: selected
                ? LuxoraColors.champagne.withOpacity(0.12)
                : LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brPill,
            border: Border.all(
              color: selected
                  ? LuxoraColors.champagne
                  : LuxoraColors.divider,
              width: selected ? 1 : 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                preference.icon,
                size: 15,
                color: selected
                    ? LuxoraColors.champagne
                    : LuxoraColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                preference.label,
                style: LuxoraTextStyles.labelMedium.copyWith(
                  fontSize: 13,
                  color: selected
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
