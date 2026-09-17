import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for English (`en`).
class AppLocalizationsEn extends AppLocalizations {
  AppLocalizationsEn([String locale = 'en']) : super(locale);

  @override
  String get appName => 'LUXORA';

  @override
  String get appTagline => 'Private chauffeur & luxury concierge';

  @override
  String get welcomeOverline => 'WELCOME';

  @override
  String get welcomeStart => 'Get started';

  @override
  String get onboardingNext => 'Continue';

  @override
  String get onboardingSkip => 'Skip';

  @override
  String get onboardingFinish => 'Get started';

  @override
  String get loginTitle => 'Your number';

  @override
  String get loginOverline => 'IDENTIFICATION';

  @override
  String get loginWelcome => 'Welcome.';

  @override
  String get loginSubtitle => 'Enter your phone number.';

  @override
  String get loginPhoneLabel => 'Phone number';

  @override
  String get loginPhoneHint => '+225 XX XX XX XX XX';

  @override
  String get loginCta => 'Send my code';

  @override
  String get loginLegal => 'By continuing, you agree to our terms and conditions.';

  @override
  String get otpTitle => 'Security code';

  @override
  String get otpOverline => 'VERIFICATION';

  @override
  String get otpHeadline => 'Enter the code.';

  @override
  String otpSubtitle(String phone) {
    return 'A 6-digit code was sent to $phone.';
  }

  @override
  String get otpDemo => 'Demo mode · Use code 123456';

  @override
  String get otpResend => 'Resend code';

  @override
  String get homeGreetingMorning => 'Good morning,';

  @override
  String get homeGreetingAfternoon => 'Good afternoon,';

  @override
  String get homeGreetingEvening => 'Good evening,';

  @override
  String get homeCity => 'Paris';

  @override
  String get homeBookingOverline => 'BOOKING';

  @override
  String get homeBookingTitle => 'Where to?';

  @override
  String get homeBookingSubtitle => 'Book your private chauffeur in seconds.';

  @override
  String get homeBookingCta => 'Book now';

  @override
  String get homeSectionAround => 'Around you';

  @override
  String get homeSectionServices => 'Services';

  @override
  String get homeSectionRecent => 'Recent';

  @override
  String get homeSeeAll => 'See all';

  @override
  String get homeConciergeAvailable => 'A concierge is available 24/7.';

  @override
  String get homeFooter => 'LUXORA — Paris · 2026';

  @override
  String get serviceConcierge => 'Concierge';

  @override
  String get serviceFleet => 'Fleet';

  @override
  String get serviceFavorites => 'Favorites';

  @override
  String get serviceSafety => 'Safety';

  @override
  String get bookingDestination => 'Destination';

  @override
  String get bookingVehicle => 'Your vehicle';

  @override
  String get bookingPreferences => 'Preferences';

  @override
  String get bookingConfirmation => 'Confirmation';

  @override
  String get bookingTracking => 'Your driver';

  @override
  String get bookingContinue => 'Continue';

  @override
  String get bookingConfirm => 'Confirm booking';

  @override
  String get bookingFinish => 'Finish';

  @override
  String get bookingContactDriver => 'Contact driver';

  @override
  String get conciergeTitle => 'Concierge';

  @override
  String get conciergeOverline => '24/7';

  @override
  String get conciergeAtService => 'At your service.';

  @override
  String get conciergeSubtitle => 'A dedicated concierge, available anytime.';

  @override
  String get conciergeStartChat => 'Start a conversation.';

  @override
  String get conciergeResponse => 'Response in under 2 minutes.';

  @override
  String get conciergeOnline => 'Online · responds in 2 min';

  @override
  String get profileTitle => 'Profile';

  @override
  String get profileOverline => 'ACCOUNT';

  @override
  String get profileSectionAccount => 'Account';

  @override
  String get profileSectionPreferences => 'Preferences';

  @override
  String get profileSectionSecurity => 'Security';

  @override
  String get profileSectionSession => 'Session';

  @override
  String get profilePersonalInfo => 'Personal information';

  @override
  String get profilePaymentMethods => 'Payment methods';

  @override
  String get profileInvoiceHistory => 'Invoice history';

  @override
  String get profileTravelPreferences => 'Travel preferences';

  @override
  String get profileFavoriteDrivers => 'Favorite drivers';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profilePrivacy => 'Privacy';

  @override
  String get profileKyc => 'KYC verification';

  @override
  String get profileLogout => 'Sign out';

  @override
  String get profileLogoutConfirm => 'Sign out?';

  @override
  String get profileLogoutMessage => 'You\'ll need to sign in again on your next visit.';

  @override
  String get fleetTitle => 'Fleet';

  @override
  String get fleetOverline => 'OUR COLLECTION';

  @override
  String get fleetHeadline => 'An exceptional fleet.';

  @override
  String get fleetSubtitle => 'Four vehicle classes.';

  @override
  String get fleetAllVehicles => 'Full fleet';

  @override
  String get fleetCommitments => 'Our commitments';

  @override
  String get fleetBook => 'Book';

  @override
  String get membershipTitle => 'LUXORA Circle';

  @override
  String get membershipOverline => 'MEMBERSHIP';

  @override
  String get membershipPerks => 'Perks';

  @override
  String get membershipHistory => 'History';

  @override
  String get membershipCurrent => 'Your tier';

  @override
  String get safetyTitle => 'Assistance';

  @override
  String get safetyOverline => 'SAFETY';

  @override
  String get safetyHeadline => 'In case of emergency.';

  @override
  String get safetySubtitle => 'Hold the button for 3 seconds.';

  @override
  String get safetyHold => 'Hold for 3 seconds';

  @override
  String get safetyAlertSent => 'Alert sent.';

  @override
  String get safetyContacts => 'Emergency contacts';

  @override
  String get safetyTripSharing => 'Trip sharing';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsOverline => 'ACTIVITY CENTER';

  @override
  String get notificationsMarkAllRead => 'Mark all read';

  @override
  String get notificationsEmpty => 'All caught up';

  @override
  String get notificationsEmptyMessage => 'You have no notifications in this category.';

  @override
  String get commonCancel => 'Cancel';

  @override
  String get commonConfirm => 'Confirm';

  @override
  String get commonDelete => 'Delete';

  @override
  String get commonSave => 'Save';

  @override
  String get commonRetry => 'Retry';

  @override
  String get commonBack => 'Back';

  @override
  String get commonClose => 'Close';

  @override
  String get commonSearch => 'Search';

  @override
  String get commonLoading => 'Loading...';

  @override
  String get commonError => 'Something went wrong.';

  @override
  String get commonEmpty => 'Nothing here';

  @override
  String get languageTitle => 'Language';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSystem => 'System';
}
