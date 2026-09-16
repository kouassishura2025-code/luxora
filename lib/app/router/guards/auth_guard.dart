
import '../route_names.dart';

/// Guard d'authentification.
///
/// - Si connecté et sur Welcome/Onboarding/Login → redirige vers Home.
/// - Si non connecté et sur route privée → redirige vers Login.
abstract final class AuthGuard {
  static const _publicRoutes = <String>[
    RouteNames.welcome,
    RouteNames.onboarding,
    RouteNames.phoneEntry,
    RouteNames.otpVerification,
  ];

  /// Retourne :
  /// - `null` si la navigation est autorisée
  /// - une `String` (chemin) pour rediriger
  static String? check({
    required bool isLoggedIn,
    required String location,
  }) {
    final isPublic = _publicRoutes.contains(location);

    // Connecté sur une page publique → Home
    if (isLoggedIn &&
        (location == RouteNames.welcome ||
            location == RouteNames.onboarding ||
            location == RouteNames.phoneEntry)) {
      return RouteNames.home;
    }

    // Non connecté sur une page privée → Login
    if (!isLoggedIn && !isPublic) {
      return RouteNames.phoneEntry;
    }

    return null;
  }

  /// Exposé pour permettre à GoRouter de rafraîchir.
  static bool get publicRoutes => true;
}
