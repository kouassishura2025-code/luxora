import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../../domain/entities/kyc_document.dart';
import '../providers/kyc_provider.dart';
import '../widgets/kyc_document_slot.dart';
import '../widgets/kyc_pending_view.dart';
import '../widgets/kyc_progress_bar.dart';

class KycVerificationPage extends ConsumerWidget {
  const KycVerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final kyc = ref.watch(kycProvider);

    if (kyc.status == KycStatus.pendingReview) {
      return KycPendingView(
        onReset: () => ref.read(kycProvider.notifier).reset(),
      );
    }

    return LuxoraScaffold(
      appBar: LuxoraAppBar(
        overline: l10n.otpOverline,
        title: 'Identité',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          KycProgressBar(progress: kyc.progress),
          const SizedBox(height: 32),

          Text(
            'Vérifions\nvotre identité.',
            style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 28),
          ),
          const SizedBox(height: 12),
          Text(
            'Fournissez les documents suivants pour activer votre compte '
            'et accéder à tous les services LUXORA.',
            style: LuxoraTextStyles.bodyMedium,
          ),

          const SizedBox(height: LuxoraSpacing.xl),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'REQUIS',
                    style: LuxoraTextStyles.overline.copyWith(
                      fontSize: 10,
                      color: LuxoraColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  KycDocumentSlot(
                    type: KycDocumentType.idCard,
                    icon: Icons.badge_outlined,
                    hasDocument: kyc.hasDocument(KycDocumentType.idCard),
                    onAdd: () => ref
                        .read(kycProvider.notifier)
                        .addDocument(
                          KycDocumentType.idCard,
                          'cni_kouassi.jpg',
                        ),
                    onRemove: () => ref
                        .read(kycProvider.notifier)
                        .removeDocument(KycDocumentType.idCard),
                  ),
                  const SizedBox(height: 10),
                  KycDocumentSlot(
                    type: KycDocumentType.selfie,
                    icon: Icons.face_outlined,
                    hasDocument: kyc.hasDocument(KycDocumentType.selfie),
                    onAdd: () => ref
                        .read(kycProvider.notifier)
                        .addDocument(
                          KycDocumentType.selfie,
                          'selfie_kouassi.jpg',
                        ),
                    onRemove: () => ref
                        .read(kycProvider.notifier)
                        .removeDocument(KycDocumentType.selfie),
                  ),

                  const SizedBox(height: LuxoraSpacing.lg),

                  Text(
                    'OPTIONNELS',
                    style: LuxoraTextStyles.overline.copyWith(
                      fontSize: 10,
                      color: LuxoraColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 12),

                  KycDocumentSlot(
                    type: KycDocumentType.passport,
                    icon: Icons.menu_book_outlined,
                    hasDocument:
                        kyc.hasDocument(KycDocumentType.passport),
                    optional: true,
                    onAdd: () => ref
                        .read(kycProvider.notifier)
                        .addDocument(
                          KycDocumentType.passport,
                          'passeport_kouassi.jpg',
                        ),
                    onRemove: () => ref
                        .read(kycProvider.notifier)
                        .removeDocument(KycDocumentType.passport),
                  ),
                  const SizedBox(height: 10),
                  KycDocumentSlot(
                    type: KycDocumentType.driverLicense,
                    icon: Icons.drive_eta_outlined,
                    hasDocument: kyc
                        .hasDocument(KycDocumentType.driverLicense),
                    optional: true,
                    onAdd: () => ref
                        .read(kycProvider.notifier)
                        .addDocument(
                          KycDocumentType.driverLicense,
                          'permis_kouassi.jpg',
                        ),
                    onRemove: () => ref
                        .read(kycProvider.notifier)
                        .removeDocument(KycDocumentType.driverLicense),
                  ),

                  const SizedBox(height: LuxoraSpacing.lg),

                  Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: LuxoraColors.graphite,
                      borderRadius: BorderRadius.circular(12),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const Icon(
                          Icons.lock_outline_rounded,
                          size: 16,
                          color: LuxoraColors.champagne,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            'Vos documents sont chiffrés et stockés de '
                            'manière sécurisée. Ils ne sont jamais partagés.',
                            style: LuxoraTextStyles.bodySmall.copyWith(
                              fontSize: 11,
                              color: LuxoraColors.textTertiary,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: LuxoraSpacing.lg),
                ],
              ),
            ),
          ),

          if (kyc.error != null) ...[
            const SizedBox(height: 8),
            Text(
              kyc.error!,
              style: LuxoraTextStyles.bodySmall.copyWith(
                color: LuxoraColors.error,
                fontSize: 12,
              ),
              textAlign: TextAlign.center,
            ),
          ],

          const SizedBox(height: 12),

          LuxoraPrimaryButton(
            label: 'Soumettre pour vérification',
            icon: Icons.check_rounded,
            isLoading: kyc.isSubmitting,
            onPressed: kyc.isComplete
                ? () async {
                    await ref.read(kycProvider.notifier).submit();
                  }
                : null,
          ),

          const SizedBox(height: 8),

          Center(
            child: Text(
              'Traitement sous 24h ouvrées.',
              style: LuxoraTextStyles.caption.copyWith(fontSize: 10),
            ),
          ),

          const SizedBox(height: LuxoraSpacing.lg),
        ],
      ),
    );
  }
}
