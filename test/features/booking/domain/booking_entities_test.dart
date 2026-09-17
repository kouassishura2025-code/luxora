import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/features/booking/domain/entities/booking_entities.dart';
import 'package:flutter/material.dart';

void main() {
  group('VehicleClass', () {
    const vehicle = VehicleClass(
      id: 'berline',
      name: 'Berline',
      tagline: 'L\'essentiel',
      description: 'Test',
      basePrice: 25,
      pricePerKm: 2.2,
      eta: 4,
      capacity: 3,
      icon: Icons.directions_car,
      accent: Color(0xFF000000),
    );

    test('est immutable et equatable', () {
      const other = VehicleClass(
        id: 'berline',
        name: 'Berline',
        tagline: 'L\'essentiel',
        description: 'Test',
        basePrice: 25,
        pricePerKm: 2.2,
        eta: 4,
        capacity: 3,
        icon: Icons.directions_car,
        accent: Color(0xFF000000),
      );
      expect(vehicle, equals(other));
    });

    test('a les bonnes propriétés', () {
      expect(vehicle.name, 'Berline');
      expect(vehicle.basePrice, 25);
      expect(vehicle.capacity, 3);
      expect(vehicle.eta, 4);
    });
  });

  group('ChauffeurPreference', () {
    const pref = ChauffeurPreference(
      id: 'silence',
      label: 'Silence',
      icon: Icons.volume_off,
    );

    test('a les bonnes propriétés', () {
      expect(pref.id, 'silence');
      expect(pref.label, 'Silence');
    });
  });

  group('BookingRequest', () {
    final request = BookingRequest(
      destination: 'Tour Eiffel',
      pickup: '12 rue de Rivoli',
      vehicle: const VehicleClass(
        id: 'suv',
        name: 'SUV',
        tagline: 'Test',
        description: 'Test',
        basePrice: 38,
        pricePerKm: 3.1,
        eta: 6,
        capacity: 4,
        icon: Icons.directions_car,
        accent: Color(0xFF000000),
      ),
      preferences: const ['silence', 'ac'],
      scheduledAt: null,
      estimatedPrice: 65,
      estimatedDuration: const Duration(minutes: 25),
    );

    test('copyWith fonctionne', () {
      final updated = request.copyWith(destination: 'CDG');
      expect(updated.destination, 'CDG');
      expect(updated.pickup, '12 rue de Rivoli'); // inchangé
      expect(updated.preferences, ['silence', 'ac']); // inchangé
    });

    test('copyWith préserve le véhicule si non spécifié', () {
      final updated = request.copyWith(destination: 'CDG');
      expect(updated.vehicle.id, 'suv');
    });
  });
}
