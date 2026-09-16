import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../providers/home_provider.dart';

/// Liste des destinations récentes.
class RecentDestinations extends StatelessWidget {
  const RecentDestinations({
    super.key,
    required this.destinations,
    required this.onTap,
  });

  final List<RecentDestination> destinations;
  final void Function(RecentDestination) onTap;

  @override
  Widget build(BuildContext context) {
    if (destinations.isEmpty) {
      return Padding(
        padding: const EdgeInsets.symmetric(vertical: 24),
        child: Center(
          child: Text(
            'Aucune destination récente',
            style: LuxoraTextStyles.bodyMedium,
          ),
        ),
      );
    }

    return Column(
      children: [
        for (var i = 0; i < destinations.length; i++) ...[
          _DestinationTile(
            destination: destinations[i],
            onTap: () => onTap(destinations[i]),
          ),
          if (i != destinations.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _DestinationTile extends StatelessWidget {
  const _DestinationTile({
    required this.destination,
    required this.onTap,
  });

  final RecentDestination destination;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: LuxoraRadii.brMd,
        splashColor: LuxoraColors.champagne.withOpacity(0.08),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brMd,
          ),
          child: Row(
            children: [
              // ─── Icône ──────────────────────────────────
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: LuxoraColors.graphite,
                  borderRadius: LuxoraRadii.brSm,
                ),
                child: Icon(
                  destination.icon,
                  size: 18,
                  color: LuxoraColors.champagne,
                ),
              ),

              const SizedBox(width: 14),

              // ─── Infos ──────────────────────────────────
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      destination.label,
                      style: LuxoraTextStyles.labelLarge.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${destination.relativeTime} · ${destination.priceLabel}',
                      style: LuxoraTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                      ),
                    ),
                  ],
                ),
              ),

              // ─── Flèche ─────────────────────────────────
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 12,
                color: LuxoraColors.textTertiary,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
