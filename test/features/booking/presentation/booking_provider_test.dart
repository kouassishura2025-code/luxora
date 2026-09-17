import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/features/booking/presentation/providers/booking_provider.dart';

void main() {
  late ProviderContainer container;

  setUp(() {
    container = ProviderContainer();
  });

  tearDown(() => container.dispose());

  group('BookingProvider — état initial', () {
    test('pickup par défaut', () {
      final state = container.read(bookingProvider);
      expect(state.pickup, 'Position actuelle');
    });

    test('destination est null', () {
      expect(container.read(bookingProvider).destination, isNull);
    });

    test('aucun véhicule sélectionné', () {
      expect(container.read(bookingProvider).selectedVehicleId, isNull);
    });

    test('aucune préférence', () {
      expect(container.read(bookingProvider).selectedPreferences, isEmpty);
    });
  });

  group('setPickup', () {
    test('met à jour le pickup', () {
      container.read(bookingProvider.notifier).setPickup('12 rue de Rivoli');
      expect(container.read(bookingProvider).pickup, '12 rue de Rivoli');
    });
  });

  group('setDestination', () {
    test('met à jour la destination', () {
      container
          .read(bookingProvider.notifier)
          .setDestination('Tour Eiffel');
      expect(container.read(bookingProvider).destination, 'Tour Eiffel');
    });
  });

  group('selectVehicle', () {
    test('met à jour le véhicule sélectionné', () {
      container.read(bookingProvider.notifier).selectVehicle('suv');
      expect(container.read(bookingProvider).selectedVehicleId, 'suv');
    });

    test('remplace le véhicule précédent', () {
      final notifier = container.read(bookingProvider.notifier);
      notifier.selectVehicle('suv');
      notifier.selectVehicle('berline');
      expect(container.read(bookingProvider).selectedVehicleId, 'berline');
    });
  });

  group('togglePreference', () {
    test('ajoute une préférence', () {
      container.read(bookingProvider.notifier).togglePreference('silence');
      expect(
        container.read(bookingProvider).selectedPreferences,
        contains('silence'),
      );
    });

    test('retire une préférence existante', () {
      final notifier = container.read(bookingProvider.notifier);
      notifier.togglePreference('silence');
      notifier.togglePreference('silence');
      expect(
        container.read(bookingProvider).selectedPreferences,
        isNot(contains('silence')),
      );
    });

    test('plusieurs préférences', () {
      final notifier = container.read(bookingProvider.notifier);
      notifier.togglePreference('silence');
      notifier.togglePreference('music');
      notifier.togglePreference('ac');
      expect(container.read(bookingProvider).selectedPreferences.length, 3);
    });
  });

  group('reset', () {
    test('remet tout à zéro', () {
      final notifier = container.read(bookingProvider.notifier);
      notifier.setPickup('Test');
      notifier.setDestination('Test');
      notifier.selectVehicle('suv');
      notifier.togglePreference('silence');

      notifier.reset();

      final state = container.read(bookingProvider);
      expect(state.pickup, 'Position actuelle');
      expect(state.destination, isNull);
      expect(state.selectedVehicleId, isNull);
      expect(state.selectedPreferences, isEmpty);
    });
  });

  group('vehicleClassesProvider', () {
    test('retourne 4 classes', () {
      final vehicles = container.read(vehicleClassesProvider);
      expect(vehicles.length, 4);
    });

    test('contient berline, suv, van, limousine', () {
      final vehicles = container.read(vehicleClassesProvider);
      final ids = vehicles.map((v) => v.id).toList();
      expect(ids, containsAll(['berline', 'suv', 'van', 'limousine']));
    });

    test('chaque véhicule a un prix > 0', () {
      final vehicles = container.read(vehicleClassesProvider);
      for (final v in vehicles) {
        expect(v.basePrice, greaterThan(0));
        expect(v.pricePerKm, greaterThan(0));
      }
    });
  });

  group('chauffeurPreferencesProvider', () {
    test('retourne 8 préférences', () {
      final prefs = container.read(chauffeurPreferencesProvider);
      expect(prefs.length, 8);
    });

    test('contient silence, music, conversation', () {
      final prefs = container.read(chauffeurPreferencesProvider);
      final ids = prefs.map((p) => p.id).toList();
      expect(ids, containsAll(['silence', 'music', 'conversation']));
    });
  });
}
