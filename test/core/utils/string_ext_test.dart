import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/core/utils/extensions/string_ext.dart';

void main() {
  group('StringX.isBlank', () {
    test('vide → true', () => expect(''.isBlank, isTrue));
    test('espaces → true', () => expect('   '.isBlank, isTrue));
    test('texte → false', () => expect('hello'.isBlank, isFalse));
  });

  group('StringX.isEmail', () {
    test('valide', () => expect('test@luxora.app'.isEmail, isTrue));
    test('invalide', () => expect('test'.isEmail, isFalse));
    test('vide', () => expect(''.isEmail, isFalse));
  });

  group('StringX.isPhone', () {
    test('+2250700000000 → true', () {
      expect('+2250700000000'.isPhone, isTrue);
    });
    test('0700000000 → false (pas de +)', () {
      expect('0700000000'.isPhone, isFalse);
    });
    test('+225 → false (trop court)', () {
      expect('+225'.isPhone, isFalse);
    });
  });

  group('StringX.capitalize', () {
    test('kouassi → Kouassi', () {
      expect('kouassi'.capitalize, 'Kouassi');
    });
    test('vide → vide', () => expect(''.capitalize, ''));
  });

  group('StringX.initials', () {
    test('Kouassi Shura → KS', () {
      expect('Kouassi Shura'.initials, 'KS');
    });
    test('Kouassi → K', () {
      expect('Kouassi'.initials, 'K');
    });
    test('Marie Claire Dubois → MD', () {
      expect('Marie Claire Dubois'.initials, 'MD');
    });
    test('vide → vide', () => expect(''.initials, ''));
  });

  group('StringX.truncate', () {
    test('court → inchangé', () {
      expect('Hello'.truncate(10), 'Hello');
    });
    test('long → tronqué avec …', () {
      expect('Bonjour le monde'.truncate(10), 'Bonjour l…');
    });
  });
}
