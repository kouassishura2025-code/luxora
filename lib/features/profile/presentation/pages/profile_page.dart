import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/feedback/luxora_dialog.dart';
import '../../../../design_system/components/media/luxora_avatar.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/tier_badge.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(profileProvider);
    final profile = state.profile;

    return LuxoraScaffold(
      applyPadding: false,
      appBar: const LuxoraAppBar(
        overline: 'Compte',
        title: 'Profil',
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            // ─── En-tête utilisateur ─────────────────────
            Center(
              child: Column(
                children: [
                  LuxoraAvatar(
                    initials: profile.initials,
                    size: 88,
                    goldBorder: true,
                    onTap: () =>
                        context.go(RouteNames.editProfile),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    profile.displayName,
                    style: LuxoraTextStyles.titleLarge,
                  ),
                  const SizedBox(height: 4),
                  Text(
                    profile.phoneNumber,
                    style: LuxoraTextStyles.bodySmall,
                  ),
                  const SizedBox(height: 12),
                  GestureDetector(
                    onTap: () => context.go(RouteNames.loyaltyDashboard),
                    child: TierBadge(tier: profile.memberTier),
                  ),
                ],
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            // ─── Section Compte ──────────────────────────
            ProfileMenuSection(
              title: 'Compte',
              items: [
                ProfileMenuItem(
                  icon: Icons.person_outline_rounded,
                  label: 'Informations personnelles',
                  onTap: () => context.go(RouteNames.editProfile),
                ),
                ProfileMenuItem(
                  icon: Icons.credit_card_outlined,
                  label: 'Moyens de paiement',
                  onTap: () =>
                      context.go(RouteNames.paymentMethods),
                ),
                ProfileMenuItem(
                  icon: Icons.receipt_long_outlined,
                  label: 'Historique des factures',
                  onTap: () =>
                      context.go(RouteNames.invoiceHistory),
                ),
              ],
            ),

            const SizedBox(height: LuxoraSpacing.lg),

            // ─── Section Préférences ─────────────────────
            ProfileMenuSection(
              title: 'Préférences',
              items: [
                ProfileMenuItem(
                  icon: Icons.tune_rounded,
                  label: 'Préférences de trajet',
                  onTap: () =>
                      context.go(RouteNames.travelPreferences),
                ),
                ProfileMenuItem(
                  icon: Icons.star_outline_rounded,
                  label: 'Chauffeurs favoris',
                  onTap: () =>
                      context.go(RouteNames.favoriteDrivers),
                ),
                ProfileMenuItem(
                  icon: Icons.notifications_none_rounded,
                  label: 'Notifications',
                  onTap: () =>
                      context.go(RouteNames.notificationSettings),
                ),
              ],
            ),

            const SizedBox(height: LuxoraSpacing.lg),

            // ─── Section Sécurité ────────────────────────
            ProfileMenuSection(
              title: 'Sécurité',
              items: [
                ProfileMenuItem(
                  icon: Icons.shield_outlined,
                  label: 'Confidentialité',
                  onTap: () =>
                      context.go(RouteNames.privacySettings),
                ),
                ProfileMenuItem(
                  icon: Icons.verified_user_outlined,
                  label: 'Vérification KYC',
                  trailing: 'À FAIRE',
                  trailingHighlight: true,
                  onTap: () =>
                      context.go(RouteNames.kycVerification),
                ),
              ],
            ),

            const SizedBox(height: LuxoraSpacing.lg),

            // ─── Déconnexion ─────────────────────────────
            ProfileMenuSection(
              title: 'Session',
              items: [
                ProfileMenuItem(
                  icon: Icons.logout_rounded,
                  label: 'Se déconnecter',
                  destructive: true,
                  onTap: () async {
                    final confirmed = await LuxoraDialog.show(
                      context: context,
                      overline: 'Confirmation',
                      title: 'Se déconnecter ?',
                      message:
                          'Vous devrez vous reconnecter à votre prochaine visite.',
                      confirmLabel: 'Se déconnecter',
                      cancelLabel: 'Annuler',
                    );
                    if (confirmed == true) {
                      await ref.read(profileProvider.notifier).logout();
                      if (context.mounted) {
                        context.go(RouteNames.phoneEntry);
                      }
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            Center(
              child: Text(
                'LUXORA — v0.1.0',
                style: LuxoraTextStyles.caption.copyWith(fontSize: 10),
              ),
            ),
            const SizedBox(height: 32),
          ],
        ),
      ),
    );
  }
}
