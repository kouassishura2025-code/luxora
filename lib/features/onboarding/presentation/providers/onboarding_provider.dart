import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/entities/onboarding_slide.dart';

/// Liste des slides LUXORA.
final onboardingSlidesProvider = Provider<List<OnboardingSlide>>((ref) {
  return const [
    OnboardingSlide(
      overline: 'L\'ART DU DÉPLACEMENT',
      title: 'Un chauffeur privé,\nà chaque instant.',
      subtitle:
          'Une flotte d\'exception. Des chauffeurs formés à l\'excellence. '
          'Disponible en quelques secondes.',
      icon: Icons.directions_car_filled_outlined,
    ),
    OnboardingSlide(
      overline: 'CONCIERGERIE',
      title: 'Un concierge dédié,\n24 heures sur 24.',
      subtitle:
          'Réservations, demandes spéciales, attentions personnelles. '
          'Une équipe à votre écoute, jour et nuit.',
      icon: Icons.support_agent_outlined,
    ),
    OnboardingSlide(
      overline: 'L\'EXCEPTION',
      title: 'Votre temps est\nnotre priorité.',
      subtitle:
          'Chaque détail est anticipé. Chaque trajet est une parenthèse. '
          'Bienvenue dans l\'expérience LUXORA.',
      icon: Icons.auto_awesome_outlined,
    ),
  ];
});

/// Index de la slide courante.
final onboardingIndexProvider = StateProvider<int>((ref) => 0);
