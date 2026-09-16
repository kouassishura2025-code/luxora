import 'package:flutter/material.dart';

import '../foundations/colors/luxora_colors.dart';

/// Layout pour les écrans d'authentification.
///
/// Fond obsidienne + halo doré subtil en haut à droite.
class LuxoraAuthLayout extends StatelessWidget {
  const LuxoraAuthLayout({
    super.key,
    required this.child,
    this.showHalo = true,
  });

  final Widget child;
  final bool showHalo;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LuxoraColors.obsidian,
      child: Stack(
        children: [
          if (showHalo)
            Positioned(
              top: -100,
              right: -100,
              child: IgnorePointer(
                child: Container(
                  width: 300,
                  height: 300,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: RadialGradient(
                      colors: [
                        LuxoraColors.champagne.withOpacity(0.08),
                        Colors.transparent,
                      ],
                    ),
                  ),
                ),
              ),
            ),
          SafeArea(child: child),
        ],
      ),
    );
  }
}
