import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/home_page.dart';

/// Routes de la home (onglet 0 du shell).
abstract final class HomeRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.home,
          name: 'home',
          builder: (context, state) => const HomePage(),
        ),
      ];
}
