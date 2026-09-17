import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';

class ConciergePage extends StatelessWidget {
  const ConciergePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return LuxoraScaffold(
      applyPadding: false,
      appBar: LuxoraAppBar(
        overline: l10n.conciergeOverline,
        title: l10n.conciergeTitle,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text(
              l10n.conciergeAtService,
              style: LuxoraTextStyles.displayMedium,
            ),
            const SizedBox(height: 8),
            Text(
              l10n.conciergeSubtitle,
              style: LuxoraTextStyles.bodyMedium,
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            LuxoraCard(
              goldBorder: true,
              onTap: () => context.go(RouteNames.conciergeChat),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        width: 8,
                        height: 8,
                        decoration: const BoxDecoration(
                          color: LuxoraColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 10),
                      Text(
                        l10n.conciergeOnline.toUpperCase(),
                        style: LuxoraTextStyles.overline.copyWith(
                          fontSize: 10,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    l10n.conciergeStartChat,
                    style: LuxoraTextStyles.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    l10n.conciergeResponse,
                    style: LuxoraTextStyles.bodyMedium,
                  ),
                ],
              ),
            ),

            const SizedBox(height: LuxoraSpacing.lg),

            Text(
              'SERVICES',
              style: LuxoraTextStyles.overline.copyWith(
                fontSize: 10,
                color: LuxoraColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            _ConciergeService(
              icon: Icons.restaurant_outlined,
              title: 'Réservation restaurant',
              subtitle: 'Table pour ce soir',
              onTap: () => context.go(RouteNames.conciergeChat),
            ),
            const SizedBox(height: 10),
            _ConciergeService(
              icon: Icons.local_florist_outlined,
              title: 'Fleurs & attentions',
              subtitle: 'Livraison personnalisée',
              onTap: () => context.go(RouteNames.conciergeChat),
            ),
            const SizedBox(height: 10),
            _ConciergeService(
              icon: Icons.theater_comedy_outlined,
              title: 'Billets & événements',
              subtitle: 'Accès privilégié',
              onTap: () => context.go(RouteNames.conciergeChat),
            ),
            const SizedBox(height: 10),
            _ConciergeService(
              icon: Icons.hotel_outlined,
              title: 'Réservation hôtel',
              subtitle: 'Suites et palaces',
              onTap: () => context.go(RouteNames.conciergeChat),
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

class _ConciergeService extends StatelessWidget {
  const _ConciergeService({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return LuxoraCard(
      padding: const EdgeInsets.all(16),
      onTap: onTap,
      child: Row(
        children: [
          Container(
            width: 40,
            height: 40,
            decoration: BoxDecoration(
              color: LuxoraColors.graphite,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(icon, size: 18, color: LuxoraColors.champagne),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: LuxoraTextStyles.labelLarge.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 2),
                Text(
                  subtitle,
                  style: LuxoraTextStyles.bodySmall.copyWith(fontSize: 12),
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
    );
  }
}
