import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/components/animations/luxora_list_animation.dart';
import '../../../../design_system/components/buttons/luxora_text_button.dart';
import '../../../../design_system/components/feedback/luxora_empty_state.dart';
import '../../../../design_system/components/feedback/luxora_skeleton.dart';
import '../../../../design_system/components/navigation/luxora_app_bar.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_spacing.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';
import '../providers/notification_provider.dart';
import '../widgets/notification_filter_bar.dart';
import '../widgets/notification_tile.dart';

class NotificationsPage extends ConsumerWidget {
  const NotificationsPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final l10n = AppLocalizations.of(context);
    final filter = ref.watch(notificationFilterProvider);
    final filtered = ref.watch(filteredNotificationsProvider);
    final unreadCount = ref.watch(unreadCountProvider);
    final async = ref.watch(notificationsProvider);
    final actions = ref.watch(notificationActionsProvider);

    return LuxoraScaffold(
      applyPadding: false,
      appBar: LuxoraAppBar(
        overline: l10n.notificationsOverline,
        title: l10n.notificationsTitle,
        actions: [
          if (unreadCount > 0)
            LuxoraTextButton(
              label: l10n.notificationsMarkAllRead,
              onPressed: () => actions.markAllAsRead(),
            ),
          const SizedBox(width: 8),
        ],
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: NotificationFilterBar(
              current: filter,
              onChanged: (f) {
                ref.read(notificationFilterProvider.notifier).state = f;
              },
            ),
          ),
          const SizedBox(height: 8),
          Expanded(
            child: async.when(
              loading: () => const LuxoraSkeletonList(count: 5),
              error: (_, __) => LuxoraEmptyState(
                icon: Icons.notifications_none_rounded,
                title: l10n.commonError,
                message: l10n.commonRetry,
              ),
              data: (_) {
                if (filtered.isEmpty) {
                  return LuxoraEmptyState(
                    icon: Icons.notifications_none_rounded,
                    title: l10n.notificationsEmpty,
                    message: l10n.notificationsEmptyMessage,
                  );
                }
                return _AnimatedGroupedList(
                  items: filtered,
                  onTap: (id) => actions.markAsRead(id),
                  onDelete: (id) => actions.delete(id),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _AnimatedGroupedList extends StatelessWidget {
  const _AnimatedGroupedList({
    required this.items,
    required this.onTap,
    required this.onDelete,
  });

  final List<dynamic> items;
  final void Function(String) onTap;
  final void Function(String) onDelete;

  @override
  Widget build(BuildContext context) {
    final groups = groupNotifications(items.cast());
    var globalIndex = 0;

    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
      itemCount: groups.length,
      itemBuilder: (context, groupIndex) {
        final group = groups[groupIndex];
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: EdgeInsets.only(
                top: groupIndex == 0 ? 0 : 20,
                bottom: 12,
              ),
              child: Text(
                group.label.toUpperCase(),
                style: LuxoraTextStyles.overline.copyWith(
                  fontSize: 10,
                  color: LuxoraColors.textSecondary,
                ),
              ),
            ),
            for (final n in group.items) ...[
              LuxoraListAnimation(
                index: globalIndex++,
                delayPerItem: const Duration(milliseconds: 40),
                child: NotificationTile(
                  notification: n,
                  onTap: () => onTap(n.id),
                ),
              ),
              const SizedBox(height: 10),
            ],
            if (groupIndex == groups.length - 1)
              const SizedBox(height: LuxoraSpacing.xxxl),
          ],
        );
      },
    );
  }
}
