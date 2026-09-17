import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/motion/luxora_haptics.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';
import '../buttons/luxora_ghost_button.dart';
import '../buttons/luxora_primary_button.dart';

/// Dialog signature LUXORA.
abstract final class LuxoraDialog {
  static Future<bool?> show({
    required BuildContext context,
    required String title,
    required String message,
    String confirmLabel = 'Confirmer',
    String cancelLabel = 'Annuler',
    bool destructive = false,
    String? overline,
  }) {
    return showDialog<bool>(
      context: context,
      barrierColor: LuxoraColors.obsidian.withOpacity(0.8),
      builder: (context) => Dialog(
        backgroundColor: LuxoraColors.charcoal,
        shape: RoundedRectangleBorder(
          borderRadius: LuxoraRadii.brXl,
          side: const BorderSide(
            color: LuxoraColors.dividerGold,
            width: 0.5,
          ),
        ),
        insetPadding: const EdgeInsets.symmetric(horizontal: 32),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              if (overline != null) ...[
                Text(
                  overline.toUpperCase(),
                  style: LuxoraTextStyles.overline,
                ),
                const SizedBox(height: 12),
              ],
              Text(title, style: LuxoraTextStyles.titleLarge),
              const SizedBox(height: 12),
              Text(message, style: LuxoraTextStyles.bodyMedium),
              const SizedBox(height: 28),
              Row(
                children: [
                  Expanded(
                    child: LuxoraGhostButton(
                      label: cancelLabel,
                      onPressed: () {
                        LuxoraHaptics.light();
                        Navigator.of(context).pop(false);
                      },
                    ),
                  ),
                  const SizedBox(width: 12),
                  Expanded(
                    child: LuxoraPrimaryButton(
                      label: confirmLabel,
                      onPressed: () {
                        LuxoraHaptics.heavy();
                        Navigator.of(context).pop(true);
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
