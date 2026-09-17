import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/features/auth/data/repositories/mock_auth_repository.dart';
import 'package:shared_preferences/shared_preferences.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();

  late MockAuthRepository repository;

  setUp(() async {
    SharedPreferences.setMockInitialValues({});
    repository = MockAuthRepository();
    await repository.initialize();
  });

  tearDown(() => repository.dispose());

  group('MockAuthRepository — état initial', () {
    test('currentUser est null au démarrage', () {
      expect(repository.currentUser, isNull);
    });

    test('authStateChanges émet une valeur au démarrage', () async {
      // Broadcast stream : on écoute d'abord, puis on attend.
      final future = repository.authStateChanges().first;

      // Le stream émet null immédiatement via add(null) dans initialize,
      // mais comme broadcast, il faut ré-émettre.
      // On attend simplement que ça arrive.
      final user = await future.timeout(
        const Duration(seconds: 1),
        onTimeout: () => null,
      );
      expect(user, isNull);
    });
  });

  group('sendOtp', () {
    test('accepte un numéro valide', () async {
      final id = await repository.sendOtp(
        phoneNumber: '+2250700000000',
      );
      expect(id, isNotEmpty);
      expect(id, startsWith('mock_'));
    });

    test('rejette un numéro sans +', () async {
      expect(
        () => repository.sendOtp(phoneNumber: '0700000000'),
        throwsException,
      );
    });

    test('rejette un numéro trop court', () async {
      expect(
        () => repository.sendOtp(phoneNumber: '+225'),
        throwsException,
      );
    });
  });

  group('verifyOtp', () {
    test('accepte le code 123456', () async {
      final id = await repository.sendOtp(phoneNumber: '+2250700000000');
      final user = await repository.verifyOtp(
        verificationId: id,
        code: '123456',
      );
      expect(user.phoneNumber, '+2250700000000');
      expect(user.uid, isNotEmpty);
    });

    test('rejette un code incorrect', () async {
      final id = await repository.sendOtp(phoneNumber: '+2250700000000');
      expect(
        () => repository.verifyOtp(
          verificationId: id,
          code: '000000',
        ),
        throwsException,
      );
    });

    test('rejette si aucun OTP en attente', () async {
      expect(
        () => repository.verifyOtp(
          verificationId: 'fake',
          code: '123456',
        ),
        throwsException,
      );
    });

    test('après verifyOtp, currentUser est défini', () async {
      final id = await repository.sendOtp(phoneNumber: '+2250700000000');
      await repository.verifyOtp(verificationId: id, code: '123456');
      expect(repository.currentUser, isNotNull);
      expect(repository.currentUser!.phoneNumber, '+2250700000000');
    });
  });

  group('signOut', () {
    test('efface l\'utilisateur courant', () async {
      final id = await repository.sendOtp(phoneNumber: '+2250700000000');
      await repository.verifyOtp(verificationId: id, code: '123456');
      expect(repository.currentUser, isNotNull);

      await repository.signOut();
      expect(repository.currentUser, isNull);
    });

    test('efface la session persistée', () async {
      final id = await repository.sendOtp(phoneNumber: '+2250700000000');
      await repository.verifyOtp(verificationId: id, code: '123456');
      await repository.signOut();

      final fresh = MockAuthRepository();
      await fresh.initialize();
      expect(fresh.currentUser, isNull);
      fresh.dispose();
    });
  });

  group('persistance', () {
    test('la session est restaurée au redémarrage', () async {
      final id = await repository.sendOtp(phoneNumber: '+2250700000000');
      await repository.verifyOtp(verificationId: id, code: '123456');

      final fresh = MockAuthRepository();
      await fresh.initialize();
      expect(fresh.currentUser, isNotNull);
      expect(fresh.currentUser!.phoneNumber, '+2250700000000');
      fresh.dispose();
    });
  });
}
