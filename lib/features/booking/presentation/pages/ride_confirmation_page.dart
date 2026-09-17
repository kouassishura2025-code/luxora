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
import '../providers/booking_provider.dart';
import '../widgets/booking_progress.dart';
import '../widgets/price_elegant_row.dart';

class RideConfirmationPage extends ConsumerWidget {
  const RideConfirmationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider);
    final vehicles = ref.watch(vehicleClassesProvider);
    final vehicle = vehicles.firstWhere(
      (v) => v.id == bookingState.selectedVehicleId,
      orElse: () => vehicles.first,
    );

    // Estimation simple : base + 12 km × prix/km
    final estimatedPrice = vehicle.basePrice + (12 * vehicle.pricePerKm);
    final estimatedDuration = Duration(minutes: 18 + vehicle.eta);

    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        forceBackButton: true,
        overline: 'Réservation',
        title: 'Confirmation',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          const BookingProgress(currentStep: 4),
          const SizedBox(height: 32),

          Text(
            'Votre voyage.',
            style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 26),
          ),

          const SizedBox(height: LuxoraSpacing.xl),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  // ─── Itinéraire ─────────────────────────
                  LuxoraCard(
                    goldBorder: true,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _ItineraryRow(
                          icon: Icons.my_location_outlined,
                          label: 'Départ',
                          value: bookingState.pickup,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 10),
                          child: Container(
                            width: 0.5,
                            height: 18,
                            color: LuxoraColors.dividerGold,
                          ),
                        ),
                        _ItineraryRow(
                          icon: Icons.location_on_outlined,
                          label: 'Destination',
                          value: bookingState.destination ?? '—',
                          isGold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: LuxoraSpacing.md),

                  // ─── Véhicule ───────────────────────────
                  LuxoraCard(
                    child: Row(
                      children: [
                        Container(
                          width: 48,
                          height: 48,
                          decoration: BoxDecoration(
                            color: LuxoraColors.graphite,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            vehicle.icon,
                            color: LuxoraColors.champagne,
                            size: 22,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle.name,
                                style: LuxoraTextStyles.titleMedium
                                    .copyWith(fontSize: 17),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                '${vehicle.tagline} · ETA ${vehicle.eta} min',
                                style: LuxoraTextStyles.bodySmall
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: LuxoraSpacing.md),

                  // ─── Prix ───────────────────────────────
                  LuxoraCard(
                    child: Column(
                      children: [
                        PriceElegantRow(
                          label: 'Prise en charge',
                          value: '${vehicle.basePrice.toStringAsFixed(0)} €',
                        ),
                        const Divider(
                          color: LuxoraColors.divider,
                          height: 1,
                        ),
                        PriceElegantRow(
                          label: 'Distance estimée (12 km)',
                          value:
                              '${(12 * vehicle.pricePerKm).toStringAsFixed(0)} €',
                        ),
                        const Divider(
                          color: LuxoraColors.divider,
                          height: 1,
                        ),
                        PriceElegantRow(
                          label: 'Total estimé',
                          value: '${estimatedPrice.toStringAsFixed(0)} €',
                          isTotal: true,
                          isGold: true,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: LuxoraSpacing.md),

                  Center(
                    child: Text(
                      'Durée estimée · ${estimatedDuration.inMinutes} min',
                      style: LuxoraTextStyles.caption,
                    ),
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: LuxoraSpacing.lg),

          // ─── CTA ────────────────────────────────────────
          LuxoraPrimaryButton(
            label: 'Confirmer la réservation',
            icon: Icons.check_rounded,
            onPressed: () => context.push(RouteNames.rideTracking),
          ),

          const SizedBox(height: LuxoraSpacing.lg),
        ],
      ),
    );
  }
}

class _ItineraryRow extends StatelessWidget {
  const _ItineraryRow({
    required this.icon,
    required this.label,
    required this.value,
    this.isGold = false,
  });

  final IconData icon;
  final String label;
  final String value;
  final bool isGold;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          icon,
          size: 18,
          color:
              isGold ? LuxoraColors.champagne : LuxoraColors.textSecondary,
        ),
        const SizedBox(width: 14),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                label.toUpperCase(),
                style: LuxoraTextStyles.caption.copyWith(fontSize: 9),
              ),
              const SizedBox(height: 2),
              Text(
                value,
                style: LuxoraTextStyles.bodyLarge.copyWith(fontSize: 14),
              ),
            ],
          ),
        ),
      ],
    );
  }
}
