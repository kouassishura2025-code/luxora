import 'app_localizations.dart';

// ignore_for_file: type=lint

/// The translations for French (`fr`).
class AppLocalizationsFr extends AppLocalizations {
  AppLocalizationsFr([String locale = 'fr']) : super(locale);

  @override
  String get appName => 'LUXORA';

  @override
  String get appTagline => 'Chauffeur privé & conciergerie de luxe';

  @override
  String get welcomeOverline => 'BIENVENUE';

  @override
  String get welcomeStart => 'Commencer';

  @override
  String get onboardingNext => 'Continuer';

  @override
  String get onboardingSkip => 'Passer';

  @override
  String get onboardingFinish => 'Commencer';

  @override
  String get loginTitle => 'Votre numéro';

  @override
  String get loginOverline => 'IDENTIFICATION';

  @override
  String get loginWelcome => 'Bienvenue.';

  @override
  String get loginSubtitle => 'Indiquez votre numéro de téléphone.';

  @override
  String get loginPhoneLabel => 'Numéro de téléphone';

  @override
  String get loginPhoneHint => '+225 XX XX XX XX XX';

  @override
  String get loginCta => 'Recevoir mon code';

  @override
  String get loginLegal => 'En continuant, vous acceptez nos conditions générales.';

  @override
  String get otpTitle => 'Code de sécurité';

  @override
  String get otpOverline => 'VÉRIFICATION';

  @override
  String get otpHeadline => 'Saisissez le code.';

  @override
  String otpSubtitle(String phone) {
    return 'Un code à 6 chiffres a été envoyé au $phone.';
  }

  @override
  String get otpDemo => 'Mode démo · Utilisez le code 123456';

  @override
  String get otpResend => 'Renvoyer le code';

  @override
  String get homeGreetingMorning => 'Bonjour,';

  @override
  String get homeGreetingAfternoon => 'Bon après-midi,';

  @override
  String get homeGreetingEvening => 'Bonsoir,';

  @override
  String get homeCity => 'Paris';

  @override
  String get homeBookingOverline => 'RÉSERVATION';

  @override
  String get homeBookingTitle => 'Où allons-nous ?';

  @override
  String get homeBookingSubtitle => 'Réservez votre chauffeur privé en quelques secondes.';

  @override
  String get homeBookingCta => 'Réserver maintenant';

  @override
  String get homeSectionAround => 'Autour de vous';

  @override
  String get homeSectionServices => 'Services';

  @override
  String get homeSectionRecent => 'Récents';

  @override
  String get homeSeeAll => 'Voir tout';

  @override
  String get homeConciergeAvailable => 'Un concierge est disponible 24h/24.';

  @override
  String get homeFooter => 'LUXORA — Paris · 2026';

  @override
  String get serviceConcierge => 'Concierge';

  @override
  String get serviceFleet => 'Flotte';

  @override
  String get serviceFavorites => 'Favoris';

  @override
  String get serviceSafety => 'Sécurité';

  @override
  String get bookingDestination => 'Destination';

  @override
  String get bookingVehicle => 'Votre véhicule';

  @override
  String get bookingPreferences => 'Préférences';

  @override
  String get bookingConfirmation => 'Confirmation';

  @override
  String get bookingTracking => 'Votre chauffeur';

  @override
  String get bookingContinue => 'Continuer';

  @override
  String get bookingConfirm => 'Confirmer la réservation';

  @override
  String get bookingFinish => 'Terminer';

  @override
  String get bookingContactDriver => 'Contacter le chauffeur';

  @override
  String get conciergeTitle => 'Concierge';

  @override
  String get conciergeOverline => '24h/24';

  @override
  String get conciergeAtService => 'À votre service.';

  @override
  String get conciergeSubtitle => 'Un concierge dédié, joignable à toute heure.';

  @override
  String get conciergeStartChat => 'Démarrer une conversation.';

  @override
  String get conciergeResponse => 'Réponse en moins de 2 minutes.';

  @override
  String get conciergeOnline => 'En ligne · réponse en 2 min';

  @override
  String get profileTitle => 'Profil';

  @override
  String get profileOverline => 'COMPTE';

  @override
  String get profileSectionAccount => 'Compte';

  @override
  String get profileSectionPreferences => 'Préférences';

  @override
  String get profileSectionSecurity => 'Sécurité';

  @override
  String get profileSectionSession => 'Session';

  @override
  String get profilePersonalInfo => 'Informations personnelles';

  @override
  String get profilePaymentMethods => 'Moyens de paiement';

  @override
  String get profileInvoiceHistory => 'Historique des factures';

  @override
  String get profileTravelPreferences => 'Préférences de trajet';

  @override
  String get profileFavoriteDrivers => 'Chauffeurs favoris';

  @override
  String get profileNotifications => 'Notifications';

  @override
  String get profilePrivacy => 'Confidentialité';

  @override
  String get profileKyc => 'Vérification KYC';

  @override
  String get profileLogout => 'Se déconnecter';

  @override
  String get profileLogoutConfirm => 'Se déconnecter ?';

  @override
  String get profileLogoutMessage => 'Vous devrez vous reconnecter à votre prochaine visite.';

  @override
  String get fleetTitle => 'Flotte';

  @override
  String get fleetOverline => 'NOTRE COLLECTION';

  @override
  String get fleetHeadline => 'Une flotte d\'exception.';

  @override
  String get fleetSubtitle => 'Quatre classes de véhicules.';

  @override
  String get fleetAllVehicles => 'Toute la flotte';

  @override
  String get fleetCommitments => 'Nos engagements';

  @override
  String get fleetBook => 'Réserver';

  @override
  String get membershipTitle => 'LUXORA Cercle';

  @override
  String get membershipOverline => 'MEMBERSHIP';

  @override
  String get membershipPerks => 'Avantages';

  @override
  String get membershipHistory => 'Historique';

  @override
  String get membershipCurrent => 'Votre niveau';

  @override
  String get safetyTitle => 'Assistance';

  @override
  String get safetyOverline => 'SÉCURITÉ';

  @override
  String get safetyHeadline => 'En cas d\'urgence.';

  @override
  String get safetySubtitle => 'Maintenez le bouton pendant 3 secondes.';

  @override
  String get safetyHold => 'Maintenez 3 secondes';

  @override
  String get safetyAlertSent => 'Alerte envoyée.';

  @override
  String get safetyContacts => 'Contacts d\'urgence';

  @override
  String get safetyTripSharing => 'Partage de trajet';

  @override
  String get notificationsTitle => 'Notifications';

  @override
  String get notificationsOverline => 'CENTRE D\'ACTIVITÉ';

  @override
  String get notificationsMarkAllRead => 'Tout lire';

  @override
  String get notificationsEmpty => 'Tout est à jour';

  @override
  String get notificationsEmptyMessage => 'Vous n\'avez aucune notification dans cette catégorie.';

  @override
  String get commonCancel => 'Annuler';

  @override
  String get commonConfirm => 'Confirmer';

  @override
  String get commonDelete => 'Supprimer';

  @override
  String get commonSave => 'Enregistrer';

  @override
  String get commonRetry => 'Réessayer';

  @override
  String get commonBack => 'Retour';

  @override
  String get commonClose => 'Fermer';

  @override
  String get commonSearch => 'Rechercher';

  @override
  String get commonLoading => 'Chargement...';

  @override
  String get commonError => 'Une erreur est survenue.';

  @override
  String get commonEmpty => 'Aucun élément';

  @override
  String get languageTitle => 'Langue';

  @override
  String get languageFrench => 'Français';

  @override
  String get languageEnglish => 'English';

  @override
  String get languageSystem => 'Système';

  @override
  String get kycTitle => 'Identité';

  @override
  String get kycHeadline => 'Vérifions\nvotre identité.';

  @override
  String get kycSubtitle => 'Fournissez les documents suivants pour activer votre compte et accéder à tous les services LUXORA.';

  @override
  String get kycRequired => 'REQUIS';

  @override
  String get kycOptional => 'OPTIONNELS';

  @override
  String get kycIdCard => 'Carte d\'identité nationale';

  @override
  String get kycSelfie => 'Selfie de vérification';

  @override
  String get kycPassport => 'Passeport';

  @override
  String get kycDriverLicense => 'Permis de conduire';

  @override
  String get kycAdd => 'Ajouter';

  @override
  String get kycDocumentProvided => 'Document fourni';

  @override
  String get kycDocumentMissing => 'À fournir';

  @override
  String get kycOptionalLabel => '· optionnel';

  @override
  String get kycSubmit => 'Soumettre pour vérification';

  @override
  String get kycProcessing => 'Traitement sous 24h ouvrées.';

  @override
  String get kycPrivacy => 'Vos documents sont chiffrés et stockés de manière sécurisée. Ils ne sont jamais partagés.';

  @override
  String get kycPendingHeadline => 'Documents reçus.';

  @override
  String get kycPendingMessage => 'Notre équipe vérifie vos documents.\nVous serez notifié sous 24h ouvrées.';

  @override
  String get kycPendingCta => 'Retour au profil';

  @override
  String get kycCancelSubmission => 'Annuler la soumission';

  @override
  String get kycProgress => 'AVANCEMENT';

  @override
  String get paymentTitle => 'Paiement';

  @override
  String get paymentHeadline => 'Vos moyens\nde paiement.';

  @override
  String get paymentPrimary => 'CARTE PRINCIPALE';

  @override
  String get paymentSecondary => 'CARTE SECONDAIRE';

  @override
  String get paymentHolder => 'TITULAIRE';

  @override
  String get paymentExpires => 'EXPIRE';

  @override
  String get paymentAddCard => 'Ajouter une carte';

  @override
  String get invoiceTitle => 'Factures';

  @override
  String get invoiceHeadline => 'Historique.';

  @override
  String get invoiceSubtitle => 'Vos trajets et leurs factures.';
}
