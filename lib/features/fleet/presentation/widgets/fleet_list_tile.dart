import 'package:flutter/material.dart';

import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/fleet_vehicle.dart';

/// Tuile compacte pour la liste flotte.
class FleetListTile extends StatelessWidget {
  const FleetListTile({
    super.key,
    required this.vehicle,
    required this.onTap,
  });

  final FleetVehicle vehicle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LuxoraCard(
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          // ─── Icône gradient ──────────────────────────
          Container(
            width: 56,
            height: 56,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: vehicle.gradientColors,
              ),
              borderRadius: BorderRadius.circular(14),
            ),
            child: Icon(
              vehicle.icon,
              size: 24,
              color: LuxoraColors.champagne,
            ),
          ),

          const SizedBox(width: 14),

          // ─── Infos ────────────────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  vehicle.name,
                  style: LuxoraTextStyles.labelLarge.copyWith(fontSize: 15),
                ),
                const SizedBox(height: 3),
                Text(
                  vehicle.model,
                  style: LuxoraTextStyles.bodySmall.copyWith(fontSize: 12),
                ),
                const SizedBox(height: 6),
                Text(
                  'À partir de ${vehicle.basePrice.toStringAsFixed(0)} €',
                  style: LuxoraTextStyles.caption.copyWith(
                    fontSize: 11,
                    color: LuxoraColors.champagne,
                  ),
                ),
              ],
            ),
          ),

          const Icon(
            Icons.arrow_forward_ios_rounded,
            size: 12,
            color: LuxoraColors.textTertiary,
          ),
        ],
      ),
    );
  }
}
