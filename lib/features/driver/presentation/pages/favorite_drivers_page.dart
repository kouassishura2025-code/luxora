import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/feedback/luxora_empty_state.dart';
import '../../../../design_system/components/feedback/luxora_toast.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/driver_provider.dart';
import '../widgets/driver_favorite_card.dart';

class FavoriteDriversPage extends ConsumerWidget {
  const FavoriteDriversPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(favoriteDriversProvider);
    final drivers = state.drivers;

    return LuxoraScaffold(
      applyPadding: false,
      appBar: const LuxoraAppBar(
        overline: 'Préférences',
        title: 'Chauffeurs favoris',
      ),
      body: drivers.isEmpty
          ? const LuxoraEmptyState(
              icon: Icons.star_outline_rounded,
              title: 'Aucun favori',
              message:
                  'Vos chauffeurs préférés apparaîtront ici.\n'
                  'Ajoutez-en après un trajet mémorable.',
            )
          : SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  const SizedBox(height: 16),

                  Text(
                    'Vos chauffeurs\nde confiance.',
                    style: LuxoraTextStyles.displayMedium
                        .copyWith(fontSize: 28),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    '${drivers.length} chauffeur${drivers.length > 1 ? 's' : ''} '
                    'dans votre cercle privé.',
                    style: LuxoraTextStyles.bodyMedium,
                  ),

                  const SizedBox(height: LuxoraSpacing.xl),

                  for (final driver in drivers) ...[
                    DriverFavoriteCard(
                      driver: driver,
                      isRemoving: state.removingIds.contains(driver.id),
                      onTap: () => _showDriverSheet(context, driver),
                      onToggleFavorite: () async {
                        await ref
                            .read(favoriteDriversProvider.notifier)
                            .removeFavorite(driver.id);
                        if (context.mounted) {
                          LuxoraToast.show(
                            context,
                            message:
                                '${driver.displayName} retiré des favoris.',
                            variant: LuxoraToastVariant.neutral,
                          );
                        }
                      },
                    ),
                    const SizedBox(height: 10),
                  ],

                  const SizedBox(height: LuxoraSpacing.xl),

                  Center(
                    child: Text(
                      'Vos favoris sont prioritaires lors de la réservation.',
                      style: LuxoraTextStyles.caption.copyWith(fontSize: 10),
                      textAlign: TextAlign.center,
                    ),
                  ),

                  const SizedBox(height: LuxoraSpacing.xxxl),
                ],
              ),
            ),
    );
  }

  void _showDriverSheet(BuildContext context, dynamic driver) {
    LuxoraToast.show(
      context,
      message: 'Détails de ${driver.displayName} bientôt disponibles.',
    );
  }
}
