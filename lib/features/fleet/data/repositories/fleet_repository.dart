import 'package:flutter/material.dart';

import '../../domain/entities/fleet_vehicle.dart';

/// Repository flotte LUXORA (mock).
abstract class FleetRepository {
  List<FleetVehicle> getVehicles();
  FleetVehicle? getVehicleById(String id);
}

class MockFleetRepository implements FleetRepository {
  static const _vehicles = <FleetVehicle>[
    FleetVehicle(
      id: 'berline',
      name: 'Berline',
      model: 'Mercedes Classe E',
      tagline: 'L\'essentiel, sublimé.',
      description:
          'Une berline d\'exception pour vos trajets urbains. '
          'Silence de fonctionnement, confort absolu, chauffeur en costume.',
      basePrice: 25,
      pricePerKm: 2.2,
      capacity: 3,
      luggage: 2,
      eta: 4,
      icon: Icons.directions_car_filled_outlined,
      gradientColors: [Color(0xFF1F1F23), Color(0xFF2A3A4A)],
      amenities: [
        'Climatisation',
        'Wi-Fi',
        'Eau fraîche',
        'Presse',
        'Chargeur',
      ],
    ),
    FleetVehicle(
      id: 'suv',
      name: 'SUV',
      model: 'Range Rover Velar',
      tagline: 'L\'espace, sans compromis.',
      description:
          'Le SUV signature de LUXORA. Position de conduite surélevée, '
          'intérieur cuir, présence remarquable sur la route.',
      basePrice: 38,
      pricePerKm: 3.1,
      capacity: 4,
      luggage: 4,
      eta: 6,
      icon: Icons.airport_shuttle_outlined,
      gradientColors: [Color(0xFF2A3A4A), Color(0xFF1A2A3A)],
      amenities: [
        'Climatisation 4 zones',
        'Wi-Fi',
        'Eau pétillante',
        'Presse internationale',
        'Chargeur',
        'Sièges massants',
      ],
    ),
    FleetVehicle(
      id: 'van',
      name: 'Van',
      model: 'Mercedes Classe V',
      tagline: 'Le voyage, en groupe.',
      description:
          'Un van spacieux pour vos déplacements en famille ou entre amis. '
          'Jusqu\'à 7 passagers, dans un confort digne d\'un salon.',
      basePrice: 52,
      pricePerKm: 3.8,
      capacity: 7,
      luggage: 8,
      eta: 8,
      icon: Icons.directions_bus_filled_outlined,
      gradientColors: [Color(0xFF3A2A4A), Color(0xFF2A1A3A)],
      amenities: [
        'Climatisation',
        'Wi-Fi',
        'Eau fraîche',
        'Table centrale',
        'Chargeurs USB',
        'Écran',
      ],
    ),
    FleetVehicle(
      id: 'limousine',
      name: 'Limousine',
      model: 'Mercedes Classe S',
      tagline: 'L\'exception, à chaque instant.',
      description:
          'Le summum du voyage. Cuir Nappa, isolation acoustique totale, '
          'champagne à bord sur demande. L\'expérience LUXORA ultime.',
      basePrice: 88,
      pricePerKm: 5.5,
      capacity: 3,
      luggage: 3,
      eta: 10,
      icon: Icons.auto_awesome_outlined,
      gradientColors: [Color(0xFF4A3A2A), Color(0xFF2A1A0A)],
      amenities: [
        'Climatisation 4 zones',
        'Wi-Fi premium',
        'Champagne',
        'Sièges massants',
        'Écran 4K',
        'Parfum d\'ambiance',
      ],
    ),
  ];

  @override
  List<FleetVehicle> getVehicles() => _vehicles;

  @override
  FleetVehicle? getVehicleById(String id) {
    try {
      return _vehicles.firstWhere((v) => v.id == id);
    } catch (_) {
      return null;
    }
  }
}
