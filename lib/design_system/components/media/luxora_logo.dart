import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Variante d'affichage du logo LUXORA.
enum LuxoraLogoVariant {
  /// Monogramme cerclé (par défaut, pour splash et welcome).
  full,

  /// Monogramme minimal (icône app).
  monogram,

  /// Wordmark horizontal (header).
  wordmark,
}

/// Logo LUXORA signature.
///
/// ## Exemples
/// ```dart
/// // Logo principal (cerclé)
/// LuxoraLogo(size: 120)
///
/// // Avec wordmark en dessous
/// LuxoraLogo(size: 100, showWordmark: true)
///
/// // Wordmark horizontal (header)
/// LuxoraLogo(variant: LuxoraLogoVariant.wordmark, size: 180)
///
/// // Version blanche (sur fond clair)
/// LuxoraLogo(size: 80, goldAccent: false)
/// ```
class LuxoraLogo extends StatelessWidget {
  const LuxoraLogo({
    super.key,
    this.size = 80,
    this.variant = LuxoraLogoVariant.full,
    this.showWordmark = false,
    this.goldAccent = true,
  });

  /// Taille de référence (côté du carré).
  final double size;

  /// Variante du logo.
  final LuxoraLogoVariant variant;

  /// Afficher "LUXORA" sous le monogramme.
  final bool showWordmark;

  /// Or (true) ou blanc (false).
  final bool goldAccent;

  String get _assetPath {
    switch (variant) {
      case LuxoraLogoVariant.full:
        return 'assets/icons/logo/luxora_logo.svg';
      case LuxoraLogoVariant.monogram:
        return 'assets/icons/logo/luxora_monogram.svg';
      case LuxoraLogoVariant.wordmark:
        return 'assets/icons/logo/luxora_wordmark.svg';
    }
  }

  @override
  Widget build(BuildContext context) {
    final colorFilter = goldAccent
        ? null
        : const ColorFilter.mode(
            LuxoraColors.textPrimary,
            BlendMode.srcIn,
          );

    if (variant == LuxoraLogoVariant.wordmark) {
      return SvgPicture.asset(
        _assetPath,
        width: size * 2.5,
        height: size * 0.5,
        colorFilter: colorFilter,
      );
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        SvgPicture.asset(
          _assetPath,
          width: size,
          height: size,
          colorFilter: colorFilter,
        ),
        if (showWordmark) ...[
          SizedBox(height: size * 0.12),
          Text(
            'LUXORA',
            style: LuxoraTextStyles.displayMedium.copyWith(
              fontSize: size * 0.24,
              letterSpacing: size * 0.05,
              color: goldAccent
                  ? LuxoraColors.champagne
                  : LuxoraColors.textPrimary,
            ),
          ),
        ],
      ],
    );
  }
}
