import 'package:flutter/material.dart';

import '../../domain/entities/membership.dart';

/// Repository membership (mock).
abstract class MembershipRepository {
  Membership getMembership(String userId);
  List<Perk> getPerksForTier(MembershipTier tier);
  List<PointsEvent> getPointsHistory(String userId);
}

class MockMembershipRepository implements MembershipRepository {
  @override
  Membership getMembership(String userId) {
    return Membership(
      userId: userId,
      tier: MembershipTier.silver,
      points: 2847,
      memberSince: DateTime(2026, 3, 12),
    );
  }

  @override
  List<Perk> getPerksForTier(MembershipTier tier) {
    switch (tier) {
      case MembershipTier.silver:
        return const [
          Perk(
            title: 'Réservation prioritaire',
            description: 'Vos demandes sont traitées en premier.',
            icon: Icons.bolt_rounded,
          ),
          Perk(
            title: 'Annulation gratuite',
            description: 'Jusqu\'à 2 heures avant la prise en charge.',
            icon: Icons.event_busy_outlined,
          ),
          Perk(
            title: 'Support 24/7',
            description: 'Un concierge joignable à toute heure.',
            icon: Icons.support_agent_outlined,
          ),
        ];
      case MembershipTier.gold:
        return const [
          Perk(
            title: 'Tous les avantages Silver',
            description: 'Réservation prioritaire, annulation, support.',
            icon: Icons.workspace_premium_outlined,
          ),
          Perk(
            title: 'Chauffeur favori garanti',
            description: 'Votre chauffeur préféré en priorité.',
            icon: Icons.person_outline_rounded,
          ),
          Perk(
            title: 'Eau & presse à bord',
            description: 'Eau fraîche et presse du jour.',
            icon: Icons.local_drink_outlined,
          ),
          Perk(
            title: '10% sur les courses',
            description: 'Réduction automatique sur chaque trajet.',
            icon: Icons.percent_rounded,
          ),
        ];
      case MembershipTier.black:
        return const [
          Perk(
            title: 'Tous les avantages Gold',
            description: 'Le meilleur des niveaux précédents.',
            icon: Icons.workspace_premium_rounded,
          ),
          Perk(
            title: 'Concierge personnel',
            description: 'Un interlocuteur dédié, joignable 24/7.',
            icon: Icons.support_agent_rounded,
          ),
          Perk(
            title: 'Événements privés',
            description: 'Accès aux soirées et avant-premières LUXORA.',
            icon: Icons.theater_comedy_outlined,
          ),
          Perk(
            title: 'Limousine sur demande',
            description: 'Classe S disponible sans supplément.',
            icon: Icons.auto_awesome_outlined,
          ),
          Perk(
            title: 'Champagne à bord',
            description: 'Une bouteille offerte pour chaque grand trajet.',
            icon: Icons.celebration_outlined,
          ),
        ];
    }
  }

  @override
  List<PointsEvent> getPointsHistory(String userId) {
    final now = DateTime.now();
    return [
      PointsEvent(
        label: 'Trajet CDG → Le Bristol',
        points: 450,
        date: now.subtract(const Duration(days: 3)),
      ),
      PointsEvent(
        label: 'Trajet Tour Eiffel → Arc de Triomphe',
        points: 320,
        date: now.subtract(const Duration(days: 12)),
      ),
      PointsEvent(
        label: 'Réservation restaurant (concierge)',
        points: 150,
        date: now.subtract(const Duration(days: 18)),
      ),
      PointsEvent(
        label: 'Trajet Aéroport Orly → Ritz',
        points: 680,
        date: now.subtract(const Duration(days: 25)),
      ),
    ];
  }
}
