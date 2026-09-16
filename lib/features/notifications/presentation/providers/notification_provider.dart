import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/notification_repository.dart';
import '../../domain/entities/app_notification.dart';

/// Filtre actif dans le centre de notifications.
enum NotificationFilter {
  all('Tout'),
  unread('Non lues'),
  booking('Réservations'),
  concierge('Concierge'),
  membership('Membership'),
  safety('Sécurité');

  const NotificationFilter(this.label);
  final String label;
}

final notificationRepositoryProvider =
    Provider<NotificationRepository>((ref) {
  return MockNotificationRepository();
});

final notificationsProvider =
    FutureProvider<List<AppNotification>>((ref) async {
  return ref.watch(notificationRepositoryProvider).fetchNotifications();
});

/// Filtre courant.
final notificationFilterProvider =
    StateProvider<NotificationFilter>((ref) => NotificationFilter.all);

/// Nombre de non-lues (pour le badge).
final unreadCountProvider = Provider<int>((ref) {
  final async = ref.watch(notificationsProvider);
  return async.maybeWhen(
    data: (list) => list.where((n) => !n.isRead).length,
    orElse: () => 0,
  );
});

/// Notifications filtrées.
final filteredNotificationsProvider =
    Provider<List<AppNotification>>((ref) {
  final async = ref.watch(notificationsProvider);
  final filter = ref.watch(notificationFilterProvider);

  return async.maybeWhen(
    data: (list) {
      switch (filter) {
        case NotificationFilter.all:
          return list;
        case NotificationFilter.unread:
          return list.where((n) => !n.isRead).toList();
        case NotificationFilter.booking:
          return list
              .where((n) => n.category == NotificationCategory.booking)
              .toList();
        case NotificationFilter.concierge:
          return list
              .where((n) => n.category == NotificationCategory.concierge)
              .toList();
        case NotificationFilter.membership:
          return list
              .where((n) => n.category == NotificationCategory.membership)
              .toList();
        case NotificationFilter.safety:
          return list
              .where((n) => n.category == NotificationCategory.safety)
              .toList();
      }
    },
    orElse: () => [],
  );
});

/// Actions.
final notificationActionsProvider = Provider<NotificationActions>((ref) {
  return NotificationActions(ref);
});

class NotificationActions {
  NotificationActions(this._ref);

  final Ref _ref;

  Future<void> markAsRead(String id) async {
    await _ref.read(notificationRepositoryProvider).markAsRead(id);
    _ref.invalidate(notificationsProvider);
  }

  Future<void> markAllAsRead() async {
    await _ref.read(notificationRepositoryProvider).markAllAsRead();
    _ref.invalidate(notificationsProvider);
  }

  Future<void> delete(String id) async {
    await _ref.read(notificationRepositoryProvider).delete(id);
    _ref.invalidate(notificationsProvider);
  }
}

/// Helper pour grouper par jour.
@immutable
class NotificationGroup {
  const NotificationGroup({required this.label, required this.items});

  final String label;
  final List<AppNotification> items;
}

List<NotificationGroup> groupNotifications(List<AppNotification> items) {
  final now = DateTime.now();
  final today = DateTime(now.year, now.month, now.day);
  final yesterday = today.subtract(const Duration(days: 1));
  final weekStart = today.subtract(const Duration(days: 7));

  final groups = <String, List<AppNotification>>{};

  for (final n in items) {
    final d = DateTime(
      n.receivedAt.year,
      n.receivedAt.month,
      n.receivedAt.day,
    );
    String key;
    if (d == today) {
      key = 'Aujourd\'hui';
    } else if (d == yesterday) {
      key = 'Hier';
    } else if (d.isAfter(weekStart)) {
      key = 'Cette semaine';
    } else {
      key = 'Plus ancien';
    }
    groups.putIfAbsent(key, () => []).add(n);
  }

  const order = ['Aujourd\'hui', 'Hier', 'Cette semaine', 'Plus ancien'];
  return [
    for (final key in order)
      if (groups.containsKey(key))
        NotificationGroup(label: key, items: groups[key]!),
  ];
}
