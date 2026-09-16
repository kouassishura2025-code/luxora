import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/fleet_catalog_page.dart';
import '../pages/vehicle_detail_page.dart';

/// Routes de la flotte (hors shell, plein écran).
abstract final class FleetRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.fleetCatalog,
          name: 'fleetCatalog',
          builder: (context, state) => const FleetCatalogPage(),
        ),
        GoRoute(
          path: '/fleet/:vehicleId',
          name: 'vehicleDetail',
          builder: (context, state) {
            final id = state.pathParameters['vehicleId'] ?? '';
            return VehicleDetailPage(vehicleId: id);
          },
        ),
      ];
}
