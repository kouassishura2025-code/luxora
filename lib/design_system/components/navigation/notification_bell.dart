import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../app/router/route_names.dart';
import '../../../features/notifications/presentation/providers/notification_provider.dart';
import '../../foundations/colors/luxora_colors.dart';

/// Cloche de notification avec badge doré.
class NotificationBell extends ConsumerWidget {
  const NotificationBell({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final unreadCount = ref.watch(unreadCountProvider);
    final hasUnread = unreadCount > 0;

    return Stack(
      clipBehavior: Clip.none,
      children: [
        IconButton(
          icon: const Icon(
            Icons.notifications_none_rounded,
            size: 22,
            color: LuxoraColors.textPrimary,
          ),
          onPressed: () => context.go(RouteNames.notifications),
        ),
        if (hasUnread)
          Positioned(
            right: 6,
            top: 6,
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 5,
                vertical: 1,
              ),
              decoration: BoxDecoration(
                color: LuxoraColors.champagne,
                borderRadius: BorderRadius.circular(999),
                border: Border.all(
                  color: LuxoraColors.obsidian,
                  width: 1.5,
                ),
              ),
              constraints: const BoxConstraints(minWidth: 16),
              child: Text(
                unreadCount > 9 ? '9+' : '$unreadCount',
                style: const TextStyle(
                  fontSize: 9,
                  fontWeight: FontWeight.w700,
                  color: LuxoraColors.obsidian,
                  height: 1.2,
                ),
                textAlign: TextAlign.center,
              ),
            ),
          ),
      ],
    );
  }
}
