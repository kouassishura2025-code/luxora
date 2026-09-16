import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/booking_entities.dart';

/// État du flux de réservation.
@immutable
class BookingState {
  const BookingState({
    this.pickup = 'Position actuelle',
    this.destination,
    this.selectedVehicleId,
    this.selectedPreferences = const {},
    this.scheduledAt,
  });

  final String pickup;
  final String? destination;
  final String? selectedVehicleId;
  final Set<String> selectedPreferences;
  final DateTime? scheduledAt;

  BookingState copyWith({
    String? pickup,
    String? destination,
    String? selectedVehicleId,
    Set<String>? selectedPreferences,
    DateTime? scheduledAt,
  }) {
    return BookingState(
      pickup: pickup ?? this.pickup,
      destination: destination ?? this.destination,
      selectedVehicleId: selectedVehicleId ?? this.selectedVehicleId,
      selectedPreferences: selectedPreferences ?? this.selectedPreferences,
      scheduledAt: scheduledAt ?? this.scheduledAt,
    );
  }
}

class BookingNotifier extends StateNotifier<BookingState> {
  BookingNotifier() : super(const BookingState());

  void setPickup(String value) => state = state.copyWith(pickup: value);
  void setDestination(String value) =>
      state = state.copyWith(destination: value);
  void selectVehicle(String id) =>
      state = state.copyWith(selectedVehicleId: id);
  void togglePreference(String id) {
    final next = Set<String>.from(state.selectedPreferences);
    if (next.contains(id)) {
      next.remove(id);
    } else {
      next.add(id);
    }
    state = state.copyWith(selectedPreferences: next);
  }

  void reset() => state = const BookingState();
}

final bookingProvider =
    StateNotifierProvider<BookingNotifier, BookingState>((ref) {
  return BookingNotifier();
});

/// Flotte mock (en attendant Firestore).
final vehicleClassesProvider = Provider<List<VehicleClass>>((ref) {
  return const [
    VehicleClass(
      id: 'berline',
      name: 'Berline',
      tagline: 'L\'essentiel, sublimé.',
      description:
          'Mercedes Classe E ou équivalent. Idéale pour vos trajets urbains.',
      basePrice: 25,
      pricePerKm: 2.2,
      eta: 4,
      capacity: 3,
      icon: Icons.directions_car_filled_outlined,
      accent: Color(0xFF6B7C93),
    ),
    VehicleClass(
      id: 'suv',
      name: 'SUV',
      tagline: 'L\'espace, sans compromis.',
      description:
          'Range Rover Velar ou équivalent. Confort et présence.',
      basePrice: 38,
      pricePerKm: 3.1,
      eta: 6,
      capacity: 4,
      icon: Icons.airport_shuttle_outlined,
      accent: Color(0xFF4A5A6B),
    ),
    VehicleClass(
      id: 'van',
      name: 'Van',
      tagline: 'Le voyage, en groupe.',
      description:
          'Mercedes Classe V ou équivalent. Jusqu\'à 7 passagers.',
      basePrice: 52,
      pricePerKm: 3.8,
      eta: 8,
      capacity: 7,
      icon: Icons.directions_bus_filled_outlined,
      accent: Color(0xFF5B4A6B),
    ),
    VehicleClass(
      id: 'limousine',
      name: 'Limousine',
      tagline: 'L\'exception, à chaque instant.',
      description:
          'Mercedes Classe S ou équivalent. L\'expérience ultime.',
      basePrice: 88,
      pricePerKm: 5.5,
      eta: 10,
      capacity: 3,
      icon: Icons.auto_awesome_outlined,
      accent: Color(0xFFC9A24B),
    ),
  ];
});

/// Préférences chauffeur.
final chauffeurPreferencesProvider =
    Provider<List<ChauffeurPreference>>((ref) {
  return const [
    ChauffeurPreference(
      id: 'silence',
      label: 'Silence',
      icon: Icons.volume_off_outlined,
    ),
    ChauffeurPreference(
      id: 'music',
      label: 'Musique',
      icon: Icons.music_note_outlined,
    ),
    ChauffeurPreference(
      id: 'conversation',
      label: 'Conversation',
      icon: Icons.chat_bubble_outline,
    ),
    ChauffeurPreference(
      id: 'ac',
      label: 'Climatisation',
      icon: Icons.ac_unit_outlined,
    ),
    ChauffeurPreference(
      id: 'water',
      label: 'Eau fraîche',
      icon: Icons.local_drink_outlined,
    ),
    ChauffeurPreference(
      id: 'wifi',
      label: 'Wi-Fi',
      icon: Icons.wifi_outlined,
    ),
    ChauffeurPreference(
      id: 'newspaper',
      label: 'Presse',
      icon: Icons.menu_book_outlined,
    ),
    ChauffeurPreference(
      id: 'english',
      label: 'Anglais',
      icon: Icons.language_outlined,
    ),
  ];
});
