import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Ligne de prix élégante LUXORA.
///
/// Pas de centimes, séparateur fin or entre les lignes.
class PriceElegantRow extends StatelessWidget {
  const PriceElegantRow({
    super.key,
    required this.label,
    required this.value,
    this.isTotal = false,
    this.isGold = false,
  });

  final String label;
  final String value;
  final bool isTotal;
  final bool isGold;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        children: [
          Text(
            label,
            style: isTotal
                ? LuxoraTextStyles.labelLarge
                : LuxoraTextStyles.bodyMedium,
          ),
          const Spacer(),
          Text(
            value,
            style: (isTotal
                    ? LuxoraTextStyles.titleMedium
                    : LuxoraTextStyles.bodyLarge)
                .copyWith(
              color: isGold || isTotal
                  ? LuxoraColors.champagne
                  : LuxoraColors.textPrimary,
              fontSize: isTotal ? 22 : null,
            ),
          ),
        ],
      ),
    );
  }
}
