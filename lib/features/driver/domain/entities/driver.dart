import 'package:equatable/equatable.dart';

/// Statut de disponibilité d'un chauffeur.
enum DriverStatus {
  available('Disponible'),
  onRide('En course'),
  offDuty('Hors service');

  const DriverStatus(this.label);
  final String label;
}

/// Un chauffeur LUXORA.
class Driver extends Equatable {
  const Driver({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.rating,
    required this.tripCount,
    required this.yearsOfService,
    required this.vehicleModel,
    required this.status,
    this.isFavorite = false,
    this.languages = const ['Français', 'Anglais'],
  });

  final String id;
  final String firstName;
  final String lastName;
  final double rating;
  final int tripCount;
  final int yearsOfService;
  final String vehicleModel;
  final DriverStatus status;
  final bool isFavorite;
  final List<String> languages;

  String get displayName => '$firstName $lastName';

  String get initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = lastName.isNotEmpty ? lastName[0] : '';
    return '$f$l'.toUpperCase();
  }

  Driver copyWith({
    String? id,
    String? firstName,
    String? lastName,
    double? rating,
    int? tripCount,
    int? yearsOfService,
    String? vehicleModel,
    DriverStatus? status,
    bool? isFavorite,
    List<String>? languages,
  }) {
    return Driver(
      id: id ?? this.id,
      firstName: firstName ?? this.firstName,
      lastName: lastName ?? this.lastName,
      rating: rating ?? this.rating,
      tripCount: tripCount ?? this.tripCount,
      yearsOfService: yearsOfService ?? this.yearsOfService,
      vehicleModel: vehicleModel ?? this.vehicleModel,
      status: status ?? this.status,
      isFavorite: isFavorite ?? this.isFavorite,
      languages: languages ?? this.languages,
    );
  }

  @override
  List<Object?> get props => [id, isFavorite, status];
}
