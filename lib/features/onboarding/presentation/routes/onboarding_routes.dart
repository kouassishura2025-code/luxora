import 'package:go_router/go_router.dart';

import '../../../../app/router/page_transitions.dart';
import '../../../../app/router/route_names.dart';
import '../pages/onboarding_carousel_page.dart';
import '../pages/welcome_page.dart';

abstract final class OnboardingRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.welcome,
          name: 'welcome',
          pageBuilder: (context, state) => LuxoraPageTransitions.fadeThrough(
            key: state.pageKey,
            child: const WelcomePage(),
          ),
        ),
        GoRoute(
          path: RouteNames.onboarding,
          name: 'onboarding',
          pageBuilder: (context, state) => LuxoraPageTransitions.fadeThrough(
            key: state.pageKey,
            child: const OnboardingCarouselPage(),
          ),
        ),
      ];
}
