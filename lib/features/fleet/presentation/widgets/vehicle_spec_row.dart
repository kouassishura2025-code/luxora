import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Ligne de spécification d'un véhicule (icône + label + valeur).
class VehicleSpecRow extends StatelessWidget {
  const VehicleSpecRow({
    super.key,
    required this.icon,
    required this.label,
    required this.value,
  });

  final IconData icon;
  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: LuxoraColors.champagne,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              label,
              style: LuxoraTextStyles.bodyMedium.copyWith(
                fontSize: 14,
              ),
            ),
          ),
          Text(
            value,
            style: LuxoraTextStyles.labelLarge.copyWith(
              fontSize: 14,
              color: LuxoraColors.textPrimary,
            ),
          ),
        ],
      ),
    );
  }
}
