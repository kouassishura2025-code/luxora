import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/feedback/luxora_toast.dart';
import '../../../../design_system/components/inputs/luxora_text_field.dart';
import '../../../../design_system/components/media/luxora_avatar.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/profile_provider.dart';

class EditProfilePage extends ConsumerStatefulWidget {
  const EditProfilePage({super.key});

  @override
  ConsumerState<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends ConsumerState<EditProfilePage> {
  late final TextEditingController _firstNameCtrl;
  late final TextEditingController _lastNameCtrl;
  late final TextEditingController _emailCtrl;

  @override
  void initState() {
    super.initState();
    final profile = ref.read(profileProvider).profile;
    _firstNameCtrl = TextEditingController(text: profile.firstName ?? '');
    _lastNameCtrl = TextEditingController(text: profile.lastName ?? '');
    _emailCtrl = TextEditingController(text: profile.email ?? '');
  }

  @override
  void dispose() {
    _firstNameCtrl.dispose();
    _lastNameCtrl.dispose();
    _emailCtrl.dispose();
    super.dispose();
  }

  Future<void> _save() async {
    FocusScope.of(context).unfocus();
    await ref.read(profileProvider.notifier).updateProfile(
          firstName: _firstNameCtrl.text.trim(),
          lastName: _lastNameCtrl.text.trim(),
          email: _emailCtrl.text.trim(),
        );
    if (mounted) {
      LuxoraToast.show(
        context,
        message: 'Profil mis à jour.',
        variant: LuxoraToastVariant.success,
      );
      context.pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(profileProvider);

    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Compte',
        title: 'Mes informations',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),

          // ─── Avatar ──────────────────────────────────
          Center(
            child: Column(
              children: [
                LuxoraAvatar(
                  initials: state.profile.initials,
                  size: 96,
                  goldBorder: true,
                ),
                const SizedBox(height: 12),
                Text(
                  'Modifier la photo',
                  style: LuxoraTextStyles.labelMedium.copyWith(
                    color: const Color(0xFFC9A24B),
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: LuxoraSpacing.xxxl),

          // ─── Champs ──────────────────────────────────
          LuxoraTextField(
            controller: _firstNameCtrl,
            label: 'Prénom',
            hint: 'Kouassi',
            prefixIcon: Icons.person_outline_rounded,
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: LuxoraSpacing.lg),

          LuxoraTextField(
            controller: _lastNameCtrl,
            label: 'Nom',
            hint: 'Shura',
            prefixIcon: Icons.person_outline_rounded,
            textInputAction: TextInputAction.next,
          ),

          const SizedBox(height: LuxoraSpacing.lg),

          LuxoraTextField(
            controller: _emailCtrl,
            label: 'Email',
            hint: 'kouassi@luxora.app',
            prefixIcon: Icons.mail_outline_rounded,
            keyboardType: TextInputType.emailAddress,
            textInputAction: TextInputAction.done,
          ),

          const Spacer(),

          // ─── CTA ─────────────────────────────────────
          LuxoraPrimaryButton(
            label: 'Enregistrer',
            icon: Icons.check_rounded,
            isLoading: state.isSaving,
            onPressed: _save,
          ),

          const SizedBox(height: LuxoraSpacing.lg),
        ],
      ),
    );
  }
}
