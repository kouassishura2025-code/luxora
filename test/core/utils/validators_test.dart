import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/core/utils/validators.dart';

void main() {
  group('Validators.phone', () {
    test('null → "Numéro requis"', () {
      expect(Validators.phone(null), 'Numéro requis');
    });

    test('vide → "Numéro requis"', () {
      expect(Validators.phone(''), 'Numéro requis');
    });

    test('sans + → "Format international requis"', () {
      expect(Validators.phone('2250700000000'), contains('international'));
    });

    test('trop court → "Numéro trop court"', () {
      expect(Validators.phone('+225'), 'Numéro trop court');
    });

    test('valide +225 → null', () {
      expect(Validators.phone('+2250700000000'), isNull);
    });

    test('valide +33 → null', () {
      expect(Validators.phone('+33612345678'), isNull);
    });
  });

  group('Validators.email', () {
    test('null → "Email requis"', () {
      expect(Validators.email(null), 'Email requis');
    });

    test('vide → "Email requis"', () {
      expect(Validators.email(''), 'Email requis');
    });

    test('sans @ → "Email invalide"', () {
      expect(Validators.email('test'), 'Email invalide');
    });

    test('sans domaine → "Email invalide"', () {
      expect(Validators.email('test@'), 'Email invalide');
    });

    test('valide → null', () {
      expect(Validators.email('kouassi@luxora.app'), isNull);
    });

    test('avec sous-domaine → null', () {
      expect(Validators.email('test@mail.luxora.app'), isNull);
    });

    test('optionalEmail vide → null', () {
      expect(Validators.optionalEmail(''), isNull);
    });
  });

  group('Validators.password', () {
    test('vide → requis', () {
      expect(Validators.password(''), 'Mot de passe requis');
    });

    test('trop court → "Au moins 8 caractères"', () {
      expect(Validators.password('Abc1'), 'Au moins 8 caractères');
    });

    test('sans majuscule → "Au moins 1 majuscule"', () {
      expect(Validators.password('abcd1234'), 'Au moins 1 majuscule');
    });

    test('sans chiffre → "Au moins 1 chiffre"', () {
      expect(Validators.password('Abcdefgh'), 'Au moins 1 chiffre');
    });

    test('valide → null', () {
      expect(Validators.password('Abcdef12'), isNull);
    });
  });

  group('Validators.otp', () {
    test('vide → requis', () {
      expect(Validators.otp(''), 'Code requis');
    });

    test('trop court → "Code à 6 chiffres"', () {
      expect(Validators.otp('123'), 'Code à 6 chiffres');
    });

    test('non numérique → "Chiffres uniquement"', () {
      expect(Validators.otp('abcdef'), 'Chiffres uniquement');
    });

    test('valide → null', () {
      expect(Validators.otp('123456'), isNull);
    });

    test('longueur custom 4 → null', () {
      expect(Validators.otp('1234', length: 4), isNull);
    });
  });

  group('Validators.name', () {
    test('vide → requis', () {
      expect(Validators.name(''), 'Nom requis');
    });

    test('1 caractère → "Trop court"', () {
      expect(Validators.name('A'), 'Trop court');
    });

    test('valide → null', () {
      expect(Validators.name('Kouassi'), isNull);
    });

    test('optionalName vide → null', () {
      expect(Validators.optionalName(''), isNull);
    });
  });

  group('Validators.address', () {
    test('vide → requis', () {
      expect(Validators.address(''), 'Adresse requise');
    });

    test('2 caractères → "trop courte"', () {
      expect(Validators.address('AB'), 'Adresse trop courte');
    });

    test('valide → null', () {
      expect(Validators.address('12 rue de Rivoli'), isNull);
    });
  });
}
