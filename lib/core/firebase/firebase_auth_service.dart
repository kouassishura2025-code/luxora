import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';

/// Wrapper Firebase Auth LUXORA.
class FirebaseAuthService {
  FirebaseAuthService(this._auth);

  final FirebaseAuth _auth;

  FirebaseAuth get instance => _auth;
  User? get currentUser => _auth.currentUser;
  Stream<User?> authStateChanges() => _auth.authStateChanges();

  /// Connexion anonyme (Firestore sans SMS).
  Future<UserCredential> signInAnonymously() {
    return _auth.signInAnonymously();
  }

  /// Envoie un OTP par SMS.
  Future<String> sendOtp({
    required String phoneNumber,
    int? forceResendingToken,
  }) async {
    final completer = Completer<String>();

    await _auth.verifyPhoneNumber(
      phoneNumber: phoneNumber,
      timeout: const Duration(seconds: 60),
      verificationCompleted: (_) {},
      verificationFailed: (exception) {
        if (!completer.isCompleted) completer.completeError(exception);
      },
      codeSent: (verificationId, _) {
        if (!completer.isCompleted) completer.complete(verificationId);
      },
      codeAutoRetrievalTimeout: (_) {},
      forceResendingToken: forceResendingToken,
    );

    return completer.future;
  }

  /// Vérifie un code OTP.
  Future<UserCredential> verifyOtp({
    required String verificationId,
    required String code,
  }) {
    final credential = PhoneAuthProvider.credential(
      verificationId: verificationId,
      smsCode: code,
    );
    return _auth.signInWithCredential(credential);
  }

  Future<void> signOut() => _auth.signOut();
}
