import 'package:go_router/go_router.dart';

import '../../../../app/router/page_transitions.dart';
import '../../../../app/router/route_names.dart';
import '../../../driver/presentation/pages/favorite_drivers_page.dart';
import '../pages/edit_profile_page.dart';
import '../pages/invoice_history_page.dart';
import '../pages/language_settings_page.dart';
import '../pages/notification_settings_page.dart';
import '../pages/payment_methods_page.dart';
import '../pages/privacy_settings_page.dart';
import '../pages/profile_page.dart';
import '../pages/travel_preferences_page.dart';

abstract final class ProfileRoutes {
  static List<RouteBase> get shellRoutes => [
        GoRoute(
          path: RouteNames.profile,
          name: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ];

  static List<RouteBase> get subRoutes => [
        GoRoute(
          path: RouteNames.editProfile,
          name: 'editProfile',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const EditProfilePage(),
          ),
        ),
        GoRoute(
          path: RouteNames.travelPreferences,
          name: 'travelPreferences',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const TravelPreferencesPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.privacySettings,
          name: 'privacySettings',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const PrivacySettingsPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.notificationSettings,
          name: 'notificationSettings',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const NotificationSettingsPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.paymentMethods,
          name: 'paymentMethods',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const PaymentMethodsPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.invoiceHistory,
          name: 'invoiceHistory',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const InvoiceHistoryPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.languageSettings,
          name: 'languageSettings',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const LanguageSettingsPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.favoriteDrivers,
          name: 'favoriteDrivers',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const FavoriteDriversPage(),
          ),
        ),
      ];
}
