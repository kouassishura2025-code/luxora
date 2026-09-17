// ignore_for_file: require_trailing_commas
import '../../../../core/error/error_mapper.dart';
import '../../../../core/firebase/firestore_paths.dart';
import '../../../../core/firebase/firestore_service.dart';
import '../../../../core/firebase/models/driver_model.dart';
import '../../domain/entities/driver.dart';

/// Repository Firestore pour les chauffeurs.
class DriverRepositoryFirestore {
  DriverRepositoryFirestore(this._firestore);

  final FirestoreService _firestore;

  /// Stream des chauffeurs disponibles.
  Stream<List<Driver>> streamAvailableDrivers() {
    return _firestore
        .streamCollection(
          FirestorePaths.drivers,
          queryBuilder: (q) => q
              .where('status', isEqualTo: DriverStatus.available.name)
              .limit(20),
        )
        .map(
          (list) => list
              .map((data) => DriverModel.fromFirestore(
                    data['id'] as String? ?? '',
                    data,
                  ))
              .toList(),
        );
  }

  /// Stream d'un chauffeur.
  Stream<Driver?> streamDriver(String driverId) {
    return _firestore
        .streamDocument(FirestorePaths.driver(driverId))
        .map((data) => data == null
            ? null
            : DriverModel.fromFirestore(driverId, data));
  }

  /// Ajoute un chauffeur (seed).
  Future<void> addDriver(Driver driver) async {
    try {
      await _firestore.setDocument(
        FirestorePaths.driver(driver.id),
        DriverModel.toFirestore(driver),
      );
    } catch (e) {
      throw ErrorMapper.toFailure(e);
    }
  }
}
