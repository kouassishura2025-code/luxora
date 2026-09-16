import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';

/// Carte signature LUXORA.
///
/// Fond `charcoal`, coins amples, aucune ombre.
/// Optionnellement, une bordure or hairline pour les cartes premium.
class LuxoraCard extends StatelessWidget {
  const LuxoraCard({
    super.key,
    required this.child,
    this.padding = const EdgeInsets.all(20),
    this.goldBorder = false,
    this.onTap,
    this.color,
    this.borderRadius,
  });

  final Widget child;
  final EdgeInsetsGeometry padding;
  final bool goldBorder;
  final VoidCallback? onTap;
  final Color? color;
  final BorderRadius? borderRadius;

  @override
  Widget build(BuildContext context) {
    final radius = borderRadius ?? LuxoraRadii.brLg;

    final content = Container(
      padding: padding,
      decoration: BoxDecoration(
        color: color ?? LuxoraColors.charcoal,
        borderRadius: radius,
        border: goldBorder
            ? Border.all(color: LuxoraColors.dividerGold, width: 0.5)
            : null,
      ),
      child: child,
    );

    if (onTap == null) return content;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: radius,
        splashColor: LuxoraColors.champagne.withOpacity(0.08),
        highlightColor: LuxoraColors.champagne.withOpacity(0.04),
        child: content,
      ),
    );
  }
}
