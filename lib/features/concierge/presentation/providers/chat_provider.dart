import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_concierge_repository.dart';
import '../../domain/entities/message.dart';
import '../../domain/repositories/concierge_repository.dart';

// ─── Repository ──────────────────────────────────────────
final conciergeRepositoryProvider = Provider<ConciergeRepository>((ref) {
  final repo = MockConciergeRepository();
  repo.initialize();
  ref.onDispose(repo.dispose);
  return repo;
});

// ─── Messages (stream) ───────────────────────────────────
final messagesProvider = StreamProvider<List<ConciergeMessage>>((ref) {
  return ref.watch(conciergeRepositoryProvider).messageStream();
});

// ─── Typing indicator (stream) ───────────────────────────
final conciergeTypingProvider = StreamProvider<bool>((ref) {
  return ref.watch(conciergeRepositoryProvider).typingStream();
});

// ─── Notifier d'envoi ────────────────────────────────────
final sendMessageProvider = Provider<Future<void> Function(String)>((ref) {
  return (content) async {
    if (content.trim().isEmpty) return;
    await ref.read(conciergeRepositoryProvider).sendMessage(content.trim());
  };
});
