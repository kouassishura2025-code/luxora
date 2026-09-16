import 'dart:async';

import '../../domain/entities/message.dart';
import '../../domain/repositories/concierge_repository.dart';

/// Mock du concierge LUXORA — 100 % local.
///
/// Simule des réponses contextuelles du concierge et un typing indicator.
class MockConciergeRepository implements ConciergeRepository {
  MockConciergeRepository();

  final _messagesController =
      StreamController<List<ConciergeMessage>>.broadcast();
  final _typingController = StreamController<bool>.broadcast();

  final List<ConciergeMessage> _messages = [];
  int _counter = 0;

  @override
  Stream<List<ConciergeMessage>> messageStream() =>
      _messagesController.stream;

  @override
  Stream<bool> typingStream() => _typingController.stream;

  @override
  Future<void> initialize() async {
    // Message d'accueil du concierge.
    _messages.add(
      ConciergeMessage(
        id: _newId(),
        author: MessageAuthor.concierge,
        content:
            'Bonsoir M. Kouassi.\n'
            'Comment puis-je vous être utile ce soir ?',
        sentAt: DateTime.now().subtract(const Duration(minutes: 2)),
        isRead: true,
      ),
    );
    _emit();
  }

  @override
  Future<void> sendMessage(String content) async {
    // 1. Ajouter le message client.
    _messages.add(
      ConciergeMessage(
        id: _newId(),
        author: MessageAuthor.client,
        content: content,
        sentAt: DateTime.now(),
        isPending: false,
      ),
    );
    _emit();

    // 2. Simuler la frappe du concierge (1s plus tard).
    await Future<void>.delayed(const Duration(milliseconds: 800));
    _typingController.add(true);

    // 3. Réponse contextuelle (2-3s plus tard).
    final response = _generateResponse(content);
    await Future<void>.delayed(const Duration(seconds: 2));
    _typingController.add(false);

    // 4. Ajouter la réponse concierge.
    _messages.add(
      ConciergeMessage(
        id: _newId(),
        author: MessageAuthor.concierge,
        content: response,
        sentAt: DateTime.now(),
      ),
    );
    _emit();
  }

  void _emit() {
    _messagesController.add(List.unmodifiable(_messages));
  }

  String _newId() => 'msg_${DateTime.now().millisecondsSinceEpoch}_${_counter++}';

  /// Réponse contextuelle simulée.
  String _generateResponse(String input) {
    final lower = input.toLowerCase();

    if (lower.contains('restaurant') || lower.contains('table')) {
      return 'Très bien. Pour combien de personnes '
          'et à quelle heure souhaitez-vous dîner ?';
    }
    if (lower.contains('fleur') || lower.contains('bouquet')) {
      return 'Excellent choix. Souhaitez-vous un bouquet '
          'livré à une adresse précise ? Je m\'en occupe.';
    }
    if (lower.contains('spectacle') ||
        lower.contains('concert') ||
        lower.contains('théâtre')) {
      return 'Je vérifie les disponibilités. '
          'Avez-vous une préférence de date ou de genre ?';
    }
    if (lower.contains('voiture') || lower.contains('chauffeur')) {
      return 'Je peux réserver un chauffeur immédiatement. '
          'Souhaitez-vous une classe spécifique ?';
    }
    if (lower.contains('hôtel') || lower.contains('suite')) {
      return 'Je consulte les suites disponibles. '
          'Quelle ville et quelles dates vous conviendraient ?';
    }
    if (lower.contains('merci')) {
      return 'C\'est un plaisir. N\'hésitez pas si vous avez '
          'la moindre demande.';
    }
    if (lower.contains('bonjour') || lower.contains('bonsoir')) {
      return 'Bonsoir. Que puis-je faire pour vous ce soir ?';
    }

    // Réponse générique élégante.
    return 'Je prends note. Un instant, je vérifie la disponibilité '
        'et je reviens vers vous dans quelques minutes.';
  }

  void dispose() {
    _messagesController.close();
    _typingController.close();
  }
}
