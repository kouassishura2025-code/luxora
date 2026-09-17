import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../loaders/luxora_shimmer.dart';

/// Overlay de chargement LUXORA.
///
/// Affiche un fond semi-transparent + le loader signature au centre.
class LuxoraLoadingOverlay extends StatelessWidget {
  const LuxoraLoadingOverlay({
    super.key,
    this.message,
    this.backgroundColor,
  });

  final String? message;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Container(
        color: backgroundColor ?? LuxoraColors.obsidian.withOpacity(0.75),
        child: Center(
          child: const LuxoraShimmer(
            child: SizedBox(
              width: 32,
              height: 32,
              child: CircularProgressIndicator(
                strokeWidth: 2,
                color: LuxoraColors.champagne,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
