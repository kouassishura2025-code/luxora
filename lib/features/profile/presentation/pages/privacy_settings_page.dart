import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';

class _PrivacyToggle {
  const _PrivacyToggle(
    this.id,
    this.title,
    this.description,
    this.defaultValue,
  );
  final String id;
  final String title;
  final String description;
  final bool defaultValue;
}

const _toggles = [
  _PrivacyToggle(
    'anonymous',
    'Mode anonyme',
    'Votre nom n\'est pas partagé avec le chauffeur.',
    false,
  ),
  _PrivacyToggle(
    'share_location',
    'Partage de position',
    'Autoriser le suivi en temps réel par vos contacts.',
    true,
  ),
  _PrivacyToggle(
    'analytics',
    'Statistiques anonymes',
    'Aidez-nous à améliorer LUXORA.',
    true,
  ),
  _PrivacyToggle(
    'marketing',
    'Communications',
    'Recevoir les offres exclusives.',
    false,
  ),
];

final _privacyStateProvider =
    StateProvider<Map<String, bool>>((ref) {
  return {
    for (final t in _toggles) t.id: t.defaultValue,
  };
});

class PrivacySettingsPage extends ConsumerWidget {
  const PrivacySettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(_privacyStateProvider);

    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Sécurité',
        title: 'Confidentialité',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text(
            'Votre vie privée.',
            style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 8),
          Text(
            'Contrôlez la façon dont LUXORA utilise vos données.',
            style: LuxoraTextStyles.bodyMedium,
          ),

          const SizedBox(height: LuxoraSpacing.xl),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: LuxoraCard(
                padding: EdgeInsets.zero,
                child: Column(
                  children: [
                    for (var i = 0; i < _toggles.length; i++) ...[
                      _PrivacyTile(
                        toggle: _toggles[i],
                        value: values[_toggles[i].id] ?? false,
                        onChanged: (v) {
                          final notifier =
                              ref.read(_privacyStateProvider.notifier);
                          notifier.state = {
                            ...values,
                            _toggles[i].id: v,
                          };
                        },
                      ),
                      if (i != _toggles.length - 1)
                        const Divider(
                          color: LuxoraColors.divider,
                          height: 1,
                          indent: 20,
                          endIndent: 20,
                        ),
                    ],
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: LuxoraSpacing.lg),

          Center(
            child: Text(
              'Vos données sont chiffrées et ne sont jamais revendues.',
              style: LuxoraTextStyles.caption.copyWith(fontSize: 10),
              textAlign: TextAlign.center,
            ),
          ),

          const SizedBox(height: LuxoraSpacing.lg),
        ],
      ),
    );
  }
}

class _PrivacyTile extends StatelessWidget {
  const _PrivacyTile({
    required this.toggle,
    required this.value,
    required this.onChanged,
  });

  final _PrivacyToggle toggle;
  final bool value;
  final ValueChanged<bool> onChanged;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  toggle.title,
                  style: LuxoraTextStyles.labelLarge.copyWith(fontSize: 14),
                ),
                const SizedBox(height: 4),
                Text(
                  toggle.description,
                  style: LuxoraTextStyles.bodySmall.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          const SizedBox(width: 12),
          Switch.adaptive(
            value: value,
            onChanged: onChanged,
            activeColor: LuxoraColors.champagne,
            activeTrackColor:
                LuxoraColors.champagne.withOpacity(0.3),
            inactiveThumbColor: LuxoraColors.textSecondary,
            inactiveTrackColor: LuxoraColors.graphite,
          ),
        ],
      ),
    );
  }
}
