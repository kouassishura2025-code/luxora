import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../domain/entities/emergency_contact.dart';
import '../providers/safety_provider.dart';
import '../widgets/emergency_contact_tile.dart';
import '../widgets/sos_button.dart';

class SosPage extends ConsumerWidget {
  const SosPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(emergencyContactsProvider);
    final sosState = ref.watch(sosProvider);

    return LuxoraScaffold(
      applyPadding: false,
      appBar: const LuxoraAppBar(
        overline: 'Sécurité',
        title: 'Assistance',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            Text(
              'En cas d\'urgence.',
              style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 12),
            Text(
              'Maintenez le bouton pendant 3 secondes pour déclencher '
              'une alerte silencieuse à vos contacts.',
              style: LuxoraTextStyles.bodyMedium,
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            // ─── Bouton SOS ─────────────────────────────
            Center(
              child: SosButton(
                onTriggered: () async {
                  await ref.read(sosProvider.notifier).trigger();
                  if (context.mounted) {
                    _showTriggeredDialog(context, ref);
                  }
                },
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xl),

            Center(
              child: Text(
                sosState.status == SosStatus.triggered
                    ? 'Alerte envoyée.'
                    : 'Maintenez 3 secondes',
                style: LuxoraTextStyles.bodyMedium.copyWith(
                  color: sosState.status == SosStatus.triggered
                      ? LuxoraColors.success
                      : LuxoraColors.textSecondary,
                ),
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),

            // ─── Contacts ───────────────────────────────
            Text(
              'CONTACTS D\'URGENCE',
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
                'Erreur de chargement',
                style: LuxoraTextStyles.bodyMedium,
              ),
            ),

            const SizedBox(height: LuxoraSpacing.lg),

            Center(
              child: Text(
                'Ajouter un contact',
                style: LuxoraTextStyles.labelMedium.copyWith(
                  color: LuxoraColors.champagne,
                ),
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),
          ],
        ),
      ),
    );
  }

  void _showTriggeredDialog(BuildContext context, WidgetRef ref) {
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
                'Alerte envoyée.',
                style: LuxoraTextStyles.titleLarge,
              ),
              const SizedBox(height: 12),
              Text(
                'Vos contacts d\'urgence ont reçu votre position '
                'et un message d\'alerte.',
                style: LuxoraTextStyles.bodyMedium,
                textAlign: TextAlign.center,
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
                    'Fermer',
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
