import 'package:go_router/go_router.dart';

import '../../../../app/router/page_transitions.dart';
import '../../../../app/router/route_names.dart';
import '../pages/fleet_catalog_page.dart';
import '../pages/vehicle_detail_page.dart';

abstract final class FleetRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.fleetCatalog,
          name: 'fleetCatalog',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const FleetCatalogPage(),
          ),
        ),
        GoRoute(
          path: '/fleet/:vehicleId',
          name: 'vehicleDetail',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: VehicleDetailPage(
              vehicleId: state.pathParameters['vehicleId'] ?? '',
            ),
          ),
        ),
      ];
}
