import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../loaders/luxora_shimmer.dart';

/// Skeleton d'une carte avec avatar + 2 lignes.
class LuxoraSkeletonCard extends StatelessWidget {
  const LuxoraSkeletonCard({
    super.key,
    this.padding = const EdgeInsets.all(16),
    this.hasAvatar = true,
  });

  final EdgeInsetsGeometry padding;
  final bool hasAvatar;

  @override
  Widget build(BuildContext context) {
    return LuxoraShimmer(
      child: Container(
        padding: padding,
        decoration: BoxDecoration(
          color: LuxoraColors.charcoal,
          borderRadius: LuxoraRadii.brLg,
        ),
        child: Row(
          children: [
            if (hasAvatar) ...[
              const LuxoraSkeletonBlock(
                width: 44,
                height: 44,
                borderRadius: LuxoraRadii.brMd,
              ),
              const SizedBox(width: 14),
            ],
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: const [
                  LuxoraSkeletonBlock(width: 160, height: 14),
                  SizedBox(height: 10),
                  LuxoraSkeletonBlock(width: 100, height: 12),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

/// Liste verticale de N cartes skeleton.
class LuxoraSkeletonList extends StatelessWidget {
  const LuxoraSkeletonList({
    super.key,
    this.count = 4,
    this.spacing = 10,
    this.padding = const EdgeInsets.all(24),
  });

  final int count;
  final double spacing;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Column(
        children: [
          for (var i = 0; i < count; i++) ...[
            const LuxoraSkeletonCard(),
            if (i != count - 1) SizedBox(height: spacing),
          ],
        ],
      ),
    );
  }
}

/// Skeleton d'une carte héro (grande, avec titre).
class LuxoraSkeletonHero extends StatelessWidget {
  const LuxoraSkeletonHero({
    super.key,
    this.height = 200,
  });

  final double height;

  @override
  Widget build(BuildContext context) {
    return LuxoraShimmer(
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: LuxoraColors.charcoal,
          borderRadius: LuxoraRadii.brXl,
        ),
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.end,
          children: const [
            LuxoraSkeletonBlock(width: 100, height: 10),
            SizedBox(height: 16),
            LuxoraSkeletonBlock(width: 220, height: 24),
            SizedBox(height: 10),
            LuxoraSkeletonBlock(width: 180, height: 12),
          ],
        ),
      ),
    );
  }
}

/// Skeleton horizontal (chips, filtres).
class LuxoraSkeletonChips extends StatelessWidget {
  const LuxoraSkeletonChips({
    super.key,
    this.count = 4,
    this.padding = const EdgeInsets.symmetric(horizontal: 24),
  });

  final int count;
  final EdgeInsetsGeometry padding;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: padding,
      child: Row(
        children: [
          for (var i = 0; i < count; i++) ...[
            const LuxoraShimmer(
              child: LuxoraSkeletonBlock(
                width: 80,
                height: 36,
                borderRadius: LuxoraRadii.brPill,
              ),
            ),
            if (i != count - 1) const SizedBox(width: 8),
          ],
        ],
      ),
    );
  }
}
