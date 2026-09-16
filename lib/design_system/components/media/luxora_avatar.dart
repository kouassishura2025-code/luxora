import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';

/// Avatar premium LUXORA.
///
/// Affiche les initiales en or sur fond charcoal.
/// Optionnellement, une bordure or fine.
class LuxoraAvatar extends StatelessWidget {
  const LuxoraAvatar({
    super.key,
    required this.initials,
    this.size = 44,
    this.goldBorder = false,
    this.onTap,
  });

  final String initials;
  final double size;
  final bool goldBorder;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          color: LuxoraColors.charcoal,
          shape: BoxShape.circle,
          border: goldBorder
              ? Border.all(
                  color: LuxoraColors.champagne.withOpacity(0.4),
                  width: 0.8,
                )
              : null,
        ),
        child: Center(
          child: Text(
            initials,
            style: TextStyle(
              fontFamily: 'Manrope',
              fontSize: size * 0.32,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.8,
              color: LuxoraColors.champagne,
            ),
          ),
        ),
      ),
    );
  }
}
