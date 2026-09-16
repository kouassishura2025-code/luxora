import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

/// Données locales de la Home (mock, en attendant Firestore).
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

/// Salutation basée sur l'heure de la journée.
final greetingProvider = Provider<String>((ref) {
  final hour = DateTime.now().hour;
  if (hour < 6) return 'Bonsoir,';
  if (hour < 12) return 'Bonjour,';
  if (hour < 18) return 'Bon après-midi,';
  return 'Bonsoir,';
});

/// Nom court de l'utilisateur (mock, en attendant Firebase Auth).
final userNameProvider = Provider<String>((ref) => 'M. Kouassi');

/// Initiales pour l'avatar.
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
