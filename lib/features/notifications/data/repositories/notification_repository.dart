import '../../domain/entities/app_notification.dart';

/// Repository de notifications (mock).
abstract class NotificationRepository {
  Future<List<AppNotification>> fetchNotifications();
  Future<void> markAsRead(String id);
  Future<void> markAllAsRead();
  Future<void> delete(String id);
}

class MockNotificationRepository implements NotificationRepository {
  final List<AppNotification> _notifications = [];

  MockNotificationRepository() {
    _seed();
  }

  void _seed() {
    final now = DateTime.now();

    _notifications.addAll([
      AppNotification(
        id: 'n1',
        category: NotificationCategory.booking,
        title: 'Votre chauffeur arrive',
        body: 'Alexandre L. est à 2 minutes de votre position.',
        receivedAt: now.subtract(const Duration(minutes: 5)),
      ),
      AppNotification(
        id: 'n2',
        category: NotificationCategory.booking,
        title: 'Réservation confirmée',
        body: 'CDG → Le Bristol · 45 €',
        receivedAt: now.subtract(const Duration(hours: 2)),
        isRead: true,
      ),
      AppNotification(
        id: 'n3',
        category: NotificationCategory.concierge,
        title: 'Message du concierge',
        body:
            'Votre table au Restaurant Le Cinq est réservée pour 20h45.',
        receivedAt: now.subtract(const Duration(hours: 18)),
        isRead: true,
      ),
      AppNotification(
        id: 'n4',
        category: NotificationCategory.membership,
        title: 'Bienvenue dans LUXORA',
        body: 'Découvrez vos avantages Silver dès maintenant.',
        receivedAt: now.subtract(const Duration(days: 3)),
        isRead: true,
      ),
      AppNotification(
        id: 'n5',
        category: NotificationCategory.safety,
        title: 'Trajet partagé avec succès',
        body: 'Marie B. suit votre position en temps réel.',
        receivedAt: now.subtract(const Duration(days: 4)),
        isRead: true,
      ),
      AppNotification(
        id: 'n6',
        category: NotificationCategory.system,
        title: 'Mise à jour de l\'application',
        body: 'De nouvelles fonctionnalités sont disponibles.',
        receivedAt: now.subtract(const Duration(days: 7)),
        isRead: true,
      ),
    ]);
  }

  @override
  Future<List<AppNotification>> fetchNotifications() async {
    await Future<void>.delayed(const Duration(milliseconds: 300));
    return List.unmodifiable(_notifications);
  }

  @override
  Future<void> markAsRead(String id) async {
    final index = _notifications.indexWhere((n) => n.id == id);
    if (index != -1) {
      _notifications[index] = _notifications[index].copyWith(isRead: true);
    }
  }

  @override
  Future<void> markAllAsRead() async {
    for (var i = 0; i < _notifications.length; i++) {
      _notifications[i] = _notifications[i].copyWith(isRead: true);
    }
  }

  @override
  Future<void> delete(String id) async {
    _notifications.removeWhere((n) => n.id == id);
  }
}
