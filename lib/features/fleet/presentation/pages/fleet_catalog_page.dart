import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/fleet_provider.dart';
import '../widgets/fleet_hero_card.dart';
import '../widgets/fleet_list_tile.dart';

class FleetCatalogPage extends ConsumerWidget {
  const FleetCatalogPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(fleetVehiclesProvider);

    return LuxoraScaffold(
      applyPadding: false,
      appBar: const LuxoraAppBar(
        overline: 'Notre collection',
        title: 'Flotte',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            Text(
              'Une flotte\nd\'exception.',
              style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 12),
            Text(
              'Quatre classes de véhicules, chacune pensée '
              'pour un moment de vie.',
              style: LuxoraTextStyles.bodyMedium,
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            // ─── Carte héro du premier ────────────────
            if (vehicles.isNotEmpty)
              FleetHeroCard(
                vehicle: vehicles.first,
                onTap: () => context.go(
                  RouteNames.vehicleDetail(vehicles.first.id),
                ),
              ),

            const SizedBox(height: LuxoraSpacing.lg),

            // ─── Autres véhicules ─────────────────────
            Text(
              'TOUTE LA FLOTTE',
              style: LuxoraTextStyles.overline.copyWith(
                fontSize: 10,
                color: LuxoraColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            for (var i = 1; i < vehicles.length; i++) ...[
              FleetListTile(
                vehicle: vehicles[i],
                onTap: () => context.go(
                  RouteNames.vehicleDetail(vehicles[i].id),
                ),
              ),
              const SizedBox(height: 10),
            ],

            const SizedBox(height: LuxoraSpacing.xxxl),

            // ─── Engagements ──────────────────────────
            Text(
              'NOS ENGAGEMENTS',
              style: LuxoraTextStyles.overline.copyWith(
                fontSize: 10,
                color: LuxoraColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            LuxoraCard(
              padding: const EdgeInsets.all(20),
              child: Column(
                children: const [
                  _EngagementRow(
                    icon: Icons.verified_user_outlined,
                    text: 'Chauffeurs formés à l\'excellence',
                  ),
                  Divider(color: LuxoraColors.divider, height: 24),
                  _EngagementRow(
                    icon: Icons.directions_car_outlined,
                    text: 'Véhicules de moins de 3 ans',
                  ),
                  Divider(color: LuxoraColors.divider, height: 24),
                  _EngagementRow(
                    icon: Icons.shield_outlined,
                    text: 'Assurance premium tous risques',
                  ),
                  Divider(color: LuxoraColors.divider, height: 24),
                  _EngagementRow(
                    icon: Icons.eco_outlined,
                    text: 'Flotte hybride et électrique',
                  ),
                ],
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

class _EngagementRow extends StatelessWidget {
  const _EngagementRow({required this.icon, required this.text});

  final IconData icon;
  final String text;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(icon, size: 18, color: LuxoraColors.champagne),
        const SizedBox(width: 14),
        Expanded(
          child: Text(
            text,
            style: LuxoraTextStyles.bodyMedium.copyWith(fontSize: 13),
          ),
        ),
      ],
    );
  }
}
