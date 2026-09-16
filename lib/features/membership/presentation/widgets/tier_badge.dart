import 'package:flutter/material.dart';

import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/membership.dart';

/// Badge du niveau d'adhésion.
class TierBadge extends StatelessWidget {
  const TierBadge({super.key, required this.tier});

  final MembershipTier tier;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: tier.gradient.last,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(
          color: tier.accent.withOpacity(0.4),
          width: 0.8,
        ),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(tier.icon, size: 12, color: tier.accent),
          const SizedBox(width: 8),
          Text(
            tier.label.toUpperCase(),
            style: LuxoraTextStyles.caption.copyWith(
              color: tier.accent,
              fontSize: 9,
              letterSpacing: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
