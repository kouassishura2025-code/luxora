import 'package:flutter/material.dart';

import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/kyc_document.dart';

/// Emplacement d'un document KYC (à fournir ou fourni).
class KycDocumentSlot extends StatelessWidget {
  const KycDocumentSlot({
    super.key,
    required this.type,
    required this.icon,
    required this.hasDocument,
    required this.onAdd,
    required this.onRemove,
    this.optional = false,
  });

  final KycDocumentType type;
  final IconData icon;
  final bool hasDocument;
  final VoidCallback onAdd;
  final VoidCallback onRemove;
  final bool optional;

  @override
  Widget build(BuildContext context) {
    return LuxoraCard(
      padding: const EdgeInsets.all(16),
      goldBorder: hasDocument,
      child: Row(
        children: [
          // ─── Icône / état ────────────────────────────
          AnimatedContainer(
            duration: const Duration(milliseconds: 220),
            width: 44,
            height: 44,
            decoration: BoxDecoration(
              color: hasDocument
                  ? LuxoraColors.champagne.withOpacity(0.15)
                  : LuxoraColors.graphite,
              borderRadius: BorderRadius.circular(12),
              border: hasDocument
                  ? Border.all(
                      color: LuxoraColors.champagne.withOpacity(0.4),
                      width: 0.8,
                    )
                  : null,
            ),
            child: Icon(
              hasDocument ? Icons.check_rounded : icon,
              size: 20,
              color: hasDocument
                  ? LuxoraColors.champagne
                  : LuxoraColors.textSecondary,
            ),
          ),
          const SizedBox(width: 14),

          // ─── Label + statut ──────────────────────────
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        type.label,
                        style: LuxoraTextStyles.labelLarge.copyWith(
                          fontSize: 14,
                        ),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (optional) ...[
                      const SizedBox(width: 6),
                      Text(
                        '· optionnel',
                        style: LuxoraTextStyles.caption.copyWith(
                          fontSize: 9,
                          color: LuxoraColors.textTertiary,
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  hasDocument ? 'Document fourni' : 'À fournir',
                  style: LuxoraTextStyles.bodySmall.copyWith(
                    fontSize: 12,
                    color: hasDocument
                        ? LuxoraColors.success
                        : LuxoraColors.textTertiary,
                  ),
                ),
              ],
            ),
          ),

          // ─── Action ──────────────────────────────────
          if (hasDocument)
            IconButton(
              icon: const Icon(
                Icons.close_rounded,
                size: 18,
                color: LuxoraColors.textSecondary,
              ),
              onPressed: onRemove,
            )
          else
            TextButton(
              onPressed: onAdd,
              style: TextButton.styleFrom(
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
                tapTargetSize: MaterialTapTargetSize.shrinkWrap,
              ),
              child: Text(
                'Ajouter',
                style: LuxoraTextStyles.labelMedium.copyWith(
                  color: LuxoraColors.champagne,
                ),
              ),
            ),
        ],
      ),
    );
  }
}
