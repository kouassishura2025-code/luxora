// ignore_for_file: require_trailing_commas
import '../../../../core/error/error_mapper.dart';
import '../../../../core/firebase/firestore_paths.dart';
import '../../../../core/firebase/firestore_service.dart';
import '../../../../core/firebase/models/booking_model.dart';

/// Repository Firestore pour les réservations.
class BookingRepositoryFirestore {
  BookingRepositoryFirestore(this._firestore);

  final FirestoreService _firestore;

  /// Crée une nouvelle réservation.
  Future<String> createBooking({
    required String clientId,
    required String pickup,
    required String destination,
    required String vehicleId,
    required List<String> preferences,
    required double estimatedPrice,
    DateTime? scheduledAt,
  }) async {
    try {
      final now = DateTime.now();
      final model = BookingModel(
        id: '',
        clientId: clientId,
        driverId: null,
        pickup: pickup,
        destination: destination,
        vehicleId: vehicleId,
        preferences: preferences,
        status: BookingStatus.pending,
        estimatedPrice: estimatedPrice,
        createdAt: now,
        scheduledAt: scheduledAt,
      );

      final id = await _firestore.addDocument(
        FirestorePaths.bookings,
        model.toFirestore(),
      );

      return id;
    } catch (e) {
      throw ErrorMapper.toFailure(e);
    }
  }

  /// Stream des réservations d'un client.
  Stream<List<BookingModel>> streamClientBookings(String clientId) {
    return _firestore
        .streamCollection(
          FirestorePaths.bookings,
          queryBuilder: (q) => q
              .where('clientId', isEqualTo: clientId)
              .orderBy('createdAt', descending: true),
          limit: 50,
        )
        .map(
          (list) => list
              .map((data) => BookingModel.fromFirestore(
                    data['id'] as String? ?? '',
                    data,
                  ))
              .toList(),
        );
  }

  /// Met à jour le statut d'une réservation.
  Future<void> updateBookingStatus(
    String bookingId,
    BookingStatus status,
  ) async {
    try {
      await _firestore.updateDocument(
        FirestorePaths.booking(bookingId),
        {'status': status.name},
      );
    } catch (e) {
      throw ErrorMapper.toFailure(e);
    }
  }

  /// Annule une réservation.
  Future<void> cancelBooking(String bookingId) async {
    await updateBookingStatus(bookingId, BookingStatus.cancelled);
  }
}
