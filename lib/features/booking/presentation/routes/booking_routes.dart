import 'package:go_router/go_router.dart';

import '../../../../app/router/page_transitions.dart';
import '../../../../app/router/route_names.dart';
import '../pages/bookings_history_page.dart';
import '../pages/chauffeur_preference_page.dart';
import '../pages/destination_entry_page.dart';
import '../pages/ride_confirmation_page.dart';
import '../pages/ride_tracking_page.dart';
import '../pages/vehicle_selection_page.dart';

abstract final class BookingRoutes {
  static List<RouteBase> get shellRoutes => [
        GoRoute(
          path: RouteNames.bookingsHistory,
          name: 'bookingsHistory',
          builder: (context, state) => const BookingsHistoryPage(),
        ),
      ];

  static List<RouteBase> get flowRoutes => [
        GoRoute(
          path: RouteNames.destinationEntry,
          name: 'destinationEntry',
          pageBuilder: (context, state) => LuxoraPageTransitions.fadeThrough(
            key: state.pageKey,
            child: const DestinationEntryPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.vehicleSelection,
          name: 'vehicleSelection',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const VehicleSelectionPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.chauffeurPreferences,
          name: 'chauffeurPreferences',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const ChauffeurPreferencePage(),
          ),
        ),
        GoRoute(
          path: RouteNames.rideConfirmation,
          name: 'rideConfirmation',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const RideConfirmationPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.rideTracking,
          name: 'rideTracking',
          pageBuilder: (context, state) => LuxoraPageTransitions.fadeThrough(
            key: state.pageKey,
            child: const RideTrackingPage(),
          ),
        ),
      ];
}
