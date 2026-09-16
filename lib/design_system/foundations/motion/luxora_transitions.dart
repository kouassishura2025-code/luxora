import 'package:flutter/material.dart';

import 'luxora_curves.dart';
import 'luxora_durations.dart';

abstract final class LuxoraTransitions {
  static PageRouteBuilder<T> fadeThrough<T>({
    required Widget page,
    Duration duration = LuxoraDurations.relaxed,
  }) {
    return PageRouteBuilder<T>(
      transitionDuration: duration,
      reverseTransitionDuration: duration,
      pageBuilder: (_, __, ___) => page,
      transitionsBuilder: (_, animation, __, child) {
        final curved = CurvedAnimation(
          parent: animation,
          curve: LuxoraCurves.ceremonial,
          reverseCurve: LuxoraCurves.exit,
        );
        return FadeTransition(
          opacity: curved,
          child: SlideTransition(
            position: Tween<Offset>(
              begin: const Offset(0, 0.04),
              end: Offset.zero,
            ).animate(curved),
            child: child,
          ),
        );
      },
    );
  }
}
