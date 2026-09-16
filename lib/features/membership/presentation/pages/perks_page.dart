import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../domain/entities/membership.dart';
import '../providers/membership_provider.dart';
import '../widgets/perk_tile.dart';

class PerksPage extends ConsumerWidget {
  const PerksPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final membership = ref.watch(membershipProvider);
    final currentTier = membership.tier;

    return LuxoraScaffold(
      applyPadding: false,
      appBar: const LuxoraAppBar(
        overline: 'Membership',
        title: 'Avantages',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            Text(
              'Ce que vous\ndébloquez.',
              style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 12),
            Text(
              'Chaque niveau débloque de nouveaux privilèges exclusifs.',
              style: LuxoraTextStyles.bodyMedium,
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            // ─── Les 3 tiers ──────────────────────────
            for (final tier in MembershipTier.values) ...[
              _TierSection(
                tier: tier,
                isCurrent: tier == currentTier,
                isUnlocked: _isUnlocked(tier, currentTier),
                perks: ref
                    .read(membershipRepositoryProvider)
                    .getPerksForTier(tier),
              ),
              const SizedBox(height: LuxoraSpacing.xl),
            ],

            const SizedBox(height: LuxoraSpacing.xxxl),
          ],
        ),
      ),
    );
  }

  bool _isUnlocked(MembershipTier tier, MembershipTier current) {
    return tier.index <= current.index;
  }
}

class _TierSection extends StatelessWidget {
  const _TierSection({
    required this.tier,
    required this.isCurrent,
    required this.isUnlocked,
    required this.perks,
  });

  final MembershipTier tier;
  final bool isCurrent;
  final bool isUnlocked;
  final List<Perk> perks;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ─── Titre de tier ─────────────────────────
        Row(
          children: [
            Icon(tier.icon, size: 18, color: tier.accent),
            const SizedBox(width: 10),
            Text(
              tier.label.toUpperCase(),
              style: LuxoraTextStyles.overline.copyWith(
                fontSize: 11,
                letterSpacing: 2.4,
                color: tier.accent,
              ),
            ),
            const Spacer(),
            if (isCurrent)
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 8,
                  vertical: 3,
                ),
                decoration: BoxDecoration(
                  color: tier.accent.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(999),
                ),
                child: Text(
                  'VOTRE NIVEAU',
                  style: LuxoraTextStyles.caption.copyWith(
                    fontSize: 8,
                    color: tier.accent,
                    letterSpacing: 1.4,
                  ),
                ),
              )
            else if (!isUnlocked)
              const Icon(
                Icons.lock_outline_rounded,
                size: 14,
                color: LuxoraColors.textTertiary,
              ),
          ],
        ),

        const SizedBox(height: 8),

        // ─── Threshold ─────────────────────────────
        if (tier.threshold > 0)
          Text(
            'À partir de ${tier.threshold} pts',
            style: LuxoraTextStyles.caption.copyWith(fontSize: 10),
          ),

        const SizedBox(height: 12),

        // ─── Perks ─────────────────────────────────
        for (final perk in perks)
          PerkTile(perk: perk, isLocked: !isUnlocked),

        const SizedBox(height: 16),

        Container(
          height: 0.5,
          color: LuxoraColors.divider,
        ),
      ],
    );
  }
}
