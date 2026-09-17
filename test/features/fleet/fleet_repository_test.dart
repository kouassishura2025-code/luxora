import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/features/fleet/data/repositories/fleet_repository.dart';

void main() {
  late FleetRepository repository;

  setUp(() {
    repository = MockFleetRepository();
  });

  group('getVehicles', () {
    test('retourne 4 véhicules', () {
      expect(repository.getVehicles().length, 4);
    });

    test('contient berline, suv, van, limousine', () {
      final ids = repository.getVehicles().map((v) => v.id).toList();
      expect(ids, containsAll(['berline', 'suv', 'van', 'limousine']));
    });

    test('chaque véhicule a des amenities', () {
      for (final v in repository.getVehicles()) {
        expect(v.amenities, isNotEmpty);
      }
    });

    test('chaque véhicule a 2 couleurs de gradient', () {
      for (final v in repository.getVehicles()) {
        expect(v.gradientColors.length, 2);
      }
    });

    test('limousine a le prix le plus élevé', () {
      final vehicles = repository.getVehicles();
      final limousine = vehicles.firstWhere((v) => v.id == 'limousine');
      final others = vehicles.where((v) => v.id != 'limousine');
      for (final other in others) {
        expect(limousine.basePrice, greaterThan(other.basePrice));
      }
    });

    test('van a la plus grande capacité', () {
      final vehicles = repository.getVehicles();
      final van = vehicles.firstWhere((v) => v.id == 'van');
      expect(van.capacity, 7);
    });
  });

  group('getVehicleById', () {
    test('retourne le bon véhicule', () {
      final vehicle = repository.getVehicleById('suv');
      expect(vehicle, isNotNull);
      expect(vehicle!.name, 'SUV');
      expect(vehicle.model, 'Range Rover Velar');
    });

    test('retourne null pour un id inconnu', () {
      expect(repository.getVehicleById('invalid'), isNull);
    });

    test('berline a 3 places', () {
      final berline = repository.getVehicleById('berline');
      expect(berline!.capacity, 3);
    });
  });
}
