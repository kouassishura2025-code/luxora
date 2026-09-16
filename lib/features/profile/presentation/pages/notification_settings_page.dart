import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';

class _NotifToggle {
  const _NotifToggle(this.id, this.title, this.description, this.defaultValue);
  final String id;
  final String title;
  final String description;
  final bool defaultValue;
}

const _toggles = [
  _NotifToggle(
    'booking',
    'Réservations',
    'Confirmations et rappels de trajet.',
    true,
  ),
  _NotifToggle(
    'driver',
    'Chauffeur',
    'Arrivée imminente de votre chauffeur.',
    true,
  ),
  _NotifToggle(
    'concierge',
    'Concierge',
    'Nouveaux messages du concierge.',
    true,
  ),
  _NotifToggle(
    'promo',
    'Offres exclusives',
    'Promotions et événements LUXORA.',
    false,
  ),
];

final _notifStateProvider =
    StateProvider<Map<String, bool>>((ref) {
  return {
    for (final t in _toggles) t.id: t.defaultValue,
  };
});

class NotificationSettingsPage extends ConsumerWidget {
  const NotificationSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final values = ref.watch(_notifStateProvider);

    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Préférences',
        title: 'Notifications',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text(
            'Restez informé.',
            style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 8),
          Text(
            'Choisissez ce que vous souhaitez recevoir.',
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
                      _NotifTile(
                        toggle: _toggles[i],
                        value: values[_toggles[i].id] ?? false,
                        onChanged: (v) {
                          final notifier =
                              ref.read(_notifStateProvider.notifier);
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
        ],
      ),
    );
  }
}

class _NotifTile extends StatelessWidget {
  const _NotifTile({
    required this.toggle,
    required this.value,
    required this.onChanged,
  });

  final _NotifToggle toggle;
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
