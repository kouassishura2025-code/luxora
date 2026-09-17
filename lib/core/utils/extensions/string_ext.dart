/// Extensions String LUXORA.
extension StringX on String {
  /// Vrai si la chaîne est vide ou ne contient que des espaces.
  bool get isBlank => trim().isEmpty;

  /// Vrai si la chaîne est un email valide.
  bool get isEmail => RegExp(
        r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
      ).hasMatch(this);

  /// Vrai si la chaîne est un numéro de téléphone international.
  bool get isPhone => RegExp(r'^\+\d{8,15}$').hasMatch(this);

  /// Première lettre en majuscule.
  String get capitalize {
    if (isEmpty) return this;
    return '${this[0].toUpperCase()}${substring(1)}';
  }

  /// Initiales (max 2 lettres).
  String get initials {
    final parts = trim().split(RegExp(r'\s+')).where((p) => p.isNotEmpty);
    if (parts.isEmpty) return '';
    if (parts.length == 1) return parts.first[0].toUpperCase();
    return (parts.first[0] + parts.last[0]).toUpperCase();
  }

  /// Tronque avec ellipsis.
  String truncate(int maxLength) {
    if (length <= maxLength) return this;
    return '${substring(0, maxLength - 1)}…';
  }
}
