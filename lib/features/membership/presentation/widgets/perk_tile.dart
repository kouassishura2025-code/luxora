import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/membership.dart';

/// Tuile d'un avantage (perk).
class PerkTile extends StatelessWidget {
  const PerkTile({super.key, required this.perk, required this.isLocked});

  final Perk perk;
  final bool isLocked;

  @override
  Widget build(BuildContext context) {
    final color =
        isLocked ? LuxoraColors.textTertiary : LuxoraColors.textPrimary;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 12),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: isLocked
                  ? LuxoraColors.graphite
                  : LuxoraColors.champagne.withOpacity(0.12),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              perk.icon,
              size: 18,
              color: isLocked
                  ? LuxoraColors.textTertiary
                  : LuxoraColors.champagne,
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        perk.title,
                        style: LuxoraTextStyles.labelLarge.copyWith(
                          fontSize: 14,
                          color: color,
                        ),
                      ),
                    ),
                    if (isLocked)
                      const Icon(
                        Icons.lock_outline_rounded,
                        size: 14,
                        color: LuxoraColors.textTertiary,
                      ),
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  perk.description,
                  style: LuxoraTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: isLocked
                        ? LuxoraColors.textTertiary
                        : LuxoraColors.textSecondary,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
