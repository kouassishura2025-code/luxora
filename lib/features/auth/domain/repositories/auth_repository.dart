import '../entities/user_entity.dart';

/// Contrat du repository d'authentification.
abstract class AuthRepository {
  Stream<UserEntity?> authStateChanges();
  UserEntity? get currentUser;
  Future<String> sendOtp({required String phoneNumber});
  Future<UserEntity> verifyOtp({
    required String verificationId,
    required String code,
  });
  Future<void> signOut();
}
