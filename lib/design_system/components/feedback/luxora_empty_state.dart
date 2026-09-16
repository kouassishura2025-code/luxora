import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// État vide signature LUXORA — icône cerclée d'or, ton feutré.
class LuxoraEmptyState extends StatelessWidget {
  const LuxoraEmptyState({
    super.key,
    required this.icon,
    required this.title,
    required this.message,
    this.actionLabel,
    this.onAction,
  });

  final IconData icon;
  final String title;
  final String message;
  final String? actionLabel;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 88,
              height: 88,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: LuxoraColors.champagne.withOpacity(0.3),
                  width: 0.8,
                ),
              ),
              child: Center(
                child: Icon(
                  icon,
                  size: 32,
                  color: LuxoraColors.champagne,
                ),
              ),
            ),
            const SizedBox(height: 32),
            Text(
              title,
              style: LuxoraTextStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 12),
            Text(
              message,
              style: LuxoraTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            if (actionLabel != null) ...[
              const SizedBox(height: 32),
              GestureDetector(
                onTap: onAction,
                child: Text(
                  actionLabel!,
                  style: LuxoraTextStyles.labelLarge.copyWith(
                    color: LuxoraColors.champagne,
                  ),
                ),
              ),
            ],
          ],
        ),
      ),
    );
  }
}
