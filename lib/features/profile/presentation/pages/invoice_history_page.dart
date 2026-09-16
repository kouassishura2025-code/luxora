import 'package:flutter/material.dart';

import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';

class InvoiceHistoryPage extends StatelessWidget {
  const InvoiceHistoryPage({super.key});

  static const _invoices = [
    ('14 septembre 2026', 'Tour Eiffel → Arc de Triomphe', '45 €'),
    ('8 septembre 2026', 'CDG → Le Bristol Paris', '120 €'),
    ('1 septembre 2026', 'Hôtel de Crillon → Gare du Nord', '38 €'),
    ('24 août 2026', 'Aéroport Orly → Ritz Paris', '95 €'),
    ('15 août 2026', 'Tour Eiffel → Champs-Élysées', '32 €'),
  ];

  @override
  Widget build(BuildContext context) {
    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Compte',
        title: 'Factures',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text(
            'Historique.',
            style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 26),
          ),
          const SizedBox(height: 8),
          Text(
            'Vos trajets et leurs factures.',
            style: LuxoraTextStyles.bodyMedium,
          ),

          const SizedBox(height: LuxoraSpacing.xl),

          Expanded(
            child: ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemCount: _invoices.length,
              separatorBuilder: (_, __) => const SizedBox(height: 10),
              itemBuilder: (context, index) {
                final (date, route, price) = _invoices[index];
                return LuxoraCard(
                  padding: const EdgeInsets.all(16),
                  onTap: () {},
                  child: Row(
                    children: [
                      Container(
                        width: 40,
                        height: 40,
                        decoration: BoxDecoration(
                          color: LuxoraColors.graphite,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: const Icon(
                          Icons.receipt_outlined,
                          size: 18,
                          color: LuxoraColors.champagne,
                        ),
                      ),
                      const SizedBox(width: 14),
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              route,
                              style: LuxoraTextStyles.labelLarge
                                  .copyWith(fontSize: 13),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                            const SizedBox(height: 3),
                            Text(
                              date,
                              style: LuxoraTextStyles.bodySmall
                                  .copyWith(fontSize: 11),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(width: 12),
                      Text(
                        price,
                        style: LuxoraTextStyles.titleMedium.copyWith(
                          fontSize: 16,
                          color: LuxoraColors.champagne,
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
