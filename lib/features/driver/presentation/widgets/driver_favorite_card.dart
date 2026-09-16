import 'package:flutter/material.dart';

import '../../../../design_system/components/media/luxora_avatar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/driver.dart';

/// Carte d'un chauffeur favori.
class DriverFavoriteCard extends StatelessWidget {
  const DriverFavoriteCard({
    super.key,
    required this.driver,
    required this.onTap,
    required this.onToggleFavorite,
    this.isRemoving = false,
  });

  final Driver driver;
  final VoidCallback onTap;
  final VoidCallback onToggleFavorite;
  final bool isRemoving;

  @override
  Widget build(BuildContext context) {
    final isAvailable = driver.status == DriverStatus.available;
    final isOnRide = driver.status == DriverStatus.onRide;

    final statusColor = isAvailable
        ? LuxoraColors.success
        : isOnRide
            ? LuxoraColors.champagne
            : LuxoraColors.textTertiary;

    return AnimatedOpacity(
      duration: const Duration(milliseconds: 300),
      opacity: isRemoving ? 0.3 : 1.0,
      child: LuxoraCard(
        padding: const EdgeInsets.all(16),
        onTap: isRemoving ? null : onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Avatar ──────────────────────────────
            LuxoraAvatar(
              initials: driver.initials,
              size: 52,
              goldBorder: true,
            ),

            const SizedBox(width: 14),

            // ─── Infos ───────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Nom + note
                  Row(
                    children: [
                      Expanded(
                        child: Text(
                          driver.displayName,
                          style: LuxoraTextStyles.labelLarge.copyWith(
                            fontSize: 15,
                          ),
                        ),
                      ),
                      const Icon(
                        Icons.star_rounded,
                        size: 14,
                        color: LuxoraColors.champagne,
                      ),
                      const SizedBox(width: 4),
                      Text(
                        driver.rating.toStringAsFixed(2),
                        style: LuxoraTextStyles.labelMedium.copyWith(
                          fontSize: 12,
                          color: LuxoraColors.champagne,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 4),

                  // Véhicule
                  Text(
                    driver.vehicleModel,
                    style: LuxoraTextStyles.bodySmall.copyWith(fontSize: 12),
                  ),

                  const SizedBox(height: 8),

                  // Stats + statut
                  Row(
                    children: [
                      // Statut (point coloré)
                      Container(
                        width: 6,
                        height: 6,
                        decoration: BoxDecoration(
                          color: statusColor,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        driver.status.label,
                        style: LuxoraTextStyles.caption.copyWith(
                          fontSize: 10,
                          color: statusColor,
                        ),
                      ),
                      const SizedBox(width: 12),
                      Container(
                        width: 1,
                        height: 10,
                        color: LuxoraColors.divider,
                      ),
                      const SizedBox(width: 12),
                      Text(
                        '${driver.tripCount} courses',
                        style: LuxoraTextStyles.caption.copyWith(
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '·',
                        style: LuxoraTextStyles.caption.copyWith(
                          fontSize: 10,
                        ),
                      ),
                      const SizedBox(width: 8),
                      Text(
                        '${driver.yearsOfService} ans',
                        style: LuxoraTextStyles.caption.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(width: 8),

            // ─── Bouton favori ───────────────────────
            IconButton(
              icon: Icon(
                driver.isFavorite
                    ? Icons.star_rounded
                    : Icons.star_outline_rounded,
                size: 20,
                color: driver.isFavorite
                    ? LuxoraColors.champagne
                    : LuxoraColors.textTertiary,
              ),
              onPressed: isRemoving ? null : onToggleFavorite,
              tooltip: driver.isFavorite
                  ? 'Retirer des favoris'
                  : 'Ajouter aux favoris',
            ),
          ],
        ),
      ),
    );
  }
}
