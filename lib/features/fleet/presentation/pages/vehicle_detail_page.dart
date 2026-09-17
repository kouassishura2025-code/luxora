import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/fleet_provider.dart';
import '../widgets/vehicle_amenity_chip.dart';
import '../widgets/vehicle_spec_row.dart';

class VehicleDetailPage extends ConsumerWidget {
  const VehicleDetailPage({super.key, required this.vehicleId});

  final String vehicleId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final vehicle = ref.watch(fleetVehicleByIdProvider(vehicleId));

    if (vehicle == null) {
      return LuxoraScaffold(
        appBar: const LuxoraAppBar(),
        body: Center(
          child: Text(
            'Véhicule introuvable',
            style: LuxoraTextStyles.bodyMedium,
          ),
        ),
      );
    }

    return LuxoraScaffold(
      applyPadding: false,
      appBar: LuxoraAppBar(
        overline: vehicle.name,
        title: vehicle.model,
      ),
      body: Column(
        children: [
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ─── Bannière ──────────────────────────
                  Container(
                    height: 260,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: vehicle.gradientColors,
                      ),
                    ),
                    child: Stack(
                      children: [
                        Positioned(
                          right: -30,
                          bottom: -30,
                          child: Icon(
                            vehicle.icon,
                            size: 260,
                            color: LuxoraColors.champagne.withOpacity(0.08),
                          ),
                        ),
                        Positioned(
                          left: 24,
                          bottom: 24,
                          right: 24,
                          child: Text(
                            vehicle.tagline,
                            style: LuxoraTextStyles.displayMedium
                                .copyWith(fontSize: 24),
                          ),
                        ),
                      ],
                    ),
                  ),

                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 24),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const SizedBox(height: LuxoraSpacing.xl),

                        Text(
                          vehicle.description,
                          style: LuxoraTextStyles.bodyLarge.copyWith(
                            fontSize: 15,
                            height: 1.6,
                          ),
                        ),

                        const SizedBox(height: LuxoraSpacing.xl),

                        Text(
                          'CARACTÉRISTIQUES',
                          style: LuxoraTextStyles.overline.copyWith(
                            fontSize: 10,
                            color: LuxoraColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),

                        LuxoraCard(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 8,
                          ),
                          child: Column(
                            children: [
                              VehicleSpecRow(
                                icon: Icons.people_outline_rounded,
                                label: 'Capacité',
                                value: '${vehicle.capacity} passagers',
                              ),
                              const Divider(
                                color: LuxoraColors.divider,
                                height: 1,
                              ),
                              VehicleSpecRow(
                                icon: Icons.work_outline_rounded,
                                label: 'Bagages',
                                value: '${vehicle.luggage} valises',
                              ),
                              const Divider(
                                color: LuxoraColors.divider,
                                height: 1,
                              ),
                              VehicleSpecRow(
                                icon: Icons.access_time_rounded,
                                label: 'Prise en charge',
                                value: '${vehicle.eta} min',
                              ),
                              const Divider(
                                color: LuxoraColors.divider,
                                height: 1,
                              ),
                              VehicleSpecRow(
                                icon: Icons.euro_rounded,
                                label: 'Prix au km',
                                value:
                                    '${vehicle.pricePerKm.toStringAsFixed(2)} €',
                              ),
                            ],
                          ),
                        ),

                        const SizedBox(height: LuxoraSpacing.xl),

                        Text(
                          'À BORD',
                          style: LuxoraTextStyles.overline.copyWith(
                            fontSize: 10,
                            color: LuxoraColors.textSecondary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: [
                            for (final amenity in vehicle.amenities)
                              VehicleAmenityChip(label: amenity),
                          ],
                        ),

                        const SizedBox(height: LuxoraSpacing.xxxl),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          // ─── CTA ──────────────────────────────────
          Container(
            padding: const EdgeInsets.fromLTRB(24, 16, 24, 0),
            decoration: const BoxDecoration(
              color: LuxoraColors.obsidian,
              border: Border(
                top: BorderSide(color: LuxoraColors.divider, width: 0.5),
              ),
            ),
            child: SafeArea(
              top: false,
              child: Padding(
                padding: const EdgeInsets.only(bottom: 16),
                child: LuxoraPrimaryButton(
                  label:
                      '${l10n.fleetBook} · à partir de ${vehicle.basePrice.toStringAsFixed(0)} €',
                  icon: Icons.arrow_forward_rounded,
                  onPressed: () => context.go(RouteNames.destinationEntry),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
