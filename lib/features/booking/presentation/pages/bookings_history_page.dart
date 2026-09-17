import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/feedback/luxora_empty_state.dart';
import '../../../../design_system/components/feedback/luxora_skeleton.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';

final _bookingsLoadedProvider = FutureProvider<void>((ref) async {
  await Future<void>.delayed(const Duration(seconds: 2));
});

class BookingsHistoryPage extends ConsumerWidget {
  const BookingsHistoryPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final loaded = ref.watch(_bookingsLoadedProvider);

    return LuxoraScaffold(
      applyPadding: false,
      appBar: LuxoraAppBar(
        overline: 'Historique',
        title: 'Réservations',
        showBackButton: false,
      ),
      body: loaded.when(
        loading: () => const LuxoraSkeletonList(count: 4),
        error: (_, __) => LuxoraEmptyState(
          icon: Icons.receipt_long_outlined,
          title: l10n.commonError,
          message: l10n.commonRetry,
        ),
        data: (_) => LuxoraEmptyState(
          icon: Icons.receipt_long_outlined,
          title: 'Aucune réservation',
          message:
              'Vos trajets passés et à venir apparaîtront ici.\n'
              'Réservez votre premier chauffeur depuis l\'accueil.',
        ),
      ),
    );
  }
}
