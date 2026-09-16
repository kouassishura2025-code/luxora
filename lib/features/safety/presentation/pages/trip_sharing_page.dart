import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/feedback/luxora_toast.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../domain/entities/emergency_contact.dart';
import '../providers/safety_provider.dart';
import '../widgets/contact_checkbox_tile.dart';

class TripSharingPage extends ConsumerWidget {
  const TripSharingPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final contactsAsync = ref.watch(emergencyContactsProvider);
    final sharingState = ref.watch(tripSharingProvider);

    return LuxoraScaffold(
      applyPadding: false,
      appBar: const LuxoraAppBar(
        overline: 'Sécurité',
        title: 'Partage de trajet',
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 16),

            Text(
              'Partagez\nvotre trajet.',
              style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 28),
            ),
            const SizedBox(height: 12),
            Text(
              'Vos proches pourront suivre votre position en temps réel '
              'jusqu\'à votre arrivée.',
              style: LuxoraTextStyles.bodyMedium,
            ),

            const SizedBox(height: LuxoraSpacing.xl),

            // ─── Destinataires ──────────────────────────
            Text(
              'DESTINATAIRES',
              style: LuxoraTextStyles.overline.copyWith(
                fontSize: 10,
                color: LuxoraColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),

            contactsAsync.when(
              data: (contacts) => LuxoraCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var i = 0; i < contacts.length; i++) ...[
                      ContactCheckboxTile(
                        contact: contacts[i],
                        isSelected: sharingState.selectedContactIds
                            .contains(contacts[i].id),
                        onToggle: () => ref
                            .read(tripSharingProvider.notifier)
                            .toggleContact(contacts[i].id),
                      ),
                      if (i != contacts.length - 1)
                        const Divider(
                          color: LuxoraColors.divider,
                          height: 1,
                          indent: 66,
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
                'Erreur',
                style: LuxoraTextStyles.bodyMedium,
              ),
            ),

            const SizedBox(height: LuxoraSpacing.xl),

            // ─── Durée ──────────────────────────────────
            Text(
              'DURÉE DU PARTAGE',
              style: LuxoraTextStyles.overline.copyWith(
                fontSize: 10,
                color: LuxoraColors.textSecondary,
              ),
            ),
            const SizedBox(height: 12),

            Row(
              children: [
                for (final duration in SharingDuration.values) ...[
                  Expanded(
                    child: _DurationChip(
                      duration: duration,
                      isSelected: sharingState.duration == duration,
                      onTap: () => ref
                          .read(tripSharingProvider.notifier)
                          .setDuration(duration),
                    ),
                  ),
                  if (duration != SharingDuration.values.last)
                    const SizedBox(width: 8),
                ],
              ],
            ),

            const SizedBox(height: LuxoraSpacing.xl),

            // ─── Lien généré ────────────────────────────
            if (sharingState.link != null) ...[
              Text(
                'LIEN SÉCURISÉ',
                style: LuxoraTextStyles.overline.copyWith(
                  fontSize: 10,
                  color: LuxoraColors.textSecondary,
                ),
              ),
              const SizedBox(height: 12),

              LuxoraCard(
                padding: const EdgeInsets.all(16),
                goldBorder: true,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        sharingState.link!,
                        style: LuxoraTextStyles.bodyMedium.copyWith(
                          fontSize: 13,
                          color: LuxoraColors.champagne,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    const SizedBox(width: 12),
                    IconButton(
                      icon: const Icon(
                        Icons.copy_rounded,
                        size: 18,
                        color: LuxoraColors.champagne,
                      ),
                      onPressed: () async {
                        await Clipboard.setData(
                          ClipboardData(text: sharingState.link!),
                        );
                        if (context.mounted) {
                          LuxoraToast.show(
                            context,
                            message: 'Lien copié.',
                            variant: LuxoraToastVariant.success,
                          );
                        }
                      },
                      tooltip: 'Copier',
                    ),
                  ],
                ),
              ),

              const SizedBox(height: LuxoraSpacing.lg),
            ],

            const SizedBox(height: LuxoraSpacing.lg),

            // ─── CTA ────────────────────────────────────
            LuxoraPrimaryButton(
              label: sharingState.link == null
                  ? 'Générer le lien'
                  : 'Partager maintenant',
              icon: sharingState.link == null
                  ? Icons.link_rounded
                  : Icons.share_rounded,
              isLoading: sharingState.isGenerating,
              onPressed: sharingState.selectedContactIds.isEmpty
                  ? null
                  : () async {
                      if (sharingState.link == null) {
                        await ref
                            .read(tripSharingProvider.notifier)
                            .generateLink();
                      } else {
                        if (context.mounted) {
                          LuxoraToast.show(
                            context,
                            message: 'Trajet partagé avec vos contacts.',
                            variant: LuxoraToastVariant.success,
                          );
                        }
                      }
                    },
            ),

            const SizedBox(height: LuxoraSpacing.xxxl),
          ],
        ),
      ),
    );
  }
}

class _DurationChip extends StatelessWidget {
  const _DurationChip({
    required this.duration,
    required this.isSelected,
    required this.onTap,
  });

  final SharingDuration duration;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: LuxoraRadii.brMd,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
          decoration: BoxDecoration(
            color: isSelected
                ? LuxoraColors.champagne.withOpacity(0.12)
                : LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brMd,
            border: Border.all(
              color: isSelected
                  ? LuxoraColors.champagne
                  : LuxoraColors.divider,
              width: isSelected ? 1 : 0.5,
            ),
          ),
          child: Center(
            child: Text(
              duration.label,
              style: LuxoraTextStyles.labelMedium.copyWith(
                fontSize: 11,
                color: isSelected
                    ? LuxoraColors.champagne
                    : LuxoraColors.textSecondary,
              ),
              textAlign: TextAlign.center,
              maxLines: 2,
            ),
          ),
        ),
      ),
    );
  }
}
