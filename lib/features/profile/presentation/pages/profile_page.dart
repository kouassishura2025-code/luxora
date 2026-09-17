import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/feedback/luxora_dialog.dart';
import '../../../../design_system/components/media/luxora_avatar.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/profile_provider.dart';
import '../widgets/profile_menu_section.dart';
import '../widgets/tier_badge.dart';

class ProfilePage extends ConsumerWidget {
  const ProfilePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final state = ref.watch(profileProvider);
    final profile = state.profile;

    return LuxoraScaffold(
      applyPadding: false,
      appBar: LuxoraAppBar(
        overline: l10n.profileOverline,
        title: l10n.profileTitle,
        showBackButton: false,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),

            // ─── En-tête ─────────────────────────────
            Center(
              child: Column(
                children: [
                  LuxoraAvatar(
                    initials: profile.initials,
                    size: 88,
                    goldBorder: true,
                    onTap: () => context.go(RouteNames.editProfile),
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
                    onTap: () =>
                        context.go(RouteNames.loyaltyDashboard),
                    child: TierBadge(tier: profile.memberTier),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 40),

            // ─── Compte ─────────────────────────────
            ProfileMenuSection(
              title: l10n.profileSectionAccount,
              items: [
                ProfileMenuItem(
                  icon: Icons.person_outline_rounded,
                  label: l10n.profilePersonalInfo,
                  onTap: () => context.go(RouteNames.editProfile),
                ),
                ProfileMenuItem(
                  icon: Icons.credit_card_outlined,
                  label: l10n.profilePaymentMethods,
                  onTap: () => context.go(RouteNames.paymentMethods),
                ),
                ProfileMenuItem(
                  icon: Icons.receipt_long_outlined,
                  label: l10n.profileInvoiceHistory,
                  onTap: () => context.go(RouteNames.invoiceHistory),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Préférences ─────────────────────────
            ProfileMenuSection(
              title: l10n.profileSectionPreferences,
              items: [
                ProfileMenuItem(
                  icon: Icons.tune_rounded,
                  label: l10n.profileTravelPreferences,
                  onTap: () => context.go(RouteNames.travelPreferences),
                ),
                ProfileMenuItem(
                  icon: Icons.star_outline_rounded,
                  label: l10n.profileFavoriteDrivers,
                  onTap: () => context.go(RouteNames.favoriteDrivers),
                ),
                ProfileMenuItem(
                  icon: Icons.notifications_none_rounded,
                  label: l10n.profileNotifications,
                  onTap: () => context.go(RouteNames.notificationSettings),
                ),
                ProfileMenuItem(
                  icon: Icons.language_rounded,
                  label: l10n.languageTitle,
                  onTap: () => context.go(RouteNames.languageSettings),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Sécurité ────────────────────────────
            ProfileMenuSection(
              title: l10n.profileSectionSecurity,
              items: [
                ProfileMenuItem(
                  icon: Icons.shield_outlined,
                  label: l10n.profilePrivacy,
                  onTap: () => context.go(RouteNames.privacySettings),
                ),
                ProfileMenuItem(
                  icon: Icons.verified_user_outlined,
                  label: l10n.profileKyc,
                  trailing: 'À FAIRE',
                  trailingHighlight: true,
                  onTap: () => context.go(RouteNames.kycVerification),
                ),
              ],
            ),

            const SizedBox(height: 24),

            // ─── Session ─────────────────────────────
            ProfileMenuSection(
              title: l10n.profileSectionSession,
              items: [
                ProfileMenuItem(
                  icon: Icons.logout_rounded,
                  label: l10n.profileLogout,
                  destructive: true,
                  onTap: () async {
                    final confirmed = await LuxoraDialog.show(
                      context: context,
                      overline: l10n.commonConfirm,
                      title: l10n.profileLogoutConfirm,
                      message: l10n.profileLogoutMessage,
                      confirmLabel: l10n.profileLogout,
                      cancelLabel: l10n.commonCancel,
                    );
                    if (confirmed == true) {
                      await ref
                          .read(profileProvider.notifier)
                          .logout();
                      if (context.mounted) {
                        context.go(RouteNames.phoneEntry);
                      }
                    }
                  },
                ),
              ],
            ),

            const SizedBox(height: 40),

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
