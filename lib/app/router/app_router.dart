import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../features/auth/presentation/providers/auth_provider.dart';
import '../../features/auth/presentation/routes/auth_routes.dart';
import '../../features/booking/presentation/routes/booking_routes.dart';
import '../../features/concierge/presentation/routes/concierge_routes.dart';
import '../../features/fleet/presentation/routes/fleet_routes.dart';
import '../../features/membership/presentation/routes/membership_routes.dart';
import '../../features/notifications/presentation/routes/notification_routes.dart';
import '../../features/onboarding/presentation/routes/onboarding_routes.dart';
import '../../features/profile/presentation/routes/profile_routes.dart';
import '../../features/safety/presentation/routes/safety_routes.dart';
import 'guards/auth_guard.dart';
import 'route_names.dart';
import 'shell/shell_routes.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.welcome,
    refreshListenable: _AuthChangeNotifier(ref),
    redirect: (context, state) {
      final authState = ref.read(authStateChangesProvider);
      final isLoggedIn = authState.valueOrNull != null;
      return AuthGuard.check(
        isLoggedIn: isLoggedIn,
        location: state.matchedLocation,
      );
    },
    routes: [
      ...OnboardingRoutes.routes,
      ...AuthRoutes.routes,
      ShellRoutes.route,
      ...BookingRoutes.flowRoutes,
      ...ConciergeRoutes.chatRoutes,
      ...ProfileRoutes.subRoutes,
      ...FleetRoutes.routes,
      ...SafetyRoutes.routes,
      ...MembershipRoutes.routes,
      ...NotificationRoutes.routes,
    ],
  );
});

class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Ref ref) {
    ref.listen(authStateChangesProvider, (_, __) => notifyListeners());
  }
}
