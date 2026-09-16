import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

/// Niveau d'adhésion LUXORA.
enum MembershipTier {
  silver(
    label: 'Silver',
    icon: Icons.workspace_premium_outlined,
    threshold: 0,
    nextThreshold: 5000,
    gradient: [Color(0xFF2A2A2D), Color(0xFF1A1A1D)],
    accent: Color(0xFFC0C0C0),
  ),
  gold(
    label: 'Gold',
    icon: Icons.workspace_premium_rounded,
    threshold: 5000,
    nextThreshold: 15000,
    gradient: [Color(0xFF4A3A1A), Color(0xFF2A1A0A)],
    accent: Color(0xFFC9A24B),
  ),
  black(
    label: 'Black',
    icon: Icons.diamond_rounded,
    threshold: 15000,
    nextThreshold: 999999,
    gradient: [Color(0xFF000000), Color(0xFF1A1A1D)],
    accent: Color(0xFFC9A24B),
  );

  const MembershipTier({
    required this.label,
    required this.icon,
    required this.threshold,
    required this.nextThreshold,
    required this.gradient,
    required this.accent,
  });

  final String label;
  final IconData icon;
  final int threshold;
  final int nextThreshold;
  final List<Color> gradient;
  final Color accent;

  MembershipTier? get next {
    final idx = MembershipTier.values.indexOf(this);
    if (idx >= MembershipTier.values.length - 1) return null;
    return MembershipTier.values[idx + 1];
  }
}

/// Adhésion d'un utilisateur.
class Membership extends Equatable {
  const Membership({
    required this.userId,
    required this.tier,
    required this.points,
    required this.memberSince,
  });

  final String userId;
  final MembershipTier tier;
  final int points;
  final DateTime memberSince;

  /// Progression vers le tier suivant (0.0 - 1.0).
  double get progress {
    final next = tier.next;
    if (next == null) return 1.0;
    final range = next.threshold - tier.threshold;
    if (range == 0) return 1.0;
    return ((points - tier.threshold) / range).clamp(0.0, 1.0);
  }

  int get pointsToNext {
    final next = tier.next;
    if (next == null) return 0;
    return (next.threshold - points).clamp(0, 999999);
  }

  @override
  List<Object?> get props => [userId, tier, points, memberSince];
}

/// Un avantage (perk).
class Perk extends Equatable {
  const Perk({
    required this.title,
    required this.description,
    required this.icon,
  });

  final String title;
  final String description;
  final IconData icon;

  @override
  List<Object?> get props => [title];
}

/// Un événement de l'historique des points.
class PointsEvent extends Equatable {
  const PointsEvent({
    required this.label,
    required this.points,
    required this.date,
  });

  final String label;
  final int points;
  final DateTime date;

  @override
  List<Object?> get props => [label, date];
}
