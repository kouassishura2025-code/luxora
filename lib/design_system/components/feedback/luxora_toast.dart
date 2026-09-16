import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Toast discret LUXORA — apparaît en haut de l'écran.
///
/// Règle LUXORA : un toast n'est utilisé que si l'information
/// ne peut pas être communiquée autrement (ex : confirmation silencieuse).
abstract final class LuxoraToast {
  static void show(
    BuildContext context, {
    required String message,
    LuxoraToastVariant variant = LuxoraToastVariant.neutral,
  }) {
    final messenger = ScaffoldMessenger.of(context);
    messenger.clearSnackBars();

    final color = switch (variant) {
      LuxoraToastVariant.neutral => LuxoraColors.graphite,
      LuxoraToastVariant.success => LuxoraColors.success,
      LuxoraToastVariant.error => LuxoraColors.error,
    };

    final icon = switch (variant) {
      LuxoraToastVariant.neutral => Icons.info_outline_rounded,
      LuxoraToastVariant.success => Icons.check_circle_outline_rounded,
      LuxoraToastVariant.error => Icons.error_outline_rounded,
    };

    messenger.showSnackBar(
      SnackBar(
        behavior: SnackBarBehavior.floating,
        backgroundColor: color,
        elevation: 0,
        margin: const EdgeInsets.all(16),
        shape: const RoundedRectangleBorder(borderRadius: LuxoraRadii.brMd),
        content: Row(
          children: [
            Icon(icon, color: LuxoraColors.ivory, size: 20),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                message,
                style: LuxoraTextStyles.bodyMedium.copyWith(
                  color: LuxoraColors.ivory,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

enum LuxoraToastVariant { neutral, success, error }
