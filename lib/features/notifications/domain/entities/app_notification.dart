import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Catégorie de notification.
enum NotificationCategory {
  booking('Réservations', Icons.directions_car_filled_outlined),
  concierge('Concierge', Icons.support_agent_outlined),
  membership('Membership', Icons.workspace_premium_outlined),
  safety('Sécurité', Icons.shield_outlined),
  system('Système', Icons.info_outline_rounded);

  const NotificationCategory(this.label, this.icon);
  final String label;
  final IconData icon;
}

/// Une notification in-app.
class AppNotification extends Equatable {
  const AppNotification({
    required this.id,
    required this.category,
    required this.title,
    required this.body,
    required this.receivedAt,
    this.isRead = false,
  });

  final String id;
  final NotificationCategory category;
  final String title;
  final String body;
  final DateTime receivedAt;
  final bool isRead;

  AppNotification copyWith({
    String? id,
    NotificationCategory? category,
    String? title,
    String? body,
    DateTime? receivedAt,
    bool? isRead,
  }) {
    return AppNotification(
      id: id ?? this.id,
      category: category ?? this.category,
      title: title ?? this.title,
      body: body ?? this.body,
      receivedAt: receivedAt ?? this.receivedAt,
      isRead: isRead ?? this.isRead,
    );
  }

  @override
  List<Object?> get props => [id, isRead, category];
}
