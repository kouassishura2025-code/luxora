import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Chip d'équipement (Wi-Fi, Clim, etc.).
class VehicleAmenityChip extends StatelessWidget {
  const VehicleAmenityChip({super.key, required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
      decoration: BoxDecoration(
        color: LuxoraColors.charcoal,
        borderRadius: LuxoraRadii.brPill,
        border: Border.all(
          color: LuxoraColors.champagne.withOpacity(0.2),
          width: 0.5,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 5,
            height: 5,
            decoration: const BoxDecoration(
              color: LuxoraColors.champagne,
              shape: BoxShape.circle,
            ),
          ),
          const SizedBox(width: 8),
          Text(
            label,
            style: LuxoraTextStyles.labelMedium.copyWith(
              fontSize: 12,
              color: LuxoraColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
