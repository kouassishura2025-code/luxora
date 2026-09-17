import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../l10n/generated/app_localizations.dart';

/// Données locales de la Home (mock).
class RecentDestination {
  const RecentDestination({
    required this.label,
    required this.address,
    required this.relativeTime,
    required this.priceLabel,
    required this.icon,
  });

  final String label;
  final String address;
  final String relativeTime;
  final String priceLabel;
  final IconData icon;
}

/// Clé de salutation basée sur l'heure.
enum GreetingKey { morning, afternoon, evening }

final greetingKeyProvider = Provider<GreetingKey>((ref) {
  final hour = DateTime.now().hour;
  if (hour < 6) return GreetingKey.evening;
  if (hour < 12) return GreetingKey.morning;
  if (hour < 18) return GreetingKey.afternoon;
  return GreetingKey.evening;
});

/// Helper pour résoudre la clé en texte localisé.
String resolveGreeting(AppLocalizations l10n, GreetingKey key) {
  switch (key) {
    case GreetingKey.morning:
      return l10n.homeGreetingMorning;
    case GreetingKey.afternoon:
      return l10n.homeGreetingAfternoon;
    case GreetingKey.evening:
      return l10n.homeGreetingEvening;
  }
}

/// Nom de l'utilisateur (mock).
final userNameProvider = Provider<String>((ref) => 'M. Kouassi');

/// Initiales.
final userInitialsProvider = Provider<String>((ref) {
  final name = ref.watch(userNameProvider);
  final parts = name
      .replaceAll('M.', '')
      .trim()
      .split(' ')
      .where((p) => p.isNotEmpty)
      .toList();
  if (parts.isEmpty) return 'LK';
  if (parts.length == 1) return parts.first[0].toUpperCase();
  return (parts.first[0] + parts.last[0]).toUpperCase();
});

/// Destinations récentes (mock).
final recentDestinationsProvider = Provider<List<RecentDestination>>((ref) {
  return const [
    RecentDestination(
      label: 'Tour Eiffel',
      address: 'Champ de Mars, 7e arr.',
      relativeTime: 'Il y a 3 jours',
      priceLabel: '45 €',
      icon: Icons.location_city_outlined,
    ),
    RecentDestination(
      label: 'Aéroport CDG',
      address: 'Terminal 2E',
      relativeTime: 'Il y a 1 semaine',
      priceLabel: '120 €',
      icon: Icons.flight_takeoff_outlined,
    ),
    RecentDestination(
      label: 'Le Bristol Paris',
      address: '112 Rue du Faubourg St-Honoré',
      relativeTime: 'Il y a 2 semaines',
      priceLabel: '38 €',
      icon: Icons.hotel_outlined,
    ),
  ];
});
