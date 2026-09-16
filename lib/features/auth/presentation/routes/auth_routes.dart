import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../pages/kyc_verification_page.dart';
import '../pages/otp_verification_page.dart';
import '../pages/phone_entry_page.dart';

/// Routes d'authentification et KYC.
abstract final class AuthRoutes {
  static List<RouteBase> get routes => [
        GoRoute(
          path: RouteNames.phoneEntry,
          name: 'phoneEntry',
          builder: (context, state) => const PhoneEntryPage(),
        ),
        GoRoute(
          path: RouteNames.otpVerification,
          name: 'otpVerification',
          builder: (context, state) => const OtpVerificationPage(),
        ),
        GoRoute(
          path: RouteNames.kycVerification,
          name: 'kycVerification',
          builder: (context, state) => const KycVerificationPage(),
        ),
      ];
}
