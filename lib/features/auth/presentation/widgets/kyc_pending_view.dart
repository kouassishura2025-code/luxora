import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_ghost_button.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';

/// Écran affiché après soumission du dossier KYC.
class KycPendingView extends StatelessWidget {
  const KycPendingView({super.key, required this.onReset});

  final VoidCallback onReset;

  @override
  Widget build(BuildContext context) {
    return LuxoraScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(),

          // ─── Icône dorée ─────────────────────────────
          Center(
            child: Container(
              width: 96,
              height: 96,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: LuxoraColors.champagne.withOpacity(0.1),
                border: Border.all(
                  color: LuxoraColors.champagne.withOpacity(0.4),
                  width: 1,
                ),
              ),
              child: const Icon(
                Icons.hourglass_top_rounded,
                size: 36,
                color: LuxoraColors.champagne,
              ),
            ),
          ),

          const SizedBox(height: 32),

          Text(
            'Documents reçus.',
            style: LuxoraTextStyles.displayMedium,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Notre équipe vérifie vos documents.\n'
              'Vous serez notifié sous 24h ouvrées.',
              style: LuxoraTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                LuxoraPrimaryButton(
                  label: 'Retour au profil',
                  icon: Icons.person_outline_rounded,
                  onPressed: () => context.go(RouteNames.profile),
                ),
                const SizedBox(height: 12),
                LuxoraGhostButton(
                  label: 'Annuler la soumission',
                  onPressed: onReset,
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
