import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/buttons/luxora_text_button.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/booking_provider.dart';
import '../widgets/booking_progress.dart';
import '../widgets/chauffeur_preference_chip.dart';

class ChauffeurPreferencePage extends ConsumerWidget {
  const ChauffeurPreferencePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final preferences = ref.watch(chauffeurPreferencesProvider);
    final bookingState = ref.watch(bookingProvider);

    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        forceBackButton: true,
        overline: 'Réservation',
        title: 'Préférences',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 8),
          const BookingProgress(currentStep: 3),
          const SizedBox(height: 32),

          Text(
            'Comment souhaitez-vous\nvoyager ?',
            style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 8),
          Text(
            'Sélectionnez vos préférences. Facultatif.',
            style: LuxoraTextStyles.bodyMedium,
          ),

          const SizedBox(height: LuxoraSpacing.xl),

          // ─── Chips ──────────────────────────────────────
          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final pref in preferences)
                    ChauffeurPreferenceChip(
                      preference: pref,
                      selected:
                          bookingState.selectedPreferences.contains(pref.id),
                      onTap: () => ref
                          .read(bookingProvider.notifier)
                          .togglePreference(pref.id),
                    ),
                ],
              ),
            ),
          ),

          const SizedBox(height: LuxoraSpacing.lg),

          // ─── Passer ─────────────────────────────────────
          Center(
            child: LuxoraTextButton(
              label: 'Aucune préférence',
              onPressed: () {
                ref.read(bookingProvider.notifier).reset();
                ref.read(bookingProvider.notifier).setDestination(
                      bookingState.destination ?? '',
                    );
                context.push(RouteNames.rideConfirmation);
              },
            ),
          ),

          const SizedBox(height: 12),

          // ─── CTA ────────────────────────────────────────
          LuxoraPrimaryButton(
            label: 'Continuer',
            icon: Icons.arrow_forward_rounded,
            onPressed: () => context.push(RouteNames.rideConfirmation),
          ),

          const SizedBox(height: LuxoraSpacing.lg),
        ],
      ),
    );
  }
}
