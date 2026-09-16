import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Statistique d'un chauffeur (valeur + label).
class DriverStat extends StatelessWidget {
  const DriverStat({
    super.key,
    required this.value,
    required this.label,
  });

  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text(
          value,
          style: LuxoraTextStyles.titleMedium.copyWith(
            fontSize: 18,
            color: LuxoraColors.champagne,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label.toUpperCase(),
          style: LuxoraTextStyles.caption.copyWith(
            fontSize: 9,
            letterSpacing: 1.2,
          ),
        ),
      ],
    );
  }
}
