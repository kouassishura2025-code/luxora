import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/notifications/domain/entities/app_notification.dart';

/// Modèle Firestore pour une notification.
abstract final class NotificationModel {
  static AppNotification fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return AppNotification(
      id: id,
      category: _parseCategory(data['category'] as String?),
      title: data['title'] as String? ?? '',
      body: data['body'] as String? ?? '',
      receivedAt: _parseDate(data['receivedAt']) ?? DateTime.now(),
      isRead: data['isRead'] as bool? ?? false,
    );
  }

  static Map<String, dynamic> toFirestore(AppNotification notif) {
    return {
      'category': notif.category.name,
      'title': notif.title,
      'body': notif.body,
      'receivedAt': Timestamp.fromDate(notif.receivedAt),
      'isRead': notif.isRead,
    };
  }

  static NotificationCategory _parseCategory(String? value) {
    return NotificationCategory.values.firstWhere(
      (c) => c.name == value,
      orElse: () => NotificationCategory.system,
    );
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
