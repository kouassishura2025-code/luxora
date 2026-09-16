import 'package:flutter/material.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:latlong2/latlong.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_ghost_button.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/media/luxora_avatar.dart';
import '../../../../design_system/components/media/luxora_map.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/booking_provider.dart';
import '../widgets/booking_progress.dart';
import '../widgets/ride_timeline.dart';

class RideTrackingPage extends ConsumerWidget {
  const RideTrackingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final bookingState = ref.watch(bookingProvider);
    final vehicles = ref.watch(vehicleClassesProvider);
    final vehicle = vehicles.firstWhere(
      (v) => v.id == bookingState.selectedVehicleId,
      orElse: () => vehicles.first,
    );

    const pickup = LatLng(48.8584, 2.2945); // Tour Eiffel
    const destination = LatLng(48.8738, 2.2950); // Arc de Triomphe
    const driver = LatLng(48.8606, 2.3000); // Quelque part entre les deux

    return LuxoraScaffold(
      applyPadding: false,
      appBar: const LuxoraAppBar(
        overline: 'En cours',
        title: 'Votre chauffeur',
      ),
      body: Column(
        children: [
          // ─── Carte avec itinéraire ────────────────────
          SizedBox(
            height: 260,
            child: LuxoraMap(
              center: const LatLng(48.8660, 2.2980),
              initialZoom: 13,
              polylines: [
                Polyline(
                  points: const [pickup, destination],
                  color: LuxoraColors.champagne,
                  strokeWidth: 3,
                  borderColor: LuxoraColors.obsidian,
                  borderStrokeWidth: 1,
                ),
              ],
              markers: [
                Marker(
                  point: pickup,
                  width: 32,
                  height: 32,
                  child: const LuxoraMapMarker(
                    icon: Icons.trip_origin_rounded,
                    isPrimary: false,
                    size: 32,
                  ),
                ),
                Marker(
                  point: destination,
                  width: 40,
                  height: 40,
                  child: const LuxoraMapMarker(size: 40),
                ),
                Marker(
                  point: driver,
                  width: 44,
                  height: 44,
                  child: Container(
                    decoration: BoxDecoration(
                      color: LuxoraColors.obsidian,
                      shape: BoxShape.circle,
                      border: Border.all(
                        color: LuxoraColors.champagne,
                        width: 2,
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: LuxoraColors.champagne.withOpacity(0.4),
                          blurRadius: 16,
                          spreadRadius: -2,
                        ),
                      ],
                    ),
                    child: const Icon(
                      Icons.directions_car_filled_rounded,
                      size: 20,
                      color: LuxoraColors.champagne,
                    ),
                  ),
                ),
              ],
            ),
          ),

          // ─── Contenu scrollable ───────────────────────
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.all(24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const BookingProgress(currentStep: 5),
                  const SizedBox(height: 24),

                  Text(
                    'Votre chauffeur\nest en route.',
                    style: LuxoraTextStyles.displayMedium
                        .copyWith(fontSize: 24),
                  ),

                  const SizedBox(height: LuxoraSpacing.lg),

                  // ─── Chauffeur ────────────────────────
                  LuxoraCard(
                    goldBorder: true,
                    child: Row(
                      children: [
                        const LuxoraAvatar(
                          initials: 'AL',
                          size: 52,
                          goldBorder: true,
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Alexandre L.',
                                style: LuxoraTextStyles.titleMedium
                                    .copyWith(fontSize: 18),
                              ),
                              const SizedBox(height: 3),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star_rounded,
                                    size: 14,
                                    color: LuxoraColors.champagne,
                                  ),
                                  const SizedBox(width: 4),
                                  Text(
                                    '4.98 · 1 247 courses',
                                    style: LuxoraTextStyles.bodySmall
                                        .copyWith(fontSize: 12),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 10,
                            vertical: 6,
                          ),
                          decoration: BoxDecoration(
                            color: LuxoraColors.champagne
                                .withOpacity(0.12),
                            borderRadius: BorderRadius.circular(999),
                            border: Border.all(
                              color: LuxoraColors.champagne
                                  .withOpacity(0.3),
                              width: 0.5,
                            ),
                          ),
                          child: Text(
                            'Mercedes',
                            style: LuxoraTextStyles.caption.copyWith(
                              color: LuxoraColors.champagne,
                              fontSize: 9,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: LuxoraSpacing.lg),

                  Text(
                    'PROGRESSION',
                    style: LuxoraTextStyles.overline.copyWith(
                      fontSize: 10,
                      color: LuxoraColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 16),

                  RideTimeline(
                    steps: [
                      const RideTimelineStep(
                        label: 'Réservation confirmée',
                        subtitle: 'Votre demande est acceptée',
                        done: true,
                        active: false,
                      ),
                      const RideTimelineStep(
                        label: 'Chauffeur en route',
                        subtitle: 'Alexandre arrive dans 4 min',
                        done: false,
                        active: true,
                      ),
                      const RideTimelineStep(
                        label: 'Prise en charge',
                        subtitle: 'Rendez-vous au point de départ',
                        done: false,
                        active: false,
                      ),
                      RideTimelineStep(
                        label: 'Destination',
                        subtitle: bookingState.destination ?? '—',
                        done: false,
                        active: false,
                      ),
                    ],
                  ),

                  const SizedBox(height: LuxoraSpacing.lg),

                  LuxoraCard(
                    child: Row(
                      children: [
                        Container(
                          width: 44,
                          height: 44,
                          decoration: BoxDecoration(
                            color: LuxoraColors.graphite,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: Icon(
                            vehicle.icon,
                            color: LuxoraColors.champagne,
                            size: 20,
                          ),
                        ),
                        const SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                vehicle.name,
                                style: LuxoraTextStyles.labelLarge
                                    .copyWith(fontSize: 14),
                              ),
                              const SizedBox(height: 3),
                              Text(
                                'Plaque · AB-123-CD',
                                style: LuxoraTextStyles.bodySmall
                                    .copyWith(fontSize: 12),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: LuxoraSpacing.lg),

                  LuxoraGhostButton(
                    label: 'Contacter le chauffeur',
                    icon: Icons.chat_bubble_outline,
                    onPressed: () {},
                  ),
                  const SizedBox(height: 12),
                  LuxoraPrimaryButton(
                    label: 'Terminer',
                    icon: Icons.check_rounded,
                    onPressed: () {
                      ref.read(bookingProvider.notifier).reset();
                      context.go(RouteNames.home);
                    },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
