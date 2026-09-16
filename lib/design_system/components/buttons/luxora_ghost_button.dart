import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Bouton fantôme LUXORA — contour or, fond transparent.
///
/// Pour les actions secondaires qui méritent un peu plus de présence
/// qu'un simple lien texte.
class LuxoraGhostButton extends StatelessWidget {
  const LuxoraGhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;

  @override
  Widget build(BuildContext context) {
    final button = OutlinedButton(
      onPressed: onPressed,
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(56),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        side: BorderSide(
          color: onPressed != null
              ? LuxoraColors.champagne.withOpacity(0.5)
              : LuxoraColors.divider,
          width: 1,
        ),
        shape: const RoundedRectangleBorder(borderRadius: LuxoraRadii.brMd),
        foregroundColor: LuxoraColors.champagne,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 18, color: LuxoraColors.champagne),
            const SizedBox(width: 10),
          ],
          Text(
            label,
            style: LuxoraTextStyles.buttonLabel.copyWith(
              color: LuxoraColors.champagne,
            ),
          ),
        ],
      ),
    );

    return expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
