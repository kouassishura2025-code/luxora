import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/user_profile.dart';

/// Badge du niveau d'adhésion (Silver / Gold / Black).
class TierBadge extends StatelessWidget {
  const TierBadge({super.key, required this.tier});

  final MemberTier tier;

  @override
  Widget build(BuildContext context) {
    final (bg, border, fg, icon) = switch (tier) {
      MemberTier.silver => (
          const Color(0xFF1F1F23),
          const Color(0xFFC0C0C0).withOpacity(0.3),
          const Color(0xFFC0C0C0),
          Icons.workspace_premium_outlined,
        ),
      MemberTier.gold => (
          LuxoraColors.champagne.withOpacity(0.15),
          LuxoraColors.champagne.withOpacity(0.4),
          LuxoraColors.champagne,
          Icons.workspace_premium_rounded,
        ),
      MemberTier.black => (
          const Color(0xFF000000),
          LuxoraColors.champagne.withOpacity(0.6),
          LuxoraColors.champagne,
          Icons.diamond_outlined,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 7),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: border, width: 0.8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: fg),
          const SizedBox(width: 8),
          Text(
            'MEMBRE ${tier.label.toUpperCase()}',
            style: LuxoraTextStyles.caption.copyWith(
              color: fg,
              fontSize: 9,
              letterSpacing: 1.6,
            ),
          ),
        ],
      ),
    );
  }
}
