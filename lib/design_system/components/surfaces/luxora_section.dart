import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Section avec titre overline + contenu.
class LuxoraSection extends StatelessWidget {
  const LuxoraSection({
    super.key,
    required this.title,
    required this.child,
    this.action,
    this.onAction,
    this.padding = EdgeInsets.zero,
  });

  final String title;
  final Widget child;
  final String? action;
  final VoidCallback? onAction;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ─── En-tête ──────────────────────────────────
          Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Text(
                title.toUpperCase(),
                style: LuxoraTextStyles.overline.copyWith(
                  fontSize: 10,
                  letterSpacing: 2.4,
                  color: LuxoraColors.textSecondary,
                ),
              ),
              const Spacer(),
              if (action != null)
                GestureDetector(
                  onTap: onAction,
                  child: Text(
                    action!,
                    style: LuxoraTextStyles.labelMedium.copyWith(
                      fontSize: 12,
                      color: LuxoraColors.champagne,
                    ),
                  ),
                ),
            ],
          ),
          const SizedBox(height: 16),
          child,
        ],
      ),
    );
  }
}
