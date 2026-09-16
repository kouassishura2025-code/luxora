import 'package:go_router/go_router.dart';

import '../../../features/booking/presentation/routes/booking_routes.dart';
import '../../../features/concierge/presentation/routes/concierge_routes.dart';
import '../../../features/home/presentation/routes/home_routes.dart';
import '../../../features/profile/presentation/routes/profile_routes.dart';
import '../../shell/luxora_shell.dart';

/// Shell principal avec bottom nav (4 onglets).
///
/// Chaque onglet correspond à une branche indépendante avec son propre
/// historique de navigation.
abstract final class ShellRoutes {
  static StatefulShellRoute get route => StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return LuxoraShell(
            currentIndex: navigationShell.currentIndex,
            child: navigationShell,
          );
        },
        branches: [
          // ─── Onglet 0 : Accueil ───────────────────────
          StatefulShellBranch(routes: HomeRoutes.routes),

          // ─── Onglet 1 : Réservations ──────────────────
          StatefulShellBranch(routes: BookingRoutes.shellRoutes),

          // ─── Onglet 2 : Concierge ─────────────────────
          StatefulShellBranch(routes: ConciergeRoutes.shellRoutes),

          // ─── Onglet 3 : Profil ────────────────────────
          StatefulShellBranch(routes: ProfileRoutes.shellRoutes),
        ],
      );
}
