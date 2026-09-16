import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/bookings_history_page.dart';
import '../pages/chauffeur_preference_page.dart';
import '../pages/destination_entry_page.dart';
import '../pages/ride_confirmation_page.dart';
import '../pages/ride_tracking_page.dart';
import '../pages/vehicle_selection_page.dart';

/// Routes du flux de réservation.
abstract final class BookingRoutes {
  /// Onglet "Réservations" du shell (branche 1).
  static List<RouteBase> get shellRoutes => [
        GoRoute(
          path: RouteNames.bookingsHistory,
          name: 'bookingsHistory',
          builder: (context, state) => const BookingsHistoryPage(),
        ),
      ];

  /// Flux de réservation (hors shell, plein écran).
  static List<RouteBase> get flowRoutes => [
        GoRoute(
          path: RouteNames.destinationEntry,
          name: 'destinationEntry',
          builder: (context, state) => const DestinationEntryPage(),
        ),
        GoRoute(
          path: RouteNames.vehicleSelection,
          name: 'vehicleSelection',
          builder: (context, state) => const VehicleSelectionPage(),
        ),
        GoRoute(
          path: RouteNames.chauffeurPreferences,
          name: 'chauffeurPreferences',
          builder: (context, state) => const ChauffeurPreferencePage(),
        ),
        GoRoute(
          path: RouteNames.rideConfirmation,
          name: 'rideConfirmation',
          builder: (context, state) => const RideConfirmationPage(),
        ),
        GoRoute(
          path: RouteNames.rideTracking,
          name: 'rideTracking',
          builder: (context, state) => const RideTrackingPage(),
        ),
      ];
}
