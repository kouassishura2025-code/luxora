import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/concierge_chat_page.dart';
import '../pages/concierge_page.dart';

/// Routes du concierge (onglet 2 du shell + chat).
abstract final class ConciergeRoutes {
  /// Onglet "Concierge" du shell (branche 2).
  static List<RouteBase> get shellRoutes => [
        GoRoute(
          path: RouteNames.concierge,
          name: 'concierge',
          builder: (context, state) => const ConciergePage(),
        ),
      ];

  /// Chat concierge (hors shell, plein écran).
  static List<RouteBase> get chatRoutes => [
        GoRoute(
          path: RouteNames.conciergeChat,
          name: 'conciergeChat',
          builder: (context, state) => const ConciergeChatPage(),
        ),
      ];
}
