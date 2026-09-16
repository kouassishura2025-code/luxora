import 'package:equatable/equatable.dart';

/// Contact d'urgence LUXORA.
class EmergencyContact extends Equatable {
  const EmergencyContact({
    required this.id,
    required this.firstName,
    required this.lastName,
    required this.phoneNumber,
    this.isPrimary = false,
  });

  final String id;
  final String firstName;
  final String lastName;
  final String phoneNumber;
  final bool isPrimary;

  String get displayName => '$firstName $lastName';

  String get initials {
    final f = firstName.isNotEmpty ? firstName[0] : '';
    final l = lastName.isNotEmpty ? lastName[0] : '';
    return '$f$l'.toUpperCase();
  }

  @override
  List<Object?> get props => [id, phoneNumber, isPrimary];
}

/// Statut d'une alerte SOS.
enum SosStatus {
  idle,
  holding,
  triggered,
}

/// Durée de partage de trajet.
enum SharingDuration {
  thirtyMinutes('30 minutes', 30),
  oneHour('1 heure', 60),
  untilArrival('Jusqu\'à l\'arrivée', -1);

  const SharingDuration(this.label, this.minutes);
  final String label;
  final int minutes;
}
