import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Tag LUXORA — petite étiquette dorée ou neutre.
class LuxoraTag extends StatelessWidget {
  const LuxoraTag({
    super.key,
    required this.label,
    this.icon,
    this.variant = LuxoraTagVariant.gold,
  });

  final String label;
  final IconData? icon;
  final LuxoraTagVariant variant;

  @override
  Widget build(BuildContext context) {
    final (bg, border, fg) = switch (variant) {
      LuxoraTagVariant.gold => (
          LuxoraColors.champagne.withOpacity(0.12),
          LuxoraColors.champagne.withOpacity(0.3),
          LuxoraColors.champagne,
        ),
      LuxoraTagVariant.neutral => (
          LuxoraColors.graphite,
          LuxoraColors.divider,
          LuxoraColors.textSecondary,
        ),
      LuxoraTagVariant.success => (
          LuxoraColors.success.withOpacity(0.15),
          LuxoraColors.success.withOpacity(0.3),
          LuxoraColors.success,
        ),
    };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: bg,
        borderRadius: LuxoraRadii.brPill,
        border: Border.all(color: border, width: 0.5),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 10, color: fg),
            const SizedBox(width: 5),
          ],
          Text(
            label,
            style: LuxoraTextStyles.caption.copyWith(
              color: fg,
              fontSize: 9,
              letterSpacing: 1.4,
            ),
          ),
        ],
      ),
    );
  }
}

enum LuxoraTagVariant { gold, neutral, success }
