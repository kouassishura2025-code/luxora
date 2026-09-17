import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/core/utils/extensions/datetime_ext.dart';

void main() {
  group('DateTimeX.isToday', () {
    test('maintenant → true', () {
      expect(DateTime.now().isToday, isTrue);
    });

    test('hier → false', () {
      expect(
        DateTime.now().subtract(const Duration(days: 1)).isToday,
        isFalse,
      );
    });
  });

  group('DateTimeX.isYesterday', () {
    test('hier → true', () {
      expect(
        DateTime.now().subtract(const Duration(days: 1)).isYesterday,
        isTrue,
      );
    });

    test('aujourd\'hui → false', () {
      expect(DateTime.now().isYesterday, isFalse);
    });
  });

  group('DateTimeX.isThisWeek', () {
    test('il y a 3 jours → true', () {
      expect(
        DateTime.now().subtract(const Duration(days: 3)).isThisWeek,
        isTrue,
      );
    });

    test('il y a 10 jours → false', () {
      expect(
        DateTime.now().subtract(const Duration(days: 10)).isThisWeek,
        isFalse,
      );
    });
  });

  group('DateTimeX.timeShort', () {
    test('08:05 → 08h05', () {
      expect(DateTime(2026, 9, 15, 8, 5).timeShort, '08h05');
    });

    test('20:45 → 20h45', () {
      expect(DateTime(2026, 9, 15, 20, 45).timeShort, '20h45');
    });
  });

  group('DateTimeX.dateShort', () {
    test('14 sept 2026 → "14 sept. 2026"', () {
      expect(DateTime(2026, 9, 14).dateShort, '14 sept. 2026');
    });

    test('1 janv 2026 → "1 janv. 2026"', () {
      expect(DateTime(2026, 1, 1).dateShort, '1 janv. 2026');
    });
  });

  group('DateTimeX.relative', () {
    test('il y a 5 min → "Il y a 5 min"', () {
      expect(
        DateTime.now().subtract(const Duration(minutes: 5)).relative,
        'Il y a 5 min',
      );
    });

    test('à l\'instant', () {
      expect(DateTime.now().relative, 'À l\'instant');
    });

    test('il y a 2h → "Il y a 2 h"', () {
      expect(
        DateTime.now().subtract(const Duration(hours: 2)).relative,
        'Il y a 2 h',
      );
    });
  });
}
