import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/onboarding_carousel_page.dart';
import '../pages/welcome_page.dart';

/// Routes publiques de l'onboarding.
abstract final class OnboardingRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.welcome,
          name: 'welcome',
          builder: (context, state) => const WelcomePage(),
        ),
        GoRoute(
          path: RouteNames.onboarding,
          name: 'onboarding',
          builder: (context, state) => const OnboardingCarouselPage(),
        ),
      ];
}
