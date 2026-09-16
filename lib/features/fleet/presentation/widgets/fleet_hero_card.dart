import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/fleet_vehicle.dart';

/// Carte héro du catalogue flotte.
class FleetHeroCard extends StatelessWidget {
  const FleetHeroCard({
    super.key,
    required this.vehicle,
    required this.onTap,
  });

  final FleetVehicle vehicle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: LuxoraRadii.brXl,
        child: Container(
          height: 240,
          decoration: BoxDecoration(
            borderRadius: LuxoraRadii.brXl,
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: vehicle.gradientColors,
            ),
            border: Border.all(
              color: LuxoraColors.champagne.withOpacity(0.25),
              width: 0.5,
            ),
          ),
          child: Stack(
            children: [
              // ─── Icône en filigrane ────────────────────
              Positioned(
                right: -20,
                bottom: -20,
                child: Icon(
                  vehicle.icon,
                  size: 180,
                  color: LuxoraColors.champagne.withOpacity(0.06),
                ),
              ),

              // ─── Contenu ──────────────────────────────
              Padding(
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Overline
                    Text(
                      vehicle.name.toUpperCase(),
                      style: LuxoraTextStyles.overline.copyWith(
                        fontSize: 10,
                        letterSpacing: 3,
                      ),
                    ),

                    const Spacer(),

                    // Modèle
                    Text(
                      vehicle.model,
                      style: LuxoraTextStyles.titleLarge,
                    ),

                    const SizedBox(height: 6),

                    Text(
                      vehicle.tagline,
                      style: LuxoraTextStyles.bodyMedium.copyWith(
                        fontStyle: FontStyle.italic,
                        color: LuxoraColors.textSecondary,
                      ),
                    ),

                    const SizedBox(height: 20),

                    // Prix + CTA
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'À PARTIR DE',
                              style: LuxoraTextStyles.caption.copyWith(
                                fontSize: 8,
                                color: LuxoraColors.textTertiary,
                                letterSpacing: 1.6,
                              ),
                            ),
                            const SizedBox(height: 2),
                            Text(
                              '${vehicle.basePrice.toStringAsFixed(0)} €',
                              style: LuxoraTextStyles.titleMedium.copyWith(
                                fontSize: 22,
                                color: LuxoraColors.champagne,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 10,
                          ),
                          decoration: BoxDecoration(
                            color: LuxoraColors.champagne.withOpacity(0.15),
                            borderRadius: LuxoraRadii.brPill,
                            border: Border.all(
                              color: LuxoraColors.champagne.withOpacity(0.4),
                              width: 0.8,
                            ),
                          ),
                          child: Row(
                            children: [
                              Text(
                                'Découvrir',
                                style: LuxoraTextStyles.labelMedium.copyWith(
                                  fontSize: 12,
                                  color: LuxoraColors.champagne,
                                ),
                              ),
                              const SizedBox(width: 6),
                              const Icon(
                                Icons.arrow_forward_rounded,
                                size: 14,
                                color: LuxoraColors.champagne,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
