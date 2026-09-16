import 'package:flutter/material.dart';

import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';

class PaymentMethodsPage extends StatelessWidget {
  const PaymentMethodsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return LuxoraScaffold(
      appBar: const LuxoraAppBar(
        overline: 'Compte',
        title: 'Paiement',
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const SizedBox(height: 16),
          Text(
            'Vos moyens\nde paiement.',
            style: LuxoraTextStyles.displayMedium.copyWith(fontSize: 26),
          ),

          const SizedBox(height: LuxoraSpacing.xl),

          Expanded(
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  _CreditCard(
                    label: 'CARTE PRINCIPALE',
                    number: '•••• •••• •••• 4242',
                    holder: 'KOUASSI SHURA',
                    expiry: '12/28',
                    isPrimary: true,
                  ),
                  const SizedBox(height: 14),
                  _CreditCard(
                    label: 'CARTE SECONDAIRE',
                    number: '•••• •••• •••• 8888',
                    holder: 'KOUASSI SHURA',
                    expiry: '06/27',
                    isPrimary: false,
                  ),
                ],
              ),
            ),
          ),

          const SizedBox(height: LuxoraSpacing.lg),

          LuxoraCard(
            padding: const EdgeInsets.all(16),
            onTap: () {},
            child: Row(
              children: [
                Container(
                  width: 40,
                  height: 40,
                  decoration: BoxDecoration(
                    color: LuxoraColors.champagne.withOpacity(0.12),
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: const Icon(
                    Icons.add_rounded,
                    size: 20,
                    color: LuxoraColors.champagne,
                  ),
                ),
                const SizedBox(width: 14),
                Text(
                  'Ajouter une carte',
                  style: LuxoraTextStyles.labelLarge.copyWith(fontSize: 14),
                ),
              ],
            ),
          ),

          const SizedBox(height: LuxoraSpacing.lg),
        ],
      ),
    );
  }
}

class _CreditCard extends StatelessWidget {
  const _CreditCard({
    required this.label,
    required this.number,
    required this.holder,
    required this.expiry,
    required this.isPrimary,
  });

  final String label;
  final String number;
  final String holder;
  final String expiry;
  final bool isPrimary;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(22),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isPrimary
              ? [
                  LuxoraColors.champagne.withOpacity(0.9),
                  LuxoraColors.champagneDeep,
                ]
              : [
                  LuxoraColors.graphite,
                  LuxoraColors.charcoal,
                ],
        ),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(
          color: isPrimary
              ? LuxoraColors.champagneLight.withOpacity(0.5)
              : LuxoraColors.divider,
          width: 0.5,
        ),
        boxShadow: isPrimary
            ? [
                BoxShadow(
                  color: LuxoraColors.champagne.withOpacity(0.2),
                  blurRadius: 24,
                  spreadRadius: -4,
                  offset: const Offset(0, 8),
                ),
              ]
            : null,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                label,
                style: LuxoraTextStyles.caption.copyWith(
                  fontSize: 9,
                  color: isPrimary
                      ? LuxoraColors.obsidian
                      : LuxoraColors.textTertiary,
                  letterSpacing: 2,
                ),
              ),
              Icon(
                Icons.contactless_outlined,
                size: 22,
                color: isPrimary
                    ? LuxoraColors.obsidian
                    : LuxoraColors.textSecondary,
              ),
            ],
          ),
          const SizedBox(height: 32),
          Text(
            number,
            style: LuxoraTextStyles.titleMedium.copyWith(
              fontSize: 18,
              letterSpacing: 2,
              color: isPrimary
                  ? LuxoraColors.obsidian
                  : LuxoraColors.textPrimary,
            ),
          ),
          const SizedBox(height: 20),
          Row(
            children: [
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'TITULAIRE',
                      style: LuxoraTextStyles.caption.copyWith(
                        fontSize: 8,
                        color: isPrimary
                            ? LuxoraColors.obsidian.withOpacity(0.7)
                            : LuxoraColors.textTertiary,
                        letterSpacing: 1.6,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      holder,
                      style: LuxoraTextStyles.labelMedium.copyWith(
                        fontSize: 12,
                        color: isPrimary
                            ? LuxoraColors.obsidian
                            : LuxoraColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'EXPIRE',
                    style: LuxoraTextStyles.caption.copyWith(
                      fontSize: 8,
                      color: isPrimary
                          ? LuxoraColors.obsidian.withOpacity(0.7)
                          : LuxoraColors.textTertiary,
                      letterSpacing: 1.6,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    expiry,
                    style: LuxoraTextStyles.labelMedium.copyWith(
                      fontSize: 12,
                      color: isPrimary
                          ? LuxoraColors.obsidian
                          : LuxoraColors.textPrimary,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
