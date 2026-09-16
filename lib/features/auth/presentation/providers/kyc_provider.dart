import 'package:flutter/foundation.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/kyc_document.dart';

@immutable
class KycState {
  const KycState({
    this.documents = const [],
    this.status = KycStatus.notStarted,
    this.isSubmitting = false,
    this.error,
    this.submittedAt,
  });

  final List<KycDocument> documents;
  final KycStatus status;
  final bool isSubmitting;
  final String? error;
  final DateTime? submittedAt;

  KycState copyWith({
    List<KycDocument>? documents,
    KycStatus? status,
    bool? isSubmitting,
    String? error,
    DateTime? submittedAt,
    bool clearError = false,
  }) {
    return KycState(
      documents: documents ?? this.documents,
      status: status ?? this.status,
      isSubmitting: isSubmitting ?? this.isSubmitting,
      error: clearError ? null : (error ?? this.error),
      submittedAt: submittedAt ?? this.submittedAt,
    );
  }

  bool hasDocument(KycDocumentType type) =>
      documents.any((d) => d.type == type);

  /// Un dossier est complet si CNI + selfie sont fournis.
  bool get isComplete =>
      hasDocument(KycDocumentType.idCard) &&
      hasDocument(KycDocumentType.selfie);

  /// Pourcentage d'avancement (0-1).
  double get progress {
    final required = [KycDocumentType.idCard, KycDocumentType.selfie];
    final done = required.where(hasDocument).length;
    return done / required.length;
  }
}

class KycNotifier extends StateNotifier<KycState> {
  KycNotifier() : super(const KycState());

  void addDocument(KycDocumentType type, String fileName) {
    final existing = state.documents.where((d) => d.type != type).toList();
    state = state.copyWith(
      documents: [
        ...existing,
        KycDocument(
          type: type,
          fileName: fileName,
          uploadedAt: DateTime.now(),
        ),
      ],
      status: KycStatus.inProgress,
      clearError: true,
    );
  }

  void removeDocument(KycDocumentType type) {
    state = state.copyWith(
      documents: state.documents.where((d) => d.type != type).toList(),
      status: KycStatus.inProgress,
    );
  }

  Future<bool> submit() async {
    if (!state.isComplete) {
      state = state.copyWith(
        error: 'Veuillez fournir la carte d\'identité et le selfie.',
      );
      return false;
    }
    state = state.copyWith(isSubmitting: true, clearError: true);

    // Simulation d'un envoi réseau.
    await Future<void>.delayed(const Duration(seconds: 2));

    state = state.copyWith(
      isSubmitting: false,
      status: KycStatus.pendingReview,
      submittedAt: DateTime.now(),
    );
    return true;
  }

  void reset() => state = const KycState();
}

final kycProvider = StateNotifierProvider<KycNotifier, KycState>((ref) {
  return KycNotifier();
});
