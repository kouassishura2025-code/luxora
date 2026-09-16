import 'package:flutter/material.dart';

import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/elevation/luxora_shadows.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Carte héro "Réserver" — le CTA principal de la Home.
///
/// Bordure or fine + halo doré subtil.
class BookingHeroCard extends StatelessWidget {
  const BookingHeroCard({
    super.key,
    required this.overline,
    required this.title,
    required this.subtitle,
    required this.ctaLabel,
    required this.onTap,
  });

  final String overline;
  final String title;
  final String subtitle;
  final String ctaLabel;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: LuxoraColors.charcoal,
        borderRadius: LuxoraRadii.brXl,
        border: Border.all(
          color: LuxoraColors.champagne.withOpacity(0.35),
          width: 0.8,
        ),
        boxShadow: LuxoraShadows.goldGlow,
      ),
      padding: const EdgeInsets.fromLTRB(24, 24, 24, 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ─── Overline ────────────────────────────────────
          Row(
            children: [
              Container(
                width: 6,
                height: 6,
                decoration: const BoxDecoration(
                  color: LuxoraColors.champagne,
                  shape: BoxShape.circle,
                ),
              ),
              const SizedBox(width: 10),
              Text(
                overline.toUpperCase(),
                style: LuxoraTextStyles.overline.copyWith(
                  fontSize: 10,
                  letterSpacing: 2.2,
                ),
              ),
            ],
          ),

          const SizedBox(height: 16),

          // ─── Titre ───────────────────────────────────────
          Text(
            title,
            style: LuxoraTextStyles.displayMedium.copyWith(
              fontSize: 26,
            ),
          ),

          const SizedBox(height: 10),

          // ─── Sous-titre ──────────────────────────────────
          Text(
            subtitle,
            style: LuxoraTextStyles.bodyMedium,
          ),

          const SizedBox(height: 24),

          // ─── CTA ─────────────────────────────────────────
          LuxoraPrimaryButton(
            label: ctaLabel,
            onPressed: onTap,
            icon: Icons.arrow_forward_rounded,
          ),
        ],
      ),
    );
  }
}
