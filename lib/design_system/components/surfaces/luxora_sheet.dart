import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Bottom sheet signature LUXORA.
abstract final class LuxoraSheet {
  /// Affiche un bottom sheet avec poignée dorée.
  static Future<T?> show<T>({
    required BuildContext context,
    required Widget child,
    String? title,
    bool isScrollControlled = true,
  }) {
    return showModalBottomSheet<T>(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: isScrollControlled,
      barrierColor: LuxoraColors.obsidian.withOpacity(0.7),
      builder: (context) => Container(
        decoration: const BoxDecoration(
          color: LuxoraColors.charcoal,
          borderRadius: BorderRadius.vertical(top: LuxoraRadii.xl),
        ),
        padding: const EdgeInsets.only(top: 12),
        child: SafeArea(
          top: false,
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              // ─── Poignée ──────────────────────────────
              Center(
                child: Container(
                  width: 40,
                  height: 4,
                  decoration: BoxDecoration(
                    color: LuxoraColors.champagne.withOpacity(0.5),
                    borderRadius: LuxoraRadii.brPill,
                  ),
                ),
              ),

              if (title != null) ...[
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24),
                  child: Text(
                    title,
                    style: LuxoraTextStyles.titleMedium,
                  ),
                ),
              ],

              const SizedBox(height: 16),
              Padding(
                padding: const EdgeInsets.fromLTRB(24, 0, 24, 24),
                child: child,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
