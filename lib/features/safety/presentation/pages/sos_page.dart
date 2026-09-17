import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/emergency_contact.dart';
import '../providers/safety_provider.dart';
import '../widgets/emergency_contact_tile.dart';
import '../widgets/sos_button.dart';

class SosPage extends ConsumerWidget {
  const SosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final contactsAsync = ref.watch(emergencyContactsProvider);
    final sosState = ref.watch(sosProvider);

    return LuxoraScaffold(
      applyPadding: false,
      appBar: LuxoraAppBar(
        overline: l10n.safetyOverline,
        title: l10n.safetyTitle,
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),
            Text(
              l10n.safetyHeadline,
              style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 12),
            Text(
              l10n.safetySubtitle,
              style: LuxoraTextStyles.bodyMedium,
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            Center(
              child: SosButton(
                onTriggered: () async {
                  await ref.read(sosProvider.notifier).trigger();
                  if (context.mounted) {
                    _showTriggeredDialog(context, ref, l10n);
                  }
                },
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xl),

            Center(
              child: Text(
                sosState.status == SosStatus.triggered
                    ? l10n.safetyAlertSent
                    : l10n.safetyHold,
                style: LuxoraTextStyles.bodyMedium.copyWith(
                  color: sosState.status == SosStatus.triggered
                      ? LuxoraColors.success
                      : LuxoraColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            Text(
              l10n.safetyContacts.toUpperCase(),
              style: LuxoraTextStyles.overline.copyWith(
                fontSize: 10,
                color: LuxoraColors.textSecondary,
              ),
            ),
            const SizedBox(height: 16),

            contactsAsync.when(
              data: (contacts) => LuxoraCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var i = 0; i < contacts.length; i++) ...[
                      EmergencyContactTile(contact: contacts[i]),
                      if (i != contacts.length - 1)
                        const Divider(
                          color: LuxoraColors.divider,
                          height: 1,
                          indent: 70,
                        ),
                    ],
                  ],
                ),
              ),
              loading: () => const Center(
                child: Padding(
                  padding: EdgeInsets.all(24),
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: LuxoraColors.champagne,
                  ),
                ),
              ),
              error: (_, __) => Text(
                l10n.commonError,
                style: LuxoraTextStyles.bodyMedium,
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),
          ],
        ),
      ),
    );
  }

  void _showTriggeredDialog(
    BuildContext context,
    WidgetRef ref,
    AppLocalizations l10n,
  ) {
    showDialog<void>(
      context: context,
      barrierDismissible: false,
      barrierColor: LuxoraColors.obsidian.withOpacity(0.9),
      builder: (context) => Dialog(
        backgroundColor: LuxoraColors.charcoal,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(24),
          side: const BorderSide(
            color: LuxoraColors.dividerGold,
            width: 0.5,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 72,
                height: 72,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: LuxoraColors.error.withOpacity(0.15),
                  border: Border.all(
                    color: LuxoraColors.error.withOpacity(0.4),
                    width: 1,
                  ),
                ),
                child: const Icon(
                  Icons.check_rounded,
                  size: 32,
                  color: LuxoraColors.error,
                ),
              ),
              const SizedBox(height: 24),
              Text(
                l10n.safetyAlertSent,
                style: LuxoraTextStyles.titleLarge,
              ),
              const SizedBox(height: 28),
              SizedBox(
                width: double.infinity,
                child: TextButton(
                  onPressed: () {
                    ref.read(sosProvider.notifier).reset();
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    l10n.commonClose,
                    style: LuxoraTextStyles.labelLarge.copyWith(
                      color: LuxoraColors.champagne,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
