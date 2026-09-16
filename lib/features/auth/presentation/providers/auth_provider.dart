import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../data/repositories/mock_auth_repository.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

/// ─────────────────────────────────────────────────────────
/// Flag de configuration : utilise le mock au lieu de Firebase.
///
/// Passe à `false` une fois Firebase Blaze activé.
/// ─────────────────────────────────────────────────────────
const bool useMockAuth = true;

// ─── Repository (mock actuellement) ───────────────────────
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  if (useMockAuth) {
    final repo = MockAuthRepository();
    // Initialise la session au démarrage.
    repo.initialize();
    ref.onDispose(repo.dispose);
    return repo;
  }

  // Firebase — désactivé pour l'instant
  throw UnimplementedError(
    'Firebase Auth nécessite le plan Blaze. '
    'Passe useMockAuth à true ou active Blaze.',
  );
});

// ─── Stream de l'utilisateur connecté ─────────────────────
final authStateChangesProvider = StreamProvider<UserEntity?>((ref) {
  return ref.watch(authRepositoryProvider).authStateChanges();
});

// ─── État du flux OTP ─────────────────────────────────────
class OtpFlowState {
  const OtpFlowState({
    this.verificationId,
    this.phoneNumber,
    this.isLoading = false,
    this.error,
  });

  final String? verificationId;
  final String? phoneNumber;
  final bool isLoading;
  final String? error;

  OtpFlowState copyWith({
    String? verificationId,
    String? phoneNumber,
    bool? isLoading,
    String? error,
    bool clearError = false,
  }) {
    return OtpFlowState(
      verificationId: verificationId ?? this.verificationId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      isLoading: isLoading ?? this.isLoading,
      error: clearError ? null : (error ?? this.error),
    );
  }
}

class OtpFlowNotifier extends StateNotifier<OtpFlowState> {
  OtpFlowNotifier(this._repository) : super(const OtpFlowState());

  final AuthRepository _repository;

  Future<bool> sendOtp(String phoneNumber) async {
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      final id = await _repository.sendOtp(phoneNumber: phoneNumber);
      state = state.copyWith(
        verificationId: id,
        phoneNumber: phoneNumber,
        isLoading: false,
      );
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _humanizeError(e));
      return false;
    }
  }

  Future<bool> verifyOtp(String code) async {
    if (state.verificationId == null) return false;
    state = state.copyWith(isLoading: true, clearError: true);
    try {
      await _repository.verifyOtp(
        verificationId: state.verificationId!,
        code: code,
      );
      state = state.copyWith(isLoading: false);
      return true;
    } catch (e) {
      state = state.copyWith(isLoading: false, error: _humanizeError(e));
      return false;
    }
  }

  void reset() => state = const OtpFlowState();

  String _humanizeError(Object e) {
    final msg = e.toString();
    if (msg.contains('incorrect')) {
      return 'Code incorrect. Utilisez 123456 pour tester.';
    }
    if (msg.contains('invalide')) {
      return 'Numéro de téléphone invalide.';
    }
    if (msg.contains('Aucun numéro')) {
      return 'Session expirée. Renvoyez un code.';
    }
    return 'Une erreur est survenue. Réessayez.';
  }
}

final otpFlowProvider =
    StateNotifierProvider<OtpFlowNotifier, OtpFlowState>((ref) {
  return OtpFlowNotifier(ref.watch(authRepositoryProvider));
});
