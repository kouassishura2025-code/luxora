import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/booking_entities.dart';

/// Carte showcase d'une classe de véhicule.
class VehicleShowcaseCard extends StatelessWidget {
  const VehicleShowcaseCard({
    super.key,
    required this.vehicle,
    required this.selected,
    required this.onTap,
    required this.estimateLabel,
  });

  final VehicleClass vehicle;
  final bool selected;
  final VoidCallback onTap;
  final String estimateLabel;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: LuxoraRadii.brLg,
        splashColor: LuxoraColors.champagne.withOpacity(0.08),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 220),
          curve: Curves.easeOutCubic,
          padding: const EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: selected
                ? LuxoraColors.charcoal
                : LuxoraColors.charcoal.withOpacity(0.5),
            borderRadius: LuxoraRadii.brLg,
            border: Border.all(
              color: selected
                  ? LuxoraColors.champagne
                  : LuxoraColors.divider,
              width: selected ? 1 : 0.5,
            ),
            boxShadow: selected
                ? [
                    BoxShadow(
                      color: LuxoraColors.champagne.withOpacity(0.15),
                      blurRadius: 24,
                      spreadRadius: -4,
                    ),
                  ]
                : null,
          ),
          child: Row(
            children: [
              // ─── Icône ───────────────────────────────────
              Container(
                width: 56,
                height: 56,
                decoration: BoxDecoration(
                  color: LuxoraColors.graphite,
                  borderRadius: LuxoraRadii.brMd,
                ),
                child: Icon(
                  vehicle.icon,
                  size: 26,
                  color: selected
                      ? LuxoraColors.champagne
                      : LuxoraColors.textSecondary,
                ),
              ),

              const SizedBox(width: 16),

              // ─── Infos ──────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text(
                          vehicle.name,
                          style: LuxoraTextStyles.titleMedium.copyWith(
                            fontSize: 18,
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '· ${vehicle.capacity} places',
                          style: LuxoraTextStyles.bodySmall.copyWith(
                            fontSize: 12,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 4),
                    Text(
                      vehicle.tagline,
                      style: LuxoraTextStyles.bodySmall.copyWith(
                        color: LuxoraColors.textTertiary,
                        fontSize: 12,
                        fontStyle: FontStyle.italic,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(
                          Icons.access_time_rounded,
                          size: 11,
                          color: LuxoraColors.textTertiary,
                        ),
                        const SizedBox(width: 4),
                        Text(
                          '${vehicle.eta} min',
                          style: LuxoraTextStyles.bodySmall.copyWith(
                            fontSize: 11,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),

              // ─── Prix ────────────────────────────────────
              Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    estimateLabel,
                    style: LuxoraTextStyles.titleMedium.copyWith(
                      fontSize: 18,
                      color: selected
                          ? LuxoraColors.champagne
                          : LuxoraColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'estimé',
                    style: LuxoraTextStyles.caption.copyWith(
                      fontSize: 10,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
