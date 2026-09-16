import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/onboarding_slide.dart';

/// Contenu d'une slide d'onboarding LUXORA.
class OnboardingSlideCard extends StatelessWidget {
  const OnboardingSlideCard({
    super.key,
    required this.slide,
  });

  final OnboardingSlide slide;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisSize: MainAxisSize.min,
        children: [
          // ─── Icône dans un cercle doré ──────────────────
          Container(
            width: 88,
            height: 88,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(
                color: LuxoraColors.champagne.withOpacity(0.35),
                width: 0.8,
              ),
            ),
            child: Center(
              child: Icon(
                slide.icon,
                size: 34,
                color: LuxoraColors.champagne,
              ),
            ),
          ),

          const SizedBox(height: 48),

          // ─── Overline ──────────────────────────────────
          Text(
            slide.overline,
            style: LuxoraTextStyles.overline,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // ─── Titre ─────────────────────────────────────
          Text(
            slide.title,
            style: LuxoraTextStyles.displayMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          // ─── Trait doré fin ────────────────────────────
          Container(
            width: 32,
            height: 0.5,
            color: LuxoraColors.champagne,
          ),

          const SizedBox(height: 24),

          // ─── Sous-titre ─────────────────────────────────
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              slide.subtitle,
              style: LuxoraTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }
}
