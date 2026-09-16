import 'package:equatable/equatable.dart';

/// Type de document KYC.
enum KycDocumentType {
  idCard('Carte d\'identité nationale'),
  passport('Passeport'),
  driverLicense('Permis de conduire'),
  selfie('Selfie de vérification');

  const KycDocumentType(this.label);
  final String label;
}

/// Statut global du dossier KYC.
enum KycStatus {
  notStarted,
  inProgress,
  pendingReview,
  approved,
  rejected,
}

/// Un document KYC téléversé.
class KycDocument extends Equatable {
  const KycDocument({
    required this.type,
    required this.fileName,
    required this.uploadedAt,
  });

  final KycDocumentType type;
  final String fileName;
  final DateTime uploadedAt;

  @override
  List<Object?> get props => [type, fileName, uploadedAt];
}

/// Soumission KYC complète.
class KycSubmission extends Equatable {
  const KycSubmission({
    required this.documents,
    required this.status,
    this.submittedAt,
    this.rejectionReason,
  });

  final List<KycDocument> documents;
  final KycStatus status;
  final DateTime? submittedAt;
  final String? rejectionReason;

  @override
  List<Object?> get props => [
        documents,
        status,
        submittedAt,
        rejectionReason,
      ];
}
