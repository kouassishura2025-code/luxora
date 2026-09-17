import 'package:go_router/go_router.dart';

import '../../../../app/router/page_transitions.dart';
import '../../../../app/router/route_names.dart';
import '../pages/kyc_verification_page.dart';
import '../pages/otp_verification_page.dart';
import '../pages/phone_entry_page.dart';

abstract final class AuthRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.phoneEntry,
          name: 'phoneEntry',
          pageBuilder: (context, state) => LuxoraPageTransitions.fadeThrough(
            key: state.pageKey,
            child: const PhoneEntryPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.otpVerification,
          name: 'otpVerification',
          pageBuilder: (context, state) => LuxoraPageTransitions.fadeThrough(
            key: state.pageKey,
            child: const OtpVerificationPage(),
          ),
        ),
        GoRoute(
          path: RouteNames.kycVerification,
          name: 'kycVerification',
          pageBuilder: (context, state) => LuxoraPageTransitions.slideRight(
            key: state.pageKey,
            child: const KycVerificationPage(),
          ),
        ),
      ];
}
