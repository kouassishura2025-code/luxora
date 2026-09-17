import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

/// Helper qui garantit qu'un utilisateur Firebase anonyme est connecté.
///
/// Utilisé en complément du mock auth pour permettre les writes Firestore.
abstract final class AnonymousAuthHelper {
  static bool _initialized = false;

  /// S'assure qu'un utilisateur Firebase (anonyme) est connecté.
  ///
  /// Appelé après un login mock pour permettre les writes Firestore.
  static Future<User?> ensureSignedIn() async {
    final auth = FirebaseAuth.instance;

    if (auth.currentUser != null) {
      debugPrint('✅ Firebase Auth déjà connecté : ${auth.currentUser!.uid}');
      return auth.currentUser;
    }

    if (_initialized) return auth.currentUser;

    try {
      final credential = await auth.signInAnonymously();
      _initialized = true;
      debugPrint('✅ Firebase Auth anonyme : ${credential.user?.uid}');
      return credential.user;
    } catch (e) {
      debugPrint('⚠️ Firebase Auth anonyme échoué : $e');
      return null;
    }
  }

  /// Déconnecte l'utilisateur Firebase.
  static Future<void> signOut() async {
    await FirebaseAuth.instance.signOut();
    _initialized = false;
  }
}
