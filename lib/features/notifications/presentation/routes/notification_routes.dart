import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/notifications_page.dart';

abstract final class NotificationRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.notifications,
          name: 'notifications',
          builder: (context, state) => const NotificationsPage(),
        ),
      ];
}
