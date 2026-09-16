import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/membership.dart';

/// Carte signature du membre (gradient selon tier).
class MembershipCard extends StatelessWidget {
  const MembershipCard({
    super.key,
    required this.membership,
    required this.memberName,
  });

  final Membership membership;
  final String memberName;

  @override
  Widget build(BuildContext context) {
    final tier = membership.tier;
    final next = tier.next;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: tier.gradient,
        ),
        borderRadius: LuxoraRadii.brXl,
        border: Border.all(
          color: tier.accent.withOpacity(0.3),
          width: 0.8,
        ),
      ),
      child: Stack(
        children: [
          // ─── Icône filigrane ──────────────────────
          Positioned(
            right: -20,
            top: -20,
            child: Icon(
              tier.icon,
              size: 140,
              color: tier.accent.withOpacity(0.06),
            ),
          ),

          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ─── Tier label ───────────────────────
              Row(
                children: [
                  Icon(tier.icon, size: 16, color: tier.accent),
                  const SizedBox(width: 8),
                  Text(
                    'MEMBRE ${tier.label.toUpperCase()}',
                    style: LuxoraTextStyles.overline.copyWith(
                      fontSize: 10,
                      letterSpacing: 2.4,
                      color: tier.accent,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 20),

              // ─── Nom ──────────────────────────────
              Text(
                memberName,
                style: LuxoraTextStyles.titleLarge.copyWith(fontSize: 22),
              ),

              const SizedBox(height: 4),

              // ─── Depuis ───────────────────────────
              Text(
                'Membre depuis ${_formatMonth(membership.memberSince)}',
                style: LuxoraTextStyles.bodySmall.copyWith(fontSize: 12),
              ),

              const SizedBox(height: 28),

              // ─── Points ───────────────────────────
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Text(
                    '${membership.points}',
                    style: LuxoraTextStyles.displayMedium.copyWith(
                      fontSize: 32,
                      color: tier.accent,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Padding(
                    padding: const EdgeInsets.only(bottom: 6),
                    child: Text(
                      next == null
                          ? 'pts'
                          : '/ ${next.threshold} pts',
                      style: LuxoraTextStyles.bodySmall.copyWith(
                        fontSize: 12,
                        color: LuxoraColors.textTertiary,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 12),

              // ─── Progression ──────────────────────
              ClipRRect(
                borderRadius: LuxoraRadii.brPill,
                child: Stack(
                  children: [
                    Container(
                      height: 4,
                      color: LuxoraColors.obsidian.withOpacity(0.5),
                    ),
                    FractionallySizedBox(
                      widthFactor: membership.progress,
                      child: Container(
                        height: 4,
                        decoration: BoxDecoration(
                          color: tier.accent,
                          borderRadius: LuxoraRadii.brPill,
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 10),

              // ─── Prochain tier ────────────────────
              Text(
                next == null
                    ? 'Vous êtes au sommet.'
                    : 'Prochain : ${next.label} · '
                        '${membership.pointsToNext} pts restants',
                style: LuxoraTextStyles.caption.copyWith(
                  fontSize: 10,
                  color: LuxoraColors.textSecondary,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _formatMonth(DateTime date) {
    const months = [
      'Janvier',
      'Février',
      'Mars',
      'Avril',
      'Mai',
      'Juin',
      'Juillet',
      'Août',
      'Septembre',
      'Octobre',
      'Novembre',
      'Décembre',
    ];
    return '${months[date.month - 1]} ${date.year}';
  }
}
