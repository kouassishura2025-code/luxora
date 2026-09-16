import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/inputs/luxora_text_field.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/auth_provider.dart';

class PhoneEntryPage extends ConsumerStatefulWidget {
  const PhoneEntryPage({super.key});

  @override
  ConsumerState<PhoneEntryPage> createState() => _PhoneEntryPageState();
}

class _PhoneEntryPageState extends ConsumerState<PhoneEntryPage> {
  final _controller = TextEditingController(text: '+225');
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  Future<void> _sendOtp() async {
    if (!(_formKey.currentState?.validate() ?? false)) return;
    FocusScope.of(context).unfocus();

    final ok = await ref
        .read(otpFlowProvider.notifier)
        .sendOtp(_controller.text.trim());

    if (!mounted) return;

    if (ok) {
      context.go(RouteNames.otpVerification);
    } else {
      final error = ref.read(otpFlowProvider).error;
      if (error != null) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text(error)),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final flowState = ref.watch(otpFlowProvider);

    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Identification',
        title: 'Votre numéro',
      ),
      body: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 24),
            Text('Bienvenue.', style: LuxoraTextStyles.displayMedium),
            const SizedBox(height: 12),
            Text(
              'Indiquez votre numéro de téléphone. '
              'Nous vous enverrons un code de vérification.',
              style: LuxoraTextStyles.bodyMedium,
            ),
            const SizedBox(height: LuxoraSpacing.xxxl),
            LuxoraTextField(
              controller: _controller,
              label: 'Numéro de téléphone',
              hint: '+225 XX XX XX XX XX',
              prefixIcon: Icons.phone_outlined,
              keyboardType: TextInputType.phone,
              textInputAction: TextInputAction.done,
              onSubmitted: (_) => _sendOtp(),
              validator: (value) {
                final v = value?.trim() ?? '';
                if (v.isEmpty) return 'Numéro requis';
                if (v.length < 8) return 'Numéro trop court';
                if (!v.startsWith('+')) {
                  return 'Format international requis (+225…)';
                }
                return null;
              },
            ),
            const Spacer(),
            LuxoraPrimaryButton(
              label: 'Recevoir mon code',
              icon: Icons.arrow_forward_rounded,
              isLoading: flowState.isLoading,
              onPressed: _sendOtp,
            ),
            const SizedBox(height: 16),
            Center(
              child: Text(
                'En continuant, vous acceptez nos conditions générales.',
                style: LuxoraTextStyles.caption.copyWith(
                  fontSize: 10,
                  color: LuxoraColors.textTertiary,
                ),
                textAlign: TextAlign.center,
              ),
            ),
            const SizedBox(height: LuxoraSpacing.lg),
          ],
        ),
      ),
    );
  }
}
