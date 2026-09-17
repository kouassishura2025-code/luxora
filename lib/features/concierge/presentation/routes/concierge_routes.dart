import 'package:go_router/go_router.dart';

import '../../../../app/router/page_transitions.dart';
import '../../../../app/router/route_names.dart';
import '../pages/concierge_chat_page.dart';
import '../pages/concierge_page.dart';

abstract final class ConciergeRoutes {
  static List<RouteBase> get shellRoutes => [
        GoRoute(
          path: RouteNames.concierge,
          name: 'concierge',
          builder: (context, state) => const ConciergePage(),
        ),
      ];

  static List<RouteBase> get chatRoutes => [
        GoRoute(
          path: RouteNames.conciergeChat,
          name: 'conciergeChat',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const ConciergeChatPage(),
          ),
        ),
      ];
}
