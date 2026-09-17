/// Chemins Firestore LUXORA.
///
/// Centralise tous les noms de collections et sous-collections.
abstract final class FirestorePaths {
  static const String users = 'users';
  static const String bookings = 'bookings';
  static const String drivers = 'drivers';
  static const String notifications = 'notifications';

  static const String favorites = 'favorites';
  static const String messages = 'messages';
  static const String documents = 'documents';

  static String user(String userId) => '$users/$userId';
  static String booking(String bookingId) => '$bookings/$bookingId';
  static String driver(String driverId) => '$drivers/$driverId';
  static String notification(String notifId) => '$notifications/$notifId';

  static String userFavorites(String userId) =>
      '$users/$userId/$favorites';

  static String userDocuments(String userId) =>
      '$users/$userId/$documents';
}
