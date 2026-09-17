import 'package:cloud_firestore/cloud_firestore.dart';


/// Statut d'une réservation Firestore.
enum BookingStatus {
  pending('En attente'),
  confirmed('Confirmée'),
  inProgress('En cours'),
  completed('Terminée'),
  cancelled('Annulée');

  const BookingStatus(this.label);
  final String label;

  static BookingStatus fromString(String? value) {
    return BookingStatus.values.firstWhere(
      (s) => s.name == value,
      orElse: () => BookingStatus.pending,
    );
  }
}

/// Modèle Firestore pour une réservation.
class BookingModel {
  const BookingModel({
    required this.id,
    required this.clientId,
    required this.driverId,
    required this.pickup,
    required this.destination,
    required this.vehicleId,
    required this.preferences,
    required this.status,
    required this.estimatedPrice,
    required this.createdAt,
    this.scheduledAt,
  });

  final String id;
  final String clientId;
  final String? driverId;
  final String pickup;
  final String destination;
  final String vehicleId;
  final List<String> preferences;
  final BookingStatus status;
  final double estimatedPrice;
  final DateTime createdAt;
  final DateTime? scheduledAt;

  static BookingModel fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return BookingModel(
      id: id,
      clientId: data['clientId'] as String? ?? '',
      driverId: data['driverId'] as String?,
      pickup: data['pickup'] as String? ?? '',
      destination: data['destination'] as String? ?? '',
      vehicleId: data['vehicleId'] as String? ?? '',
      preferences: List<String>.from(data['preferences'] ?? []),
      status: BookingStatus.fromString(data['status'] as String?),
      estimatedPrice: (data['estimatedPrice'] as num?)?.toDouble() ?? 0,
      createdAt: _parseDate(data['createdAt']) ?? DateTime.now(),
      scheduledAt: _parseDate(data['scheduledAt']),
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'clientId': clientId,
      'driverId': driverId,
      'pickup': pickup,
      'destination': destination,
      'vehicleId': vehicleId,
      'preferences': preferences,
      'status': status.name,
      'estimatedPrice': estimatedPrice,
      'createdAt': Timestamp.fromDate(createdAt),
      'scheduledAt': scheduledAt != null
          ? Timestamp.fromDate(scheduledAt!)
          : null,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static DateTime? _parseDate(dynamic value) {
    if (value == null) return null;
    if (value is Timestamp) return value.toDate();
    if (value is String) return DateTime.tryParse(value);
    return null;
  }
}
