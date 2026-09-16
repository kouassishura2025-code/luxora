import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_text_button.dart';
import '../../../../design_system/components/inputs/luxora_code_field.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/auth_provider.dart';

class OtpVerificationPage extends ConsumerWidget {
  const OtpVerificationPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final flowState = ref.watch(otpFlowProvider);
    final phone = flowState.phoneNumber ?? '';

    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Vérification',
        title: 'Code de sécurité',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),

          Text('Saisissez le code.', style: LuxoraTextStyles.displayMedium),
          const SizedBox(height: 12),
          Text(
            'Un code à 6 chiffres a été envoyé au $phone.',
            style: LuxoraTextStyles.bodyMedium,
          ),

          const SizedBox(height: 32),

          // ─── Indice mode démo ────────────────────────────
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            decoration: BoxDecoration(
              color: LuxoraColors.champagne.withOpacity(0.08),
              borderRadius: BorderRadius.circular(12),
              border: Border.all(
                color: LuxoraColors.champagne.withOpacity(0.3),
                width: 0.5,
              ),
            ),
            child: Row(
              children: [
                Icon(
                  Icons.info_outline_rounded,
                  size: 18,
                  color: LuxoraColors.champagne,
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: Text(
                    'Mode démo · Utilisez le code 123456',
                    style: LuxoraTextStyles.bodySmall.copyWith(
                      color: LuxoraColors.champagne,
                      fontSize: 12,
                    ),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 32),

          LuxoraCodeField(
            length: 6,
            onCompleted: (code) async {
              final ok =
                  await ref.read(otpFlowProvider.notifier).verifyOtp(code);
              if (!context.mounted) return;
              if (ok) {
                context.go(RouteNames.home);
              } else {
                final error = ref.read(otpFlowProvider).error;
                if (error != null) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(content: Text(error)),
                  );
                }
              }
            },
          ),

          const SizedBox(height: 32),

          Center(
            child: LuxoraTextButton(
              label: 'Renvoyer le code',
              onPressed: flowState.isLoading
                  ? null
                  : () {
                      ref
                          .read(otpFlowProvider.notifier)
                          .sendOtp(flowState.phoneNumber ?? '');
                    },
            ),
          ),
        ],
      ),
    );
  }
}
