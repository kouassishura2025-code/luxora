import 'package:go_router/go_router.dart';

import '../../../../app/router/page_transitions.dart';
import '../../../../app/router/route_names.dart';
import '../pages/sos_page.dart';
import '../pages/trip_sharing_page.dart';

abstract final class SafetyRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.sos,
          name: 'sos',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const SosPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.tripSharing,
          name: 'tripSharing',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const TripSharingPage(),
          ),
        ),
      ];
}
