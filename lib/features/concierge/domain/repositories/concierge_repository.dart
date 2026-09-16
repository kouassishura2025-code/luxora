import '../entities/message.dart';

/// Contrat du repository concierge.
abstract class ConciergeRepository {
  /// Stream des messages de la conversation.
  Stream<List<ConciergeMessage>> messageStream();

  /// Stream de l'état "concierge en train d'écrire".
  Stream<bool> typingStream();

  /// Envoie un message et déclenche une réponse simulée.
  Future<void> sendMessage(String content);

  /// Charge les messages initiaux.
  Future<void> initialize();
}
