import 'package:flutter/material.dart';

import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/app_notification.dart';

/// Tuile d'une notification.
class NotificationTile extends StatelessWidget {
  const NotificationTile({
    super.key,
    required this.notification,
    required this.onTap,
  });

  final AppNotification notification;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final isUnread = !notification.isRead;

    return Dismissible(
      key: ValueKey(notification.id),
      direction: DismissDirection.endToStart,
      background: Container(
        margin: const EdgeInsets.only(bottom: 10),
        padding: const EdgeInsets.symmetric(horizontal: 24),
        decoration: BoxDecoration(
          color: LuxoraColors.error.withOpacity(0.15),
          borderRadius: BorderRadius.circular(16),
        ),
        alignment: Alignment.centerRight,
        child: const Icon(
          Icons.delete_outline_rounded,
          color: LuxoraColors.error,
          size: 22,
        ),
      ),
      child: LuxoraCard(
        padding: const EdgeInsets.all(16),
        goldBorder: isUnread,
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ─── Icône catégorie ─────────────────────
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isUnread
                    ? LuxoraColors.champagne.withOpacity(0.15)
                    : LuxoraColors.graphite,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(
                notification.category.icon,
                size: 18,
                color: isUnread
                    ? LuxoraColors.champagne
                    : LuxoraColors.textSecondary,
              ),
            ),

            const SizedBox(width: 14),

            // ─── Contenu ─────────────────────────────
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      if (isUnread) ...[
                        Container(
                          width: 6,
                          height: 6,
                          decoration: const BoxDecoration(
                            color: LuxoraColors.champagne,
                            shape: BoxShape.circle,
                          ),
                        ),
                        const SizedBox(width: 8),
                      ],
                      Expanded(
                        child: Text(
                          notification.title,
                          style: LuxoraTextStyles.labelLarge.copyWith(
                            fontSize: 14,
                            color: LuxoraColors.textPrimary,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 4),
                  Text(
                    notification.body,
                    style: LuxoraTextStyles.bodySmall.copyWith(
                      fontSize: 12,
                      height: 1.4,
                    ),
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                  ),
                  const SizedBox(height: 6),
                  Text(
                    _formatRelative(notification.receivedAt),
                    style: LuxoraTextStyles.caption.copyWith(
                      fontSize: 10,
                      color: LuxoraColors.textTertiary,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  String _formatRelative(DateTime date) {
    final diff = DateTime.now().difference(date);
    if (diff.inMinutes < 1) return 'À l\'instant';
    if (diff.inMinutes < 60) return 'Il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Il y a ${diff.inHours} h';
    if (diff.inDays < 7) return 'Il y a ${diff.inDays} j';
    return 'Il y a ${(diff.inDays / 7).floor()} sem';
  }
}
