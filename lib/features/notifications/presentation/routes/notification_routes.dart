import 'package:go_router/go_router.dart';

import '../../../../app/router/page_transitions.dart';
import '../../../../app/router/route_names.dart';
import '../pages/notifications_page.dart';

abstract final class NotificationRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.notifications,
          name: 'notifications',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const NotificationsPage(),
          ),
        ),
      ];
}
