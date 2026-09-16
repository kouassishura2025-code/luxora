import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';

/// Bouton icône LUXORA — rond, discret, doré.
class LuxoraIconButton extends StatelessWidget {
  const LuxoraIconButton({
    super.key,
    required this.icon,
    required this.onPressed,
    this.size = 44,
    this.iconSize = 20,
    this.variant = LuxoraIconButtonVariant.ghost,
    this.tooltip,
  });

  final IconData icon;
  final VoidCallback? onPressed;
  final double size;
  final double iconSize;
  final LuxoraIconButtonVariant variant;
  final String? tooltip;

  @override
  Widget build(BuildContext context) {
    final isEnabled = onPressed != null;

    final bgColor = switch (variant) {
      LuxoraIconButtonVariant.filled => LuxoraColors.champagne,
      LuxoraIconButtonVariant.ghost => Colors.transparent,
      LuxoraIconButtonVariant.outlined => Colors.transparent,
    };

    final border = variant == LuxoraIconButtonVariant.outlined
        ? Border.all(
            color: isEnabled
                ? LuxoraColors.champagne.withOpacity(0.4)
                : LuxoraColors.divider,
            width: 0.8,
          )
        : null;

    final iconColor = switch (variant) {
      LuxoraIconButtonVariant.filled => LuxoraColors.obsidian,
      LuxoraIconButtonVariant.ghost ||
      LuxoraIconButtonVariant.outlined =>
        isEnabled ? LuxoraColors.champagne : LuxoraColors.textDisabled,
    };

    final button = Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: isEnabled ? onPressed : null,
        borderRadius: BorderRadius.circular(size / 2),
        splashColor: LuxoraColors.champagne.withOpacity(0.1),
        highlightColor: LuxoraColors.champagne.withOpacity(0.05),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            color: bgColor,
            shape: BoxShape.circle,
            border: border,
          ),
          child: Center(
            child: Icon(icon, size: iconSize, color: iconColor),
          ),
        ),
      ),
    );

    if (tooltip != null) {
      return Tooltip(message: tooltip!, child: button);
    }
    return button;
  }
}

enum LuxoraIconButtonVariant { ghost, filled, outlined }
