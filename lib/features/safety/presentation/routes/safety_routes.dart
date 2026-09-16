import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/sos_page.dart';
import '../pages/trip_sharing_page.dart';

/// Routes de sécurité (hors shell).
abstract final class SafetyRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.sos,
          name: 'sos',
          builder: (context, state) => const SosPage(),
        ),
        GoRoute(
          path: RouteNames.tripSharing,
          name: 'tripSharing',
          builder: (context, state) => const TripSharingPage(),
        ),
      ];
}
