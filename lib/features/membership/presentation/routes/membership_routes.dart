import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/loyalty_dashboard_page.dart';
import '../pages/perks_page.dart';

/// Routes membership (hors shell).
abstract final class MembershipRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.loyaltyDashboard,
          name: 'loyaltyDashboard',
          builder: (context, state) => const LoyaltyDashboardPage(),
        ),
        GoRoute(
          path: RouteNames.perks,
          name: 'perks',
          builder: (context, state) => const PerksPage(),
        ),
      ];
}
