import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Bouton texte discret LUXORA.
///
/// Utilisé pour les actions secondaires : "Passer", "Annuler", "Modifier".
class LuxoraTextButton extends StatelessWidget {
  const LuxoraTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  Widget build(BuildContext context) {
    return TextButton(
      onPressed: onPressed,
      style: TextButton.styleFrom(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
        minimumSize: Size.zero,
        tapTargetSize: MaterialTapTargetSize.shrinkWrap,
        foregroundColor: LuxoraColors.champagne,
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (icon != null) ...[
            Icon(icon, size: 16, color: LuxoraColors.champagne),
            const SizedBox(width: 6),
          ],
          Text(
            label,
            style: LuxoraTextStyles.labelMedium.copyWith(
              color: LuxoraColors.champagne,
            ),
          ),
        ],
      ),
    );
  }
}
