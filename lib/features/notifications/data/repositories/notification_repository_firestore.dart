// ignore_for_file: require_trailing_commas
import '../../../../core/error/error_mapper.dart';
import '../../../../core/firebase/firestore_paths.dart';
import '../../../../core/firebase/firestore_service.dart';
import '../../../../core/firebase/models/notification_model.dart';
import '../../domain/entities/app_notification.dart';

/// Repository Firestore pour les notifications.
class NotificationRepositoryFirestore {
  NotificationRepositoryFirestore(this._firestore);

  final FirestoreService _firestore;

  /// Stream des notifications d'un utilisateur.
  Stream<List<AppNotification>> streamUserNotifications(String userId) {
    return _firestore
        .streamCollection(
          FirestorePaths.notifications,
          queryBuilder: (q) => q
              .where('userId', isEqualTo: userId)
              .orderBy('receivedAt', descending: true),
          limit: 50,
        )
        .map(
          (list) => list
              .map((data) => NotificationModel.fromFirestore(
                    data['id'] as String? ?? '',
                    data,
                  ))
              .toList(),
        );
  }

  /// Ajoute une notification.
  Future<void> addNotification({
    required String userId,
    required AppNotification notification,
  }) async {
    try {
      await _firestore.addDocument(
        FirestorePaths.notifications,
        {
          'userId': userId,
          ...NotificationModel.toFirestore(notification),
        },
      );
    } catch (e) {
      throw ErrorMapper.toFailure(e);
    }
  }

  /// Marque une notification comme lue.
  Future<void> markAsRead(String notifId) async {
    try {
      await _firestore.updateDocument(
        FirestorePaths.notification(notifId),
        {'isRead': true},
      );
    } catch (e) {
      throw ErrorMapper.toFailure(e);
    }
  }

  /// Supprime une notification.
  Future<void> delete(String notifId) async {
    try {
      await _firestore.deleteDocument(
        FirestorePaths.notification(notifId),
      );
    } catch (e) {
      throw ErrorMapper.toFailure(e);
    }
  }
}
