import 'package:flutter/material.dart';

/// Une slide d'onboarding LUXORA.
@immutable
class OnboardingSlide {
  const OnboardingSlide({
    required this.overline,
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String overline;
  final String title;
  final String subtitle;
  final IconData icon;
}
