import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

import '../../../../core/firebase/firebase_auth_service.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

class AuthRepositoryImpl implements AuthRepository {
  AuthRepositoryImpl({
    required FirebaseAuthService authService,
    required FirebaseFirestore firestore,
  })  : _authService = authService,
        _firestore = firestore;

  final FirebaseAuthService _authService;
  final FirebaseFirestore _firestore;

  @override
  UserEntity? get currentUser {
    final user = _authService.currentUser;
    return user == null ? null : _mapFirebaseUser(user);
  }

  @override
  Stream<UserEntity?> authStateChanges() {
    return _authService.authStateChanges().map((user) {
      return user == null ? null : _mapFirebaseUser(user);
    });
  }

  @override
  Future<String> sendOtp({required String phoneNumber}) {
    return _authService.sendOtp(phoneNumber: phoneNumber);
  }

  @override
  Future<UserEntity> verifyOtp({
    required String verificationId,
    required String code,
  }) async {
    final credential = await _authService.verifyOtp(
      verificationId: verificationId,
      code: code,
    );

    final user = credential.user!;
    final entity = _mapFirebaseUser(user);

    await _firestore.collection('users').doc(user.uid).set(
      {
        'uid': user.uid,
        'phoneNumber': user.phoneNumber ?? '',
        'displayName': entity.displayName,
        'kycVerified': entity.kycVerified,
        'createdAt': FieldValue.serverTimestamp(),
      },
      SetOptions(merge: true),
    );

    return entity;
  }

  @override
  Future<void> signOut() => _authService.signOut();

  UserEntity _mapFirebaseUser(User user) {
    return UserEntity(
      uid: user.uid,
      phoneNumber: user.phoneNumber ?? '',
      displayName: user.displayName,
      email: user.email,
      photoUrl: user.photoURL,
      kycVerified: false,
      createdAt: user.metadata.creationTime,
    );
  }
}
