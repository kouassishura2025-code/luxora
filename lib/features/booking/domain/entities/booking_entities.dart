import 'package:flutter/material.dart';

/// Une classe de véhicule disponible à la réservation.
@immutable
class VehicleClass {
  const VehicleClass({
    required this.id,
    required this.name,
    required this.tagline,
    required this.description,
    required this.basePrice,
    required this.pricePerKm,
    required this.eta,
    required this.capacity,
    required this.icon,
    required this.accent,
  });

  final String id;
  final String name;
  final String tagline;
  final String description;

  /// Prix de base en euros.
  final double basePrice;

  /// Prix par km en euros.
  final double pricePerKm;

  /// ETA de prise en charge (minutes).
  final int eta;

  /// Nombre de passagers.
  final int capacity;

  final IconData icon;

  /// Petite couleur d'accent (indigo, or, rouge sombre…).
  final Color accent;
}

/// Une préférence chauffeur (chip cochable).
@immutable
class ChauffeurPreference {
  const ChauffeurPreference({
    required this.id,
    required this.label,
    required this.icon,
  });

  final String id;
  final String label;
  final IconData icon;
}

/// Le récapitulatif de la réservation en cours.
@immutable
class BookingRequest {
  const BookingRequest({
    required this.destination,
    required this.pickup,
    required this.vehicle,
    required this.preferences,
    required this.scheduledAt,
    required this.estimatedPrice,
    required this.estimatedDuration,
  });

  final String destination;
  final String pickup;
  final VehicleClass vehicle;
  final List<String> preferences;
  final DateTime? scheduledAt;
  final double estimatedPrice;
  final Duration estimatedDuration;

  BookingRequest copyWith({
    String? destination,
    String? pickup,
    VehicleClass? vehicle,
    List<String>? preferences,
    DateTime? scheduledAt,
    double? estimatedPrice,
    Duration? estimatedDuration,
  }) {
    return BookingRequest(
      destination: destination ?? this.destination,
      pickup: pickup ?? this.pickup,
      vehicle: vehicle ?? this.vehicle,
      preferences: preferences ?? this.preferences,
      scheduledAt: scheduledAt ?? this.scheduledAt,
      estimatedPrice: estimatedPrice ?? this.estimatedPrice,
      estimatedDuration: estimatedDuration ?? this.estimatedDuration,
    );
  }
}
