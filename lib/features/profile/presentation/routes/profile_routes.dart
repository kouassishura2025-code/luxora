import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/edit_profile_page.dart';
import '../pages/invoice_history_page.dart';
import '../pages/notification_settings_page.dart';
import '../pages/payment_methods_page.dart';
import '../pages/privacy_settings_page.dart';
import '../../../driver/presentation/pages/favorite_drivers_page.dart';
import '../pages/profile_page.dart';
import '../pages/travel_preferences_page.dart';

abstract final class ProfileRoutes {
  /// Onglet "Profil" du shell (branche 3).
  static List<RouteBase> get shellRoutes => [
        GoRoute(
          path: RouteNames.profile,
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ];

  /// Sous-pages du profil (hors shell, plein écran).
  static List<RouteBase> get subRoutes => [
        GoRoute(
          path: RouteNames.editProfile,
          name: 'editProfile',
          builder: (context, state) => const EditProfilePage(),
        ),
        GoRoute(
          path: RouteNames.travelPreferences,
          name: 'travelPreferences',
          builder: (context, state) => const TravelPreferencesPage(),
        ),
        GoRoute(
          path: RouteNames.privacySettings,
          name: 'privacySettings',
          builder: (context, state) => const PrivacySettingsPage(),
        ),
        GoRoute(
          path: RouteNames.notificationSettings,
          name: 'notificationSettings',
          builder: (context, state) =>
              const NotificationSettingsPage(),
        ),
        GoRoute(
          path: RouteNames.paymentMethods,
          name: 'paymentMethods',
          builder: (context, state) => const PaymentMethodsPage(),
        ),
        GoRoute(
          path: RouteNames.favoriteDrivers,
          name: 'favoriteDrivers',
          builder: (context, state) => const FavoriteDriversPage(),
        ),
        GoRoute(
          path: RouteNames.invoiceHistory,
          name: 'invoiceHistory',
          builder: (context, state) => const InvoiceHistoryPage(),
        ),
      ];
}
