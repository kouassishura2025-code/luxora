import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:flutter_map/flutter_map.dart';
import 'package:latlong2/latlong.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/media/luxora_map.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/home_provider.dart';
import '../providers/map_provider.dart';
import '../widgets/booking_hero_card.dart';
import '../widgets/concierge_banner.dart';
import '../widgets/greeting_header.dart';
import '../widgets/greeting_section.dart';
import '../widgets/recent_destinations.dart';
import '../widgets/service_shortcuts.dart';

class HomePage extends ConsumerWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final greetingKey = ref.watch(greetingKeyProvider);
    final userName = ref.watch(userNameProvider);
    final initials = ref.watch(userInitialsProvider);
    final recent = ref.watch(recentDestinationsProvider);
    final currentPos = ref.watch(currentPositionProvider);
    final mapZoom = ref.watch(mapZoomProvider);

    return LuxoraScaffold(
      applyPadding: false,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(
          parent: AlwaysScrollableScrollPhysics(),
        ),
        slivers: [
          SliverAppBar(
            pinned: true,
            elevation: 0,
            scrolledUnderElevation: 0,
            backgroundColor: LuxoraColors.obsidian,
            surfaceTintColor: Colors.transparent,
            toolbarHeight: 64,
            titleSpacing: 24,
            title: GreetingHeader(initials: initials),
          ),
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            sliver: SliverList(
              delegate: SliverChildListDelegate([
                const SizedBox(height: 20),
                GreetingSection(
                  greeting: resolveGreeting(l10n, greetingKey),
                  name: userName,
                ),
                const SizedBox(height: 32),

                BookingHeroCard(
                  overline: l10n.homeBookingOverline,
                  title: l10n.homeBookingTitle,
                  subtitle: l10n.homeBookingSubtitle,
                  ctaLabel: l10n.homeBookingCta,
                  onTap: () => context.push(RouteNames.destinationEntry),
                ),

                const SizedBox(height: LuxoraSpacing.sectionGap),

                // ─── Carte ─────────────────────────────
                _SectionTitle(label: l10n.homeSectionAround),
                const SizedBox(height: 16),
                ClipRRect(
                  borderRadius: LuxoraRadii.brLg,
                  child: SizedBox(
                    height: 220,
                    child: Stack(
                      children: [
                        LuxoraMap(
                          center: currentPos,
                          initialZoom: mapZoom,
                          markers: [
                            Marker(
                              point: currentPos,
                              width: 44,
                              height: 44,
                              child: const LuxoraMapMarker(
                                icon: Icons.my_location_rounded,
                              ),
                            ),
                            Marker(
                              point: const LatLng(48.8606, 2.3376),
                              width: 36,
                              height: 36,
                              child: const LuxoraMapMarker(
                                icon: Icons.location_on_rounded,
                                isPrimary: false,
                                size: 36,
                              ),
                            ),
                          ],
                        ),
                        Positioned(
                          left: 16,
                          bottom: 16,
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 12,
                              vertical: 8,
                            ),
                            decoration: BoxDecoration(
                              color: LuxoraColors.obsidian.withOpacity(0.85),
                              borderRadius: LuxoraRadii.brPill,
                              border: Border.all(
                                color: LuxoraColors.dividerGold,
                                width: 0.5,
                              ),
                            ),
                            child: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Container(
                                  width: 6,
                                  height: 6,
                                  decoration: const BoxDecoration(
                                    color: LuxoraColors.champagne,
                                    shape: BoxShape.circle,
                                  ),
                                ),
                                const SizedBox(width: 8),
                                Text(
                                  'Paris · 8e arr.',
                                  style: LuxoraTextStyles.caption.copyWith(
                                    color: LuxoraColors.textPrimary,
                                    fontSize: 11,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

                const SizedBox(height: LuxoraSpacing.sectionGap),

                // ─── Services ──────────────────────────
                _SectionTitle(label: l10n.homeSectionServices),
                const SizedBox(height: 16),
                ServiceShortcuts(
                  shortcuts: [
                    ServiceShortcut(
                      label: l10n.serviceConcierge,
                      icon: Icons.support_agent_outlined,
                      onTap: () => context.push(RouteNames.conciergeChat),
                    ),
                    ServiceShortcut(
                      label: l10n.serviceFleet,
                      icon: Icons.directions_car_filled_outlined,
                      onTap: () => context.push(RouteNames.fleetCatalog),
                    ),
                    ServiceShortcut(
                      label: l10n.serviceFavorites,
                      icon: Icons.star_outline_rounded,
                      onTap: () => context.push(RouteNames.favoriteDrivers),
                    ),
                    ServiceShortcut(
                      label: l10n.serviceSafety,
                      icon: Icons.shield_outlined,
                      onTap: () => context.push(RouteNames.sos),
                    ),
                  ],
                ),

                const SizedBox(height: LuxoraSpacing.sectionGap),

                ConciergeBanner(
                  message: l10n.homeConciergeAvailable,
                  onTap: () => context.push(RouteNames.conciergeChat),
                ),

                const SizedBox(height: LuxoraSpacing.sectionGap),

                _SectionTitle(
                  label: l10n.homeSectionRecent,
                  action: l10n.homeSeeAll,
                  onAction: () {},
                ),
                const SizedBox(height: 16),
                RecentDestinations(destinations: recent, onTap: (_) {}),

                const SizedBox(height: LuxoraSpacing.sectionGap),

                Center(
                  child: Text(
                    l10n.homeFooter,
                    style: LuxoraTextStyles.caption.copyWith(
                      fontSize: 10,
                      color: LuxoraColors.textTertiary,
                    ),
                  ),
                ),

                const SizedBox(height: 40),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionTitle extends StatelessWidget {
  const _SectionTitle({required this.label, this.action, this.onAction});

  final String label;
  final String? action;
  final VoidCallback? onAction;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Text(
          label.toUpperCase(),
          style: LuxoraTextStyles.overline.copyWith(
            fontSize: 10,
            letterSpacing: 2.4,
            color: LuxoraColors.textSecondary,
          ),
        ),
        const Spacer(),
        if (action != null)
          GestureDetector(
            onTap: onAction,
            child: Text(
              action!,
              style: LuxoraTextStyles.labelMedium.copyWith(
                fontSize: 12,
                color: LuxoraColors.champagne,
              ),
            ),
          ),
      ],
    );
  }
}
