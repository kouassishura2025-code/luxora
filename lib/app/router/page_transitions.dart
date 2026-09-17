import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../design_system/foundations/motion/luxora_curves.dart';
import '../../design_system/foundations/motion/luxora_durations.dart';

/// Transitions signature LUXORA entre les pages.
///
/// Toutes les navigations passent par ici pour une sensation cohérente.
abstract final class LuxoraPageTransitions {
  /// FadeThrough (fondu + léger slide vertical) — transition par défaut.
  static CustomTransitionPage<T> fadeThrough<T>({
    required LocalKey key,
    required Widget child,
    Duration duration = LuxoraDurations.relaxed,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: LuxoraCurves.ceremonial,
          reverseCurve: LuxoraCurves.exit,
        );

        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.03),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }

  /// Slide horizontal (depuis la droite) — pour les sous-pages.
  static CustomTransitionPage<T> slideRight<T>({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      transitionDuration: LuxoraDurations.relaxed,
      reverseTransitionDuration: LuxoraDurations.relaxed,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: LuxoraCurves.ceremonial,
          reverseCurve: LuxoraCurves.exit,
        );

        return SlideTransition(
          position: Tween<Offset>(
            begin: const Offset(1.0, 0),
            end: Offset.zero,
          ).animate(curved),
          child: FadeTransition(
            opacity: curved,
            child: child,
          ),
        );
      },
    );
  }

  /// Fade pur — pour les modales et bottom sheets.
  static CustomTransitionPage<T> fade<T>({
    required LocalKey key,
    required Widget child,
  }) {
    return CustomTransitionPage<T>(
      key: key,
      transitionDuration: LuxoraDurations.quick,
      reverseTransitionDuration: LuxoraDurations.quick,
      child: child,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        return FadeTransition(
          opacity: CurvedAnimation(
            parent: animation,
            curve: LuxoraCurves.enter,
          ),
          child: child,
        );
      },
    );
  }
}
