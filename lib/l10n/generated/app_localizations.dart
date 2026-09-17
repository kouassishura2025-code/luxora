import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:intl/intl.dart' as intl;

import 'app_localizations_en.dart';
import 'app_localizations_fr.dart';

// ignore_for_file: type=lint

/// Callers can lookup localized strings with an instance of AppLocalizations
/// returned by `AppLocalizations.of(context)`.
///
/// Applications need to include `AppLocalizations.delegate()` in their app's
/// `localizationDelegates` list, and the locales they support in the app's
/// `supportedLocales` list. For example:
///
/// ```dart
/// import 'generated/app_localizations.dart';
///
/// return MaterialApp(
///   localizationsDelegates: AppLocalizations.localizationsDelegates,
///   supportedLocales: AppLocalizations.supportedLocales,
///   home: MyApplicationHome(),
/// );
/// ```
///
/// ## Update pubspec.yaml
///
/// Please make sure to update your pubspec.yaml to include the following
/// packages:
///
/// ```yaml
/// dependencies:
///   # Internationalization support.
///   flutter_localizations:
///     sdk: flutter
///   intl: any # Use the pinned version from flutter_localizations
///
///   # Rest of dependencies
/// ```
///
/// ## iOS Applications
///
/// iOS applications define key application metadata, including supported
/// locales, in an Info.plist file that is built into the application bundle.
/// To configure the locales supported by your app, you’ll need to edit this
/// file.
///
/// First, open your project’s ios/Runner.xcworkspace Xcode workspace file.
/// Then, in the Project Navigator, open the Info.plist file under the Runner
/// project’s Runner folder.
///
/// Next, select the Information Property List item, select Add Item from the
/// Editor menu, then select Localizations from the pop-up menu.
///
/// Select and expand the newly-created Localizations item then, for each
/// locale your application supports, add a new item and select the locale
/// you wish to add from the pop-up menu in the Value field. This list should
/// be consistent with the languages listed in the AppLocalizations.supportedLocales
/// property.
abstract class AppLocalizations {
  AppLocalizations(String locale) : localeName = intl.Intl.canonicalizedLocale(locale.toString());

  final String localeName;

  static AppLocalizations of(BuildContext context) {
    return Localizations.of<AppLocalizations>(context, AppLocalizations)!;
  }

  static const LocalizationsDelegate<AppLocalizations> delegate = _AppLocalizationsDelegate();

  /// A list of this localizations delegate along with the default localizations
  /// delegates.
  ///
  /// Returns a list of localizations delegates containing this delegate along with
  /// GlobalMaterialLocalizations.delegate, GlobalCupertinoLocalizations.delegate,
  /// and GlobalWidgetsLocalizations.delegate.
  ///
  /// Additional delegates can be added by appending to this list in
  /// MaterialApp. This list does not have to be used at all if a custom list
  /// of delegates is preferred or required.
  static const List<LocalizationsDelegate<dynamic>> localizationsDelegates = <LocalizationsDelegate<dynamic>>[
    delegate,
    GlobalMaterialLocalizations.delegate,
    GlobalCupertinoLocalizations.delegate,
    GlobalWidgetsLocalizations.delegate,
  ];

  /// A list of this localizations delegate's supported locales.
  static const List<Locale> supportedLocales = <Locale>[
    Locale('en'),
    Locale('fr')
  ];

  /// No description provided for @appName.
  ///
  /// In fr, this message translates to:
  /// **'LUXORA'**
  String get appName;

  /// No description provided for @appTagline.
  ///
  /// In fr, this message translates to:
  /// **'Chauffeur privé & conciergerie de luxe'**
  String get appTagline;

  /// No description provided for @welcomeOverline.
  ///
  /// In fr, this message translates to:
  /// **'BIENVENUE'**
  String get welcomeOverline;

  /// No description provided for @welcomeStart.
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get welcomeStart;

  /// No description provided for @onboardingNext.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get onboardingNext;

  /// No description provided for @onboardingSkip.
  ///
  /// In fr, this message translates to:
  /// **'Passer'**
  String get onboardingSkip;

  /// No description provided for @onboardingFinish.
  ///
  /// In fr, this message translates to:
  /// **'Commencer'**
  String get onboardingFinish;

  /// No description provided for @loginTitle.
  ///
  /// In fr, this message translates to:
  /// **'Votre numéro'**
  String get loginTitle;

  /// No description provided for @loginOverline.
  ///
  /// In fr, this message translates to:
  /// **'IDENTIFICATION'**
  String get loginOverline;

  /// No description provided for @loginWelcome.
  ///
  /// In fr, this message translates to:
  /// **'Bienvenue.'**
  String get loginWelcome;

  /// No description provided for @loginSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Indiquez votre numéro de téléphone.'**
  String get loginSubtitle;

  /// No description provided for @loginPhoneLabel.
  ///
  /// In fr, this message translates to:
  /// **'Numéro de téléphone'**
  String get loginPhoneLabel;

  /// No description provided for @loginPhoneHint.
  ///
  /// In fr, this message translates to:
  /// **'+225 XX XX XX XX XX'**
  String get loginPhoneHint;

  /// No description provided for @loginCta.
  ///
  /// In fr, this message translates to:
  /// **'Recevoir mon code'**
  String get loginCta;

  /// No description provided for @loginLegal.
  ///
  /// In fr, this message translates to:
  /// **'En continuant, vous acceptez nos conditions générales.'**
  String get loginLegal;

  /// No description provided for @otpTitle.
  ///
  /// In fr, this message translates to:
  /// **'Code de sécurité'**
  String get otpTitle;

  /// No description provided for @otpOverline.
  ///
  /// In fr, this message translates to:
  /// **'VÉRIFICATION'**
  String get otpOverline;

  /// No description provided for @otpHeadline.
  ///
  /// In fr, this message translates to:
  /// **'Saisissez le code.'**
  String get otpHeadline;

  /// No description provided for @otpSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Un code à 6 chiffres a été envoyé au {phone}.'**
  String otpSubtitle(String phone);

  /// No description provided for @otpDemo.
  ///
  /// In fr, this message translates to:
  /// **'Mode démo · Utilisez le code 123456'**
  String get otpDemo;

  /// No description provided for @otpResend.
  ///
  /// In fr, this message translates to:
  /// **'Renvoyer le code'**
  String get otpResend;

  /// No description provided for @homeGreetingMorning.
  ///
  /// In fr, this message translates to:
  /// **'Bonjour,'**
  String get homeGreetingMorning;

  /// No description provided for @homeGreetingAfternoon.
  ///
  /// In fr, this message translates to:
  /// **'Bon après-midi,'**
  String get homeGreetingAfternoon;

  /// No description provided for @homeGreetingEvening.
  ///
  /// In fr, this message translates to:
  /// **'Bonsoir,'**
  String get homeGreetingEvening;

  /// No description provided for @homeCity.
  ///
  /// In fr, this message translates to:
  /// **'Paris'**
  String get homeCity;

  /// No description provided for @homeBookingOverline.
  ///
  /// In fr, this message translates to:
  /// **'RÉSERVATION'**
  String get homeBookingOverline;

  /// No description provided for @homeBookingTitle.
  ///
  /// In fr, this message translates to:
  /// **'Où allons-nous ?'**
  String get homeBookingTitle;

  /// No description provided for @homeBookingSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Réservez votre chauffeur privé en quelques secondes.'**
  String get homeBookingSubtitle;

  /// No description provided for @homeBookingCta.
  ///
  /// In fr, this message translates to:
  /// **'Réserver maintenant'**
  String get homeBookingCta;

  /// No description provided for @homeSectionAround.
  ///
  /// In fr, this message translates to:
  /// **'Autour de vous'**
  String get homeSectionAround;

  /// No description provided for @homeSectionServices.
  ///
  /// In fr, this message translates to:
  /// **'Services'**
  String get homeSectionServices;

  /// No description provided for @homeSectionRecent.
  ///
  /// In fr, this message translates to:
  /// **'Récents'**
  String get homeSectionRecent;

  /// No description provided for @homeSeeAll.
  ///
  /// In fr, this message translates to:
  /// **'Voir tout'**
  String get homeSeeAll;

  /// No description provided for @homeConciergeAvailable.
  ///
  /// In fr, this message translates to:
  /// **'Un concierge est disponible 24h/24.'**
  String get homeConciergeAvailable;

  /// No description provided for @homeFooter.
  ///
  /// In fr, this message translates to:
  /// **'LUXORA — Paris · 2026'**
  String get homeFooter;

  /// No description provided for @serviceConcierge.
  ///
  /// In fr, this message translates to:
  /// **'Concierge'**
  String get serviceConcierge;

  /// No description provided for @serviceFleet.
  ///
  /// In fr, this message translates to:
  /// **'Flotte'**
  String get serviceFleet;

  /// No description provided for @serviceFavorites.
  ///
  /// In fr, this message translates to:
  /// **'Favoris'**
  String get serviceFavorites;

  /// No description provided for @serviceSafety.
  ///
  /// In fr, this message translates to:
  /// **'Sécurité'**
  String get serviceSafety;

  /// No description provided for @bookingDestination.
  ///
  /// In fr, this message translates to:
  /// **'Destination'**
  String get bookingDestination;

  /// No description provided for @bookingVehicle.
  ///
  /// In fr, this message translates to:
  /// **'Votre véhicule'**
  String get bookingVehicle;

  /// No description provided for @bookingPreferences.
  ///
  /// In fr, this message translates to:
  /// **'Préférences'**
  String get bookingPreferences;

  /// No description provided for @bookingConfirmation.
  ///
  /// In fr, this message translates to:
  /// **'Confirmation'**
  String get bookingConfirmation;

  /// No description provided for @bookingTracking.
  ///
  /// In fr, this message translates to:
  /// **'Votre chauffeur'**
  String get bookingTracking;

  /// No description provided for @bookingContinue.
  ///
  /// In fr, this message translates to:
  /// **'Continuer'**
  String get bookingContinue;

  /// No description provided for @bookingConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer la réservation'**
  String get bookingConfirm;

  /// No description provided for @bookingFinish.
  ///
  /// In fr, this message translates to:
  /// **'Terminer'**
  String get bookingFinish;

  /// No description provided for @bookingContactDriver.
  ///
  /// In fr, this message translates to:
  /// **'Contacter le chauffeur'**
  String get bookingContactDriver;

  /// No description provided for @conciergeTitle.
  ///
  /// In fr, this message translates to:
  /// **'Concierge'**
  String get conciergeTitle;

  /// No description provided for @conciergeOverline.
  ///
  /// In fr, this message translates to:
  /// **'24h/24'**
  String get conciergeOverline;

  /// No description provided for @conciergeAtService.
  ///
  /// In fr, this message translates to:
  /// **'À votre service.'**
  String get conciergeAtService;

  /// No description provided for @conciergeSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Un concierge dédié, joignable à toute heure.'**
  String get conciergeSubtitle;

  /// No description provided for @conciergeStartChat.
  ///
  /// In fr, this message translates to:
  /// **'Démarrer une conversation.'**
  String get conciergeStartChat;

  /// No description provided for @conciergeResponse.
  ///
  /// In fr, this message translates to:
  /// **'Réponse en moins de 2 minutes.'**
  String get conciergeResponse;

  /// No description provided for @conciergeOnline.
  ///
  /// In fr, this message translates to:
  /// **'En ligne · réponse en 2 min'**
  String get conciergeOnline;

  /// No description provided for @profileTitle.
  ///
  /// In fr, this message translates to:
  /// **'Profil'**
  String get profileTitle;

  /// No description provided for @profileOverline.
  ///
  /// In fr, this message translates to:
  /// **'COMPTE'**
  String get profileOverline;

  /// No description provided for @profileSectionAccount.
  ///
  /// In fr, this message translates to:
  /// **'Compte'**
  String get profileSectionAccount;

  /// No description provided for @profileSectionPreferences.
  ///
  /// In fr, this message translates to:
  /// **'Préférences'**
  String get profileSectionPreferences;

  /// No description provided for @profileSectionSecurity.
  ///
  /// In fr, this message translates to:
  /// **'Sécurité'**
  String get profileSectionSecurity;

  /// No description provided for @profileSectionSession.
  ///
  /// In fr, this message translates to:
  /// **'Session'**
  String get profileSectionSession;

  /// No description provided for @profilePersonalInfo.
  ///
  /// In fr, this message translates to:
  /// **'Informations personnelles'**
  String get profilePersonalInfo;

  /// No description provided for @profilePaymentMethods.
  ///
  /// In fr, this message translates to:
  /// **'Moyens de paiement'**
  String get profilePaymentMethods;

  /// No description provided for @profileInvoiceHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique des factures'**
  String get profileInvoiceHistory;

  /// No description provided for @profileTravelPreferences.
  ///
  /// In fr, this message translates to:
  /// **'Préférences de trajet'**
  String get profileTravelPreferences;

  /// No description provided for @profileFavoriteDrivers.
  ///
  /// In fr, this message translates to:
  /// **'Chauffeurs favoris'**
  String get profileFavoriteDrivers;

  /// No description provided for @profileNotifications.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get profileNotifications;

  /// No description provided for @profilePrivacy.
  ///
  /// In fr, this message translates to:
  /// **'Confidentialité'**
  String get profilePrivacy;

  /// No description provided for @profileKyc.
  ///
  /// In fr, this message translates to:
  /// **'Vérification KYC'**
  String get profileKyc;

  /// No description provided for @profileLogout.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter'**
  String get profileLogout;

  /// No description provided for @profileLogoutConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Se déconnecter ?'**
  String get profileLogoutConfirm;

  /// No description provided for @profileLogoutMessage.
  ///
  /// In fr, this message translates to:
  /// **'Vous devrez vous reconnecter à votre prochaine visite.'**
  String get profileLogoutMessage;

  /// No description provided for @fleetTitle.
  ///
  /// In fr, this message translates to:
  /// **'Flotte'**
  String get fleetTitle;

  /// No description provided for @fleetOverline.
  ///
  /// In fr, this message translates to:
  /// **'NOTRE COLLECTION'**
  String get fleetOverline;

  /// No description provided for @fleetHeadline.
  ///
  /// In fr, this message translates to:
  /// **'Une flotte d\'exception.'**
  String get fleetHeadline;

  /// No description provided for @fleetSubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Quatre classes de véhicules.'**
  String get fleetSubtitle;

  /// No description provided for @fleetAllVehicles.
  ///
  /// In fr, this message translates to:
  /// **'Toute la flotte'**
  String get fleetAllVehicles;

  /// No description provided for @fleetCommitments.
  ///
  /// In fr, this message translates to:
  /// **'Nos engagements'**
  String get fleetCommitments;

  /// No description provided for @fleetBook.
  ///
  /// In fr, this message translates to:
  /// **'Réserver'**
  String get fleetBook;

  /// No description provided for @membershipTitle.
  ///
  /// In fr, this message translates to:
  /// **'LUXORA Cercle'**
  String get membershipTitle;

  /// No description provided for @membershipOverline.
  ///
  /// In fr, this message translates to:
  /// **'MEMBERSHIP'**
  String get membershipOverline;

  /// No description provided for @membershipPerks.
  ///
  /// In fr, this message translates to:
  /// **'Avantages'**
  String get membershipPerks;

  /// No description provided for @membershipHistory.
  ///
  /// In fr, this message translates to:
  /// **'Historique'**
  String get membershipHistory;

  /// No description provided for @membershipCurrent.
  ///
  /// In fr, this message translates to:
  /// **'Votre niveau'**
  String get membershipCurrent;

  /// No description provided for @safetyTitle.
  ///
  /// In fr, this message translates to:
  /// **'Assistance'**
  String get safetyTitle;

  /// No description provided for @safetyOverline.
  ///
  /// In fr, this message translates to:
  /// **'SÉCURITÉ'**
  String get safetyOverline;

  /// No description provided for @safetyHeadline.
  ///
  /// In fr, this message translates to:
  /// **'En cas d\'urgence.'**
  String get safetyHeadline;

  /// No description provided for @safetySubtitle.
  ///
  /// In fr, this message translates to:
  /// **'Maintenez le bouton pendant 3 secondes.'**
  String get safetySubtitle;

  /// No description provided for @safetyHold.
  ///
  /// In fr, this message translates to:
  /// **'Maintenez 3 secondes'**
  String get safetyHold;

  /// No description provided for @safetyAlertSent.
  ///
  /// In fr, this message translates to:
  /// **'Alerte envoyée.'**
  String get safetyAlertSent;

  /// No description provided for @safetyContacts.
  ///
  /// In fr, this message translates to:
  /// **'Contacts d\'urgence'**
  String get safetyContacts;

  /// No description provided for @safetyTripSharing.
  ///
  /// In fr, this message translates to:
  /// **'Partage de trajet'**
  String get safetyTripSharing;

  /// No description provided for @notificationsTitle.
  ///
  /// In fr, this message translates to:
  /// **'Notifications'**
  String get notificationsTitle;

  /// No description provided for @notificationsOverline.
  ///
  /// In fr, this message translates to:
  /// **'CENTRE D\'ACTIVITÉ'**
  String get notificationsOverline;

  /// No description provided for @notificationsMarkAllRead.
  ///
  /// In fr, this message translates to:
  /// **'Tout lire'**
  String get notificationsMarkAllRead;

  /// No description provided for @notificationsEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Tout est à jour'**
  String get notificationsEmpty;

  /// No description provided for @notificationsEmptyMessage.
  ///
  /// In fr, this message translates to:
  /// **'Vous n\'avez aucune notification dans cette catégorie.'**
  String get notificationsEmptyMessage;

  /// No description provided for @commonCancel.
  ///
  /// In fr, this message translates to:
  /// **'Annuler'**
  String get commonCancel;

  /// No description provided for @commonConfirm.
  ///
  /// In fr, this message translates to:
  /// **'Confirmer'**
  String get commonConfirm;

  /// No description provided for @commonDelete.
  ///
  /// In fr, this message translates to:
  /// **'Supprimer'**
  String get commonDelete;

  /// No description provided for @commonSave.
  ///
  /// In fr, this message translates to:
  /// **'Enregistrer'**
  String get commonSave;

  /// No description provided for @commonRetry.
  ///
  /// In fr, this message translates to:
  /// **'Réessayer'**
  String get commonRetry;

  /// No description provided for @commonBack.
  ///
  /// In fr, this message translates to:
  /// **'Retour'**
  String get commonBack;

  /// No description provided for @commonClose.
  ///
  /// In fr, this message translates to:
  /// **'Fermer'**
  String get commonClose;

  /// No description provided for @commonSearch.
  ///
  /// In fr, this message translates to:
  /// **'Rechercher'**
  String get commonSearch;

  /// No description provided for @commonLoading.
  ///
  /// In fr, this message translates to:
  /// **'Chargement...'**
  String get commonLoading;

  /// No description provided for @commonError.
  ///
  /// In fr, this message translates to:
  /// **'Une erreur est survenue.'**
  String get commonError;

  /// No description provided for @commonEmpty.
  ///
  /// In fr, this message translates to:
  /// **'Aucun élément'**
  String get commonEmpty;

  /// No description provided for @languageTitle.
  ///
  /// In fr, this message translates to:
  /// **'Langue'**
  String get languageTitle;

  /// No description provided for @languageFrench.
  ///
  /// In fr, this message translates to:
  /// **'Français'**
  String get languageFrench;

  /// No description provided for @languageEnglish.
  ///
  /// In fr, this message translates to:
  /// **'English'**
  String get languageEnglish;

  /// No description provided for @languageSystem.
  ///
  /// In fr, this message translates to:
  /// **'Système'**
  String get languageSystem;
}

class _AppLocalizationsDelegate extends LocalizationsDelegate<AppLocalizations> {
  const _AppLocalizationsDelegate();

  @override
  Future<AppLocalizations> load(Locale locale) {
    return SynchronousFuture<AppLocalizations>(lookupAppLocalizations(locale));
  }

  @override
  bool isSupported(Locale locale) => <String>['en', 'fr'].contains(locale.languageCode);

  @override
  bool shouldReload(_AppLocalizationsDelegate old) => false;
}

AppLocalizations lookupAppLocalizations(Locale locale) {


  // Lookup logic when only language code is specified.
  switch (locale.languageCode) {
    case 'en': return AppLocalizationsEn();
    case 'fr': return AppLocalizationsFr();
  }

  throw FlutterError(
    'AppLocalizations.delegate failed to load unsupported locale "$locale". This is likely '
    'an issue with the localizations generation tool. Please file an issue '
    'on GitHub with a reproducible sample app and the gen-l10n configuration '
    'that was used.'
  );
}
