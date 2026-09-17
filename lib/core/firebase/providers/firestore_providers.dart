import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../features/booking/data/repositories/booking_repository_firestore.dart';
import '../../../features/driver/data/repositories/driver_repository_firestore.dart';
import '../../../features/notifications/data/repositories/notification_repository_firestore.dart';
import '../firestore_service.dart';

// ─── Firestore instance ────────────────────────────────
final firebaseFirestoreProvider = Provider<FirebaseFirestore>((ref) {
  return FirebaseFirestore.instance;
});

final firestoreServiceProvider = Provider<FirestoreService>((ref) {
  return FirestoreService(ref.watch(firebaseFirestoreProvider));
});

// ─── Repositories Firestore ────────────────────────────
final bookingRepositoryFirestoreProvider =
    Provider<BookingRepositoryFirestore>((ref) {
  return BookingRepositoryFirestore(
    ref.watch(firestoreServiceProvider),
  );
});

final driverRepositoryFirestoreProvider =
    Provider<DriverRepositoryFirestore>((ref) {
  return DriverRepositoryFirestore(
    ref.watch(firestoreServiceProvider),
  );
});

final notificationRepositoryFirestoreProvider =
    Provider<NotificationRepositoryFirestore>((ref) {
  return NotificationRepositoryFirestore(
    ref.watch(firestoreServiceProvider),
  );
});
