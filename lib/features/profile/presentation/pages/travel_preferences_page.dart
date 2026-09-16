import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';

class _Preference {
  const _Preference(this.id, this.label, this.icon);
  final String id;
  final String label;
  final IconData icon;
}

const _preferences = [
  _Preference('silence', 'Silence', Icons.volume_off_outlined),
  _Preference('music', 'Musique douce', Icons.music_note_outlined),
  _Preference('conversation', 'Conversation', Icons.chat_bubble_outline),
  _Preference('ac', 'Climatisation', Icons.ac_unit_outlined),
  _Preference('water', 'Eau fraîche', Icons.local_drink_outlined),
  _Preference('wifi', 'Wi-Fi', Icons.wifi_outlined),
  _Preference('newspaper', 'Presse', Icons.menu_book_outlined),
  _Preference('english', 'Anglais', Icons.language_outlined),
];

final _selectedPrefsProvider = StateProvider<Set<String>>((ref) {
  return {'silence', 'ac', 'water'};
});

class TravelPreferencesPage extends ConsumerWidget {
  const TravelPreferencesPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selected = ref.watch(_selectedPrefsProvider);

    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Préférences',
        title: 'Voyage',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),

          Text(
            'Vos préférences.',
            style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 8),
          Text(
            'Appliquées automatiquement à chaque trajet.',
            style: LuxoraTextStyles.bodyMedium,
          ),

          const SizedBox(height: LuxoraSpacing.xl),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Wrap(
                spacing: 10,
                runSpacing: 10,
                children: [
                  for (final pref in _preferences)
                    _PreferenceChip(
                      pref: pref,
                      selected: selected.contains(pref.id),
                      onTap: () {
                        final notifier =
                            ref.read(_selectedPrefsProvider.notifier);
                        final next = Set<String>.from(selected);
                        if (next.contains(pref.id)) {
                          next.remove(pref.id);
                        } else {
                          next.add(pref.id);
                        }
                        notifier.state = next;
                      },
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _PreferenceChip extends StatelessWidget {
  const _PreferenceChip({
    required this.pref,
    required this.selected,
    required this.onTap,
  });

  final _Preference pref;
  final bool selected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: LuxoraRadii.brPill,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: 18,
            vertical: 12,
          ),
          decoration: BoxDecoration(
            color: selected
                ? LuxoraColors.champagne.withOpacity(0.12)
                : LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brPill,
            border: Border.all(
              color: selected
                  ? LuxoraColors.champagne
                  : LuxoraColors.divider,
              width: selected ? 1 : 0.5,
            ),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                pref.icon,
                size: 15,
                color: selected
                    ? LuxoraColors.champagne
                    : LuxoraColors.textSecondary,
              ),
              const SizedBox(width: 8),
              Text(
                pref.label,
                style: LuxoraTextStyles.labelMedium.copyWith(
                  fontSize: 13,
                  color: selected
                      ? LuxoraColors.champagne
                      : LuxoraColors.textSecondary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
