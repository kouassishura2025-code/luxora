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
import '../providers/membership_provider.dart';
import '../widgets/membership_card.dart';
import '../widgets/perk_tile.dart';
import '../widgets/points_history_tile.dart';

class LoyaltyDashboardPage extends ConsumerWidget {
  const LoyaltyDashboardPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(membershipProvider);
    final perks = ref.watch(perksProvider);
    final history = ref.watch(pointsHistoryProvider);

    return LuxoraScaffold(
      applyPadding: false,
      appBar: const LuxoraAppBar(
        overline: 'Membership',
        title: 'LUXORA Cercle',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            // ─── Carte membre ─────────────────────────
            MembershipCard(
              membership: membership,
              memberName: 'Kouassi Shura',
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            // ─── Avantages ────────────────────────────
            Row(
              children: [
                Text(
                  'VOS AVANTAGES',
                  style: LuxoraTextStyles.overline.copyWith(
                    fontSize: 10,
                    color: LuxoraColors.textSecondary,
                  ),
                ),
                const Spacer(),
                GestureDetector(
                  onTap: () => context.go(RouteNames.perks),
                  child: Text(
                    'Voir tout',
                    style: LuxoraTextStyles.labelMedium.copyWith(
                      fontSize: 12,
                      color: LuxoraColors.champagne,
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),

            LuxoraCard(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: Column(
                children: [
                  for (var i = 0; i < perks.length; i++) ...[
                    PerkTile(perk: perks[i], isLocked: false),
                    if (i != perks.length - 1)
                      const Divider(
                        color: LuxoraColors.divider,
                        height: 1,
                      ),
                  ],
                ],
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            // ─── Historique ───────────────────────────
            Text(
              'HISTORIQUE',
              style: LuxoraTextStyles.overline.copyWith(
                fontSize: 10,
                color: LuxoraColors.textSecondary,
              ),
            ),
            const SizedBox(height: 8),

            LuxoraCard(
              padding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 8,
              ),
              child: Column(
                children: [
                  for (var i = 0; i < history.length; i++) ...[
                    PointsHistoryTile(event: history[i]),
                    if (i != history.length - 1)
                      const Divider(
                        color: LuxoraColors.divider,
                        height: 1,
                      ),
                  ],
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
