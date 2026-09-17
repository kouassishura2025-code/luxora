class RouteNames {
  RouteNames._();

  // ─── Publiques ─────────────────────────────────────────
  static const String welcome = '/welcome';
  static const String onboarding = '/onboarding';
  static const String phoneEntry = '/login';
  static const String otpVerification = '/otp-verification';
  static const String kycVerification = '/kyc-verification';

  // ─── Shell ─────────────────────────────────────────────
  static const String home = '/';
  static const String bookingsHistory = '/bookings';
  static const String concierge = '/concierge';
  static const String profile = '/profile';

  // ─── Booking ───────────────────────────────────────────
  static const String destinationEntry = '/booking/destination';
  static const String vehicleSelection = '/booking/vehicle';
  static const String chauffeurPreferences = '/booking/preferences';
  static const String rideConfirmation = '/booking/confirmation';
  static const String rideTracking = '/booking/tracking';

  // ─── Concierge chat ────────────────────────────────────
  static const String conciergeChat = '/concierge/chat';

  // ─── Profile ───────────────────────────────────────────
  static const String editProfile = '/profile/edit';
  static const String travelPreferences = '/profile/travel-preferences';
  static const String privacySettings = '/profile/privacy';
  static const String notificationSettings = '/profile/notifications';
  static const String paymentMethods = '/profile/payment-methods';
  static const String invoiceHistory = '/profile/invoices';
  static const String languageSettings = '/profile/language';

  // ─── Fleet ─────────────────────────────────────────────
  static const String fleetCatalog = '/fleet';
  static String vehicleDetail(String id) => '/fleet/$id';

  // ─── Driver ────────────────────────────────────────────
  static const String favoriteDrivers = '/driver/favorites';

  // ─── Notifications ─────────────────────────────────────
  static const String notifications = '/notifications';

  // ─── Membership ────────────────────────────────────────
  static const String loyaltyDashboard = '/membership/loyalty';
  static const String perks = '/membership/perks';

  // ─── Safety ────────────────────────────────────────────
  static const String sos = '/safety/sos';
  static const String tripSharing = '/safety/trip-sharing';
}
