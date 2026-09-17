/// Extensions DateTime LUXORA.
extension DateTimeX on DateTime {
  /// Vrai si c'est aujourd'hui.
  bool get isToday {
    final now = DateTime.now();
    return year == now.year && month == now.month && day == now.day;
  }

  /// Vrai si c'est hier.
  bool get isYesterday {
    final yesterday = DateTime.now().subtract(const Duration(days: 1));
    return year == yesterday.year &&
        month == yesterday.month &&
        day == yesterday.day;
  }

  /// Vrai si c'est dans la semaine (7 jours).
  bool get isThisWeek {
    final now = DateTime.now();
    return now.difference(this).inDays < 7;
  }

  /// Format court : "20h45".
  String get timeShort {
    final h = hour.toString().padLeft(2, '0');
    final m = minute.toString().padLeft(2, '0');
    return '${h}h$m';
  }

  /// Format date français : "14 sept. 2026".
  String get dateShort {
    const months = [
      'janv.', 'févr.', 'mars', 'avr.', 'mai', 'juin',
      'juil.', 'août', 'sept.', 'oct.', 'nov.', 'déc.',
    ];
    return '$day ${months[month - 1]} $year';
  }

  /// Format relatif : "Il y a 5 min", "Hier", "Il y a 3 jours".
  String get relative {
    final diff = DateTime.now().difference(this);
    if (diff.inMinutes < 1) return 'À l\'instant';
    if (diff.inMinutes < 60) return 'Il y a ${diff.inMinutes} min';
    if (diff.inHours < 24) return 'Il y a ${diff.inHours} h';
    if (isYesterday) return 'Hier';
    if (diff.inDays < 7) return 'Il y a ${diff.inDays} j';
    if (diff.inDays < 30) return 'Il y a ${(diff.inDays / 7).floor()} sem';
    return dateShort;
  }
}
