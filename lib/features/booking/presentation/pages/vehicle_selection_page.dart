import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/booking_provider.dart';
import '../widgets/booking_progress.dart';
import '../widgets/vehicle_showcase_card.dart';

class VehicleSelectionPage extends ConsumerWidget {
  const VehicleSelectionPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final vehicles = ref.watch(vehicleClassesProvider);
    final bookingState = ref.watch(bookingProvider);

    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Réservation',
        title: 'Votre véhicule',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          const BookingProgress(currentStep: 2),
          const SizedBox(height: 32),

          Text(
            'Choisissez votre\ncompagnon de route.',
            style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 26),
          ),

          const SizedBox(height: LuxoraSpacing.xl),

          // ─── Liste des véhicules ────────────────────────
          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.only(bottom: 16),
              itemCount: vehicles.length,
              separatorBuilder: (_, __) =>
                  const SizedBox(height: LuxoraSpacing.md),
              itemBuilder: (context, index) {
                final vehicle = vehicles[index];
                final selected = bookingState.selectedVehicleId == vehicle.id;
                return VehicleShowcaseCard(
                  vehicle: vehicle,
                  selected: selected,
                  estimateLabel: '${vehicle.basePrice.toStringAsFixed(0)} €',
                  onTap: () => ref
                      .read(bookingProvider.notifier)
                      .selectVehicle(vehicle.id),
                );
              },
            ),
          ),

          const SizedBox(height: LuxoraSpacing.lg),

          // ─── CTA ────────────────────────────────────────
          LuxoraPrimaryButton(
            label: 'Continuer',
            icon: Icons.arrow_forward_rounded,
            onPressed: bookingState.selectedVehicleId == null
                ? null
                : () => context.go(RouteNames.chauffeurPreferences),
          ),

          const SizedBox(height: LuxoraSpacing.lg),
        ],
      ),
    );
  }
}
