import 'package:flutter/material.dart';

import '../../../../design_system/components/animations/luxora_list_animation.dart';
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
          LuxoraListAnimation(
            index: i,
            child: _DestinationTile(
              destination: destinations[i],
              onTap: () => onTap(destinations[i]),
            ),
          ),
          if (i != destinations.length - 1) const SizedBox(height: 10),
        ],
      ],
    );
  }
}

class _DestinationTile extends StatefulWidget {
  const _DestinationTile({
    required this.destination,
    required this.onTap,
  });

  final RecentDestination destination;
  final VoidCallback onTap;

  @override
  State<_DestinationTile> createState() => _DestinationTileState();
}

class _DestinationTileState extends State<_DestinationTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: const Duration(milliseconds: 120),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
          decoration: BoxDecoration(
            color: LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brMd,
          ),
          child: Row(
            children: [
              Container(
                width: 40,
                height: 40,
                decoration: BoxDecoration(
                  color: LuxoraColors.graphite,
                  borderRadius: LuxoraRadii.brSm,
                ),
                child: Icon(
                  widget.destination.icon,
                  size: 18,
                  color: LuxoraColors.champagne,
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      widget.destination.label,
                      style: LuxoraTextStyles.labelLarge.copyWith(
                        fontSize: 14,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      '${widget.destination.relativeTime} · '
                      '${widget.destination.priceLabel}',
                      style: LuxoraTextStyles.bodySmall.copyWith(
                        fontSize: 12,
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
        ),
      ),
    );
  }
}
