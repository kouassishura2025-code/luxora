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
import '../../features/safety/presentation/routes/safety_routes.dart';
import '../../features/profile/presentation/routes/profile_routes.dart';
import '../../features/onboarding/presentation/routes/onboarding_routes.dart';
import 'guards/auth_guard.dart';
import 'route_names.dart';
import 'shell/shell_routes.dart';

/// Router principal LUXORA.
///
/// Agrège les routes de toutes les features. Chaque feature expose
/// ses routes via une classe `<Feature>Routes`.
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
      // ─── Pages publiques ──────────────────────────────
      ...OnboardingRoutes.routes,
      ...AuthRoutes.routes,

      // ─── Shell avec bottom nav (4 onglets) ────────────
      ShellRoutes.route,

      // ─── Flux de réservation (hors shell) ─────────────
      ...BookingRoutes.flowRoutes,

      // ─── Concierge chat (hors shell) ─────────────────
      ...ConciergeRoutes.chatRoutes,

      // ─── Sous-pages du profil (hors shell) ───────────
      ...ProfileRoutes.subRoutes,

      // ─── Fleet (hors shell) ──────────────────────────
      ...FleetRoutes.routes,

      // ─── Safety (hors shell) ─────────────────────────
      ...SafetyRoutes.routes,

      // ─── Membership (hors shell) ─────────────────────
      ...MembershipRoutes.routes,

      // ─── Notifications (hors shell) ──────────────────
      ...NotificationRoutes.routes,
    ],
  );
});

/// Permet à GoRouter de se rafraîchir quand l'état d'auth change.
class _AuthChangeNotifier extends ChangeNotifier {
  _AuthChangeNotifier(Ref ref) {
    ref.listen(authStateChangesProvider, (_, __) => notifyListeners());
  }
}
