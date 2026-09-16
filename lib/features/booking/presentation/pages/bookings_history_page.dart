import 'package:flutter/material.dart';

import '../../../../design_system/components/feedback/luxora_empty_state.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';

class BookingsHistoryPage extends StatelessWidget {
  const BookingsHistoryPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LuxoraScaffold(
      applyPadding: false,
      appBar: const LuxoraAppBar(
        overline: 'Historique',
        title: 'Réservations',
        showBackButton: false,
      ),
      body: const LuxoraEmptyState(
        icon: Icons.receipt_long_outlined,
        title: 'Aucune réservation',
        message:
            'Vos trajets passés et à venir apparaîtront ici.\n'
            'Réservez votre premier chauffeur depuis l\'accueil.',
      ),
    );
  }
}
