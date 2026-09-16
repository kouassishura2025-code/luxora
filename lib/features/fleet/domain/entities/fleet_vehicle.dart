import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Une classe de véhicule dans la flotte LUXORA.
class FleetVehicle extends Equatable {
  const FleetVehicle({
    required this.id,
    required this.name,
    required this.model,
    required this.tagline,
    required this.description,
    required this.basePrice,
    required this.pricePerKm,
    required this.capacity,
    required this.luggage,
    required this.eta,
    required this.icon,
    required this.gradientColors,
    required this.amenities,
  });

  final String id;
  final String name;
  final String model;
  final String tagline;
  final String description;
  final double basePrice;
  final double pricePerKm;
  final int capacity;
  final int luggage;
  final int eta;
  final IconData icon;

  /// Couleurs du dégradé signature (2 couleurs).
  final List<Color> gradientColors;

  /// Équipements à bord.
  final List<String> amenities;

  @override
  List<Object?> get props => [id];
}
