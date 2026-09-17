import 'package:cloud_firestore/cloud_firestore.dart';

import '../../../features/driver/domain/entities/driver.dart';

/// Modèle Firestore pour un chauffeur.
abstract final class DriverModel {
  static Driver fromFirestore(
    String id,
    Map<String, dynamic> data,
  ) {
    return Driver(
      id: id,
      firstName: data['firstName'] as String? ?? '',
      lastName: data['lastName'] as String? ?? '',
      rating: (data['rating'] as num?)?.toDouble() ?? 5.0,
      tripCount: (data['tripCount'] as num?)?.toInt() ?? 0,
      yearsOfService: (data['yearsOfService'] as num?)?.toInt() ?? 0,
      vehicleModel: data['vehicleModel'] as String? ?? '',
      status: _parseStatus(data['status'] as String?),
      isFavorite: data['isFavorite'] as bool? ?? false,
      languages: List<String>.from(
        data['languages'] ?? ['Français'],
      ),
    );
  }

  static Map<String, dynamic> toFirestore(Driver driver) {
    return {
      'firstName': driver.firstName,
      'lastName': driver.lastName,
      'rating': driver.rating,
      'tripCount': driver.tripCount,
      'yearsOfService': driver.yearsOfService,
      'vehicleModel': driver.vehicleModel,
      'status': driver.status.name,
      'languages': driver.languages,
      'updatedAt': FieldValue.serverTimestamp(),
    };
  }

  static DriverStatus _parseStatus(String? value) {
    return DriverStatus.values.firstWhere(
      (s) => s.name == value,
      orElse: () => DriverStatus.offDuty,
    );
  }
}
