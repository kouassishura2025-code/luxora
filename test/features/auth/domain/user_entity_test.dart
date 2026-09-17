import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/features/auth/domain/entities/user_entity.dart';

void main() {
  group('UserEntity', () {
    const user = UserEntity(
      uid: 'uid_001',
      phoneNumber: '+2250700000000',
      displayName: 'Kouassi Shura',
      email: 'kouassi@luxora.app',
      kycVerified: true,
    );

    test('a les bonnes propriétés', () {
      expect(user.uid, 'uid_001');
      expect(user.phoneNumber, '+2250700000000');
      expect(user.displayName, 'Kouassi Shura');
      expect(user.kycVerified, isTrue);
    });

    test('equals compare toutes les props', () {
      const other = UserEntity(
        uid: 'uid_001',
        phoneNumber: '+2250700000000',
        displayName: 'Kouassi Shura',
        email: 'kouassi@luxora.app',
        kycVerified: true,
      );
      expect(user, equals(other));
    });

    test('copyWith met à jour les propriétés', () {
      final updated = user.copyWith(displayName: 'Autre Nom');
      expect(updated.displayName, 'Autre Nom');
      expect(updated.uid, 'uid_001'); // inchangé
      expect(updated.phoneNumber, '+2250700000000'); // inchangé
    });

    test('copyWith préserve les valeurs non spécifiées', () {
      final updated = user.copyWith(kycVerified: false);
      expect(updated.kycVerified, isFalse);
      expect(updated.displayName, 'Kouassi Shura');
    });

    test('kycVerified par défaut est false', () {
      const newUser = UserEntity(
        uid: 'uid_002',
        phoneNumber: '+2250700000001',
      );
      expect(newUser.kycVerified, isFalse);
    });
  });
}
