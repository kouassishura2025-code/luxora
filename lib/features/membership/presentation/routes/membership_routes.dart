import 'package:go_router/go_router.dart';

import '../../../../app/router/page_transitions.dart';
import '../../../../app/router/route_names.dart';
import '../pages/loyalty_dashboard_page.dart';
import '../pages/perks_page.dart';

abstract final class MembershipRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.loyaltyDashboard,
          name: 'loyaltyDashboard',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const LoyaltyDashboardPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.perks,
          name: 'perks',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const PerksPage(),
          ),
        ),
      ];
}
