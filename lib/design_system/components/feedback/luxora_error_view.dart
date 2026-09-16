import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/typography/luxora_text_styles.dart';
import '../buttons/luxora_ghost_button.dart';
import '../buttons/luxora_primary_button.dart';

/// Vue d'erreur LUXORA — ton feutré, jamais criard.
class LuxoraErrorView extends StatelessWidget {
  const LuxoraErrorView({
    super.key,
    this.title = 'Une erreur est survenue.',
    this.message =
        'Nous n\'avons pas pu charger cette information. Réessayez.',
    this.onRetry,
    this.onBack,
  });

  final String title;
  final String message;
  final VoidCallback? onRetry;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LuxoraColors.error.withOpacity(0.12),
                border: Border.all(
                  color: LuxoraColors.error.withOpacity(0.4),
                  width: 0.8,
                ),
              ),
              child: Icon(
                Icons.error_outline_rounded,
                size: 28,
                color: LuxoraColors.error,
              ),
            ),
            const SizedBox(height: 28),
            Text(
              title,
              style: LuxoraTextStyles.titleMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 10),
            Text(
              message,
              style: LuxoraTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 32),
            if (onRetry != null)
              LuxoraPrimaryButton(
                label: 'Réessayer',
                icon: Icons.refresh_rounded,
                onPressed: onRetry,
              ),
            if (onBack != null) ...[
              const SizedBox(height: 12),
              LuxoraGhostButton(
                label: 'Retour',
                onPressed: onBack,
              ),
            ],
          ],
        ),
      ),
    );
  }
}
