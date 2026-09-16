import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Réponse rapide prédéfinie.
class QuickReply {
  const QuickReply({
    required this.label,
    required this.message,
    required this.icon,
  });

  final String label;
  final String message;
  final IconData icon;
}

/// Réponses rapides contextuelles.
const List<QuickReply> kQuickReplies = [
  QuickReply(
    label: 'Restaurant',
    message: 'Je voudrais réserver une table pour ce soir.',
    icon: Icons.restaurant_outlined,
  ),
  QuickReply(
    label: 'Fleurs',
    message: 'Je souhaite faire livrer un bouquet.',
    icon: Icons.local_florist_outlined,
  ),
  QuickReply(
    label: 'Spectacle',
    message: 'Des places pour un spectacle ce soir ?',
    icon: Icons.theater_comedy_outlined,
  ),
  QuickReply(
    label: 'Chauffeur',
    message: 'Réserver un chauffeur rapidement.',
    icon: Icons.directions_car_filled_outlined,
  ),
  QuickReply(
    label: 'Hôtel',
    message: 'Je cherche une suite pour deux nuits.',
    icon: Icons.hotel_outlined,
  ),
];

/// Barre horizontale de réponses rapides.
class QuickReplies extends StatelessWidget {
  const QuickReplies({
    super.key,
    required this.replies,
    required this.onTap,
  });

  final List<QuickReply> replies;
  final void Function(QuickReply) onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 40,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: replies.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final reply = replies[index];
          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onTap(reply),
              borderRadius: LuxoraRadii.brPill,
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 14,
                  vertical: 10,
                ),
                decoration: BoxDecoration(
                  color: LuxoraColors.charcoal,
                  borderRadius: LuxoraRadii.brPill,
                  border: Border.all(
                    color: LuxoraColors.champagne.withOpacity(0.3),
                    width: 0.5,
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(
                      reply.icon,
                      size: 14,
                      color: LuxoraColors.champagne,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      reply.label,
                      style: LuxoraTextStyles.labelMedium.copyWith(
                        fontSize: 12,
                        color: LuxoraColors.textPrimary,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
