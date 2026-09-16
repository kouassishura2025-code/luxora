import 'dart:async';

import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/entities/user_entity.dart';
import '../../domain/repositories/auth_repository.dart';

/// Mock du repository d'authentification — 100 % local.
///
/// Utilisé quand Firebase Auth (plan Blaze) n'est pas disponible.
/// Le code OTP est TOUJOURS "123456". La session est persistée dans
/// SharedPreferences pour permettre l'auto-login.
class MockAuthRepository implements AuthRepository {
  MockAuthRepository();

  static const _kUserKey = 'mock_user';
  static const _kOtpKey = 'mock_otp_verification_id';

  final _controller = StreamController<UserEntity?>.broadcast();

  UserEntity? _currentUser;
  String? _pendingPhone;

  /// Charge la session existante au démarrage.
  Future<void> initialize() async {
    final prefs = await SharedPreferences.getInstance();
    final uid = prefs.getString('${_kUserKey}_uid');
    final phone = prefs.getString('${_kUserKey}_phone');
    if (uid != null && phone != null) {
      _currentUser = UserEntity(
        uid: uid,
        phoneNumber: phone,
        kycVerified: prefs.getBool('${_kUserKey}_kyc') ?? false,
      );
      _controller.add(_currentUser);
    } else {
      _controller.add(null);
    }
  }

  @override
  UserEntity? get currentUser => _currentUser;

  @override
  Stream<UserEntity?> authStateChanges() => _controller.stream;

  @override
  Future<String> sendOtp({required String phoneNumber}) async {
    // Simule un délai réseau.
    await Future<void>.delayed(const Duration(milliseconds: 600));

    // Validation basique du numéro.
    if (!phoneNumber.startsWith('+') || phoneNumber.length < 8) {
      throw Exception('Numéro de téléphone invalide.');
    }

    _pendingPhone = phoneNumber;

    // Retourne un "verificationId" factice.
    final verificationId =
        'mock_${DateTime.now().millisecondsSinceEpoch}';

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_kOtpKey, verificationId);

    return verificationId;
  }

  @override
  Future<UserEntity> verifyOtp({
    required String verificationId,
    required String code,
  }) async {
    await Future<void>.delayed(const Duration(milliseconds: 600));

    if (code != '123456') {
      throw Exception('Code incorrect. Utilisez 123456 pour tester.');
    }

    if (_pendingPhone == null) {
      throw Exception('Aucun numéro en attente. Renvoyez un code.');
    }

    final uid = 'mock_${DateTime.now().millisecondsSinceEpoch}';
    final user = UserEntity(
      uid: uid,
      phoneNumber: _pendingPhone!,
      displayName: null,
      kycVerified: false,
      createdAt: DateTime.now(),
    );

    _currentUser = user;
    _controller.add(user);

    // Persistance locale.
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('${_kUserKey}_uid', uid);
    await prefs.setString('${_kUserKey}_phone', _pendingPhone!);
    await prefs.setBool('${_kUserKey}_kyc', false);

    return user;
  }

  @override
  Future<void> signOut() async {
    _currentUser = null;
    _controller.add(null);

    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('${_kUserKey}_uid');
    await prefs.remove('${_kUserKey}_phone');
    await prefs.remove('${_kUserKey}_kyc');
    await prefs.remove(_kOtpKey);
  }

  void dispose() {
    _controller.close();
  }
}
