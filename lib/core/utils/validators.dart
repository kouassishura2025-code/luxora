/// Validators LUXORA — règles de validation des formulaires.
abstract final class Validators {
  // ─── Téléphone ─────────────────────────────────────────
  /// Format international (+225XXXXXXXXXX).
  static String? phone(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Numéro requis';
    if (!v.startsWith('+')) return 'Format international requis (+225…)';
    final digits = v.replaceAll(RegExp(r'\D'), '');
    if (digits.length < 8) return 'Numéro trop court';
    if (digits.length > 15) return 'Numéro trop long';
    return null;
  }

  // ─── Email ─────────────────────────────────────────────
  static final _emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );

  static String? email(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Email requis';
    if (!_emailRegex.hasMatch(v)) return 'Email invalide';
    return null;
  }

  static String? optionalEmail(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null;
    return email(v);
  }

  // ─── Mot de passe (pour plus tard) ─────────────────────
  static String? password(String? value) {
    final v = value ?? '';
    if (v.isEmpty) return 'Mot de passe requis';
    if (v.length < 8) return 'Au moins 8 caractères';
    if (!v.contains(RegExp(r'[A-Z]'))) return 'Au moins 1 majuscule';
    if (!v.contains(RegExp(r'[0-9]'))) return 'Au moins 1 chiffre';
    return null;
  }

  // ─── Code OTP ──────────────────────────────────────────
  static String? otp(String? value, {int length = 6}) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Code requis';
    if (v.length != length) return 'Code à $length chiffres';
    if (!RegExp(r'^\d+$').hasMatch(v)) return 'Chiffres uniquement';
    return null;
  }

  // ─── Nom ───────────────────────────────────────────────
  static String? name(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Nom requis';
    if (v.length < 2) return 'Trop court';
    if (v.length > 50) return 'Trop long';
    return null;
  }

  static String? optionalName(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return null;
    return name(v);
  }

  // ─── Adresse ───────────────────────────────────────────
  static String? address(String? value) {
    final v = value?.trim() ?? '';
    if (v.isEmpty) return 'Adresse requise';
    if (v.length < 3) return 'Adresse trop courte';
    return null;
  }
}
