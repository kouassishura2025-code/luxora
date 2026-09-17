import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../core/l10n/locale_provider.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/motion/luxora_haptics.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';

class LanguageSettingsPage extends ConsumerWidget {
  const LanguageSettingsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final currentLocale = ref.watch(localeProvider);
    final l10n = AppLocalizations.of(context);

    return LuxoraScaffold(
      appBar: LuxoraAppBar(
        overline: l10n.profileOverline,
        title: l10n.languageTitle,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 24),
          LuxoraCard(
            padding: EdgeInsets.zero,
            child: Column(
              children: [
                _LanguageTile(
                  label: l10n.languageSystem,
                  locale: null,
                  current: currentLocale,
                  onTap: () {
                    LuxoraHaptics.selection();
                    ref.read(localeProvider.notifier).state = null;
                  },
                ),
                const Divider(
                  color: LuxoraColors.divider,
                  height: 1,
                  indent: 20,
                ),
                _LanguageTile(
                  label: l10n.languageFrench,
                  locale: const Locale('fr'),
                  current: currentLocale,
                  onTap: () {
                    LuxoraHaptics.selection();
                    ref.read(localeProvider.notifier).state =
                        const Locale('fr');
                  },
                ),
                const Divider(
                  color: LuxoraColors.divider,
                  height: 1,
                  indent: 20,
                ),
                _LanguageTile(
                  label: l10n.languageEnglish,
                  locale: const Locale('en'),
                  current: currentLocale,
                  onTap: () {
                    LuxoraHaptics.selection();
                    ref.read(localeProvider.notifier).state =
                        const Locale('en');
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageTile extends StatelessWidget {
  const _LanguageTile({
    required this.label,
    required this.locale,
    required this.current,
    required this.onTap,
  });

  final String label;
  final Locale? locale;
  final Locale? current;
  final VoidCallback onTap;

  bool get _isSelected => current == locale;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  label,
                  style: LuxoraTextStyles.bodyLarge.copyWith(
                    fontSize: 15,
                    color: _isSelected
                        ? LuxoraColors.champagne
                        : LuxoraColors.textPrimary,
                  ),
                ),
              ),
              if (_isSelected)
                const Icon(
                  Icons.check_rounded,
                  size: 20,
                  color: LuxoraColors.champagne,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
