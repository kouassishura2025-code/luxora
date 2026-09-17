// ignore_for_file: require_trailing_commas
import 'dart:async';

import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/features/concierge/data/repositories/mock_concierge_repository.dart';
import 'package:luxora/features/concierge/domain/entities/message.dart';

void main() {
  late MockConciergeRepository repository;

  setUp(() {
    repository = MockConciergeRepository();
  });

  tearDown(() => repository.dispose());

  group('MockConciergeRepository — initialize', () {
    test('initialize ne throw pas', () async {
      await expectLater(repository.initialize(), completes);
    });
  });

  group('sendMessage', () {
    test('accepte un message valide', () async {
      await repository.initialize();
      await expectLater(
        repository.sendMessage('Bonjour'),
        completes,
      );
    });

    test('ne throw pas pour un message vide', () async {
      await repository.initialize();
      await expectLater(
        repository.sendMessage('   '),
        completes,
      );
    });

    test('déclenche le typing (true puis false)', () async {
      await repository.initialize();

      final events = <bool>[];
      final subscription = repository.typingStream().listen(events.add);

      // Ne PAS await : sendMessage dure 2.8s au total
      unawaited(repository.sendMessage('Test'));

      // Attendre assez longtemps pour capter tous les events
      await Future<void>.delayed(const Duration(seconds: 4));

      await subscription.cancel();

      expect(
        events.contains(true),
        isTrue,
        reason: 'Le typing doit passer à true',
      );
      expect(
        events.contains(false),
        isTrue,
        reason: 'Le typing doit passer à false',
      );
    }, timeout: const Timeout(Duration(seconds: 10)));
  });

  group('messageStream', () {
    test('émet les messages après initialize', () async {
      final completer = Completer<List<ConciergeMessage>>();
      final sub = repository.messageStream().listen(completer.complete);

      await repository.initialize();

      final messages = await completer.future;
      expect(messages, isNotEmpty);
      expect(messages.first.author, MessageAuthor.concierge);

      await sub.cancel();
    });

    test('émet un nouveau message après sendMessage', () async {
      await repository.initialize();

      final messages = <List<ConciergeMessage>>[];
      final sub = repository.messageStream().listen(messages.add);

      // Ne PAS await
      unawaited(repository.sendMessage('Hello'));

      // Attendre la fin de la séquence
      await Future<void>.delayed(const Duration(seconds: 4));

      await sub.cancel();

      final hasClientMessage = messages.any(
        (list) => list.any((m) => m.author == MessageAuthor.client),
      );
      expect(hasClientMessage, isTrue);
    }, timeout: const Timeout(Duration(seconds: 10)));
  });
}
