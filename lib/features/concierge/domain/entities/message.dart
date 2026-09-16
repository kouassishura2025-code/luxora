import 'package:equatable/equatable.dart';

/// Auteur d'un message dans la conversation.
enum MessageAuthor {
  client,
  concierge,
}

/// Un message de la conversation concierge.
class ConciergeMessage extends Equatable {
  const ConciergeMessage({
    required this.id,
    required this.author,
    required this.content,
    required this.sentAt,
    this.isRead = false,
    this.isPending = false,
  });

  final String id;
  final MessageAuthor author;
  final String content;
  final DateTime sentAt;
  final bool isRead;
  final bool isPending;

  ConciergeMessage copyWith({
    String? id,
    MessageAuthor? author,
    String? content,
    DateTime? sentAt,
    bool? isRead,
    bool? isPending,
  }) {
    return ConciergeMessage(
      id: id ?? this.id,
      author: author ?? this.author,
      content: content ?? this.content,
      sentAt: sentAt ?? this.sentAt,
      isRead: isRead ?? this.isRead,
      isPending: isPending ?? this.isPending,
    );
  }

  @override
  List<Object?> get props =>
      [id, author, content, sentAt, isRead, isPending];
}
