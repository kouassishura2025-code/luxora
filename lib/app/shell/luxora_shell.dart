import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../design_system/components/navigation/luxora_bottom_nav.dart';

/// Coquille principale — contient la bottom nav et le contenu de l'onglet.
class LuxoraShell extends StatelessWidget {
  const LuxoraShell({
    super.key,
    required this.currentIndex,
    required this.child,
  });

  final int currentIndex;
  final Widget child;

  static const _items = [
    LuxoraNavItem(
      icon: Icons.home_outlined,
      activeIcon: Icons.home_rounded,
      label: 'Accueil',
    ),
    LuxoraNavItem(
      icon: Icons.receipt_long_outlined,
      activeIcon: Icons.receipt_long_rounded,
      label: 'Réservations',
    ),
    LuxoraNavItem(
      icon: Icons.support_agent_outlined,
      activeIcon: Icons.support_agent_rounded,
      label: 'Concierge',
    ),
    LuxoraNavItem(
      icon: Icons.person_outline_rounded,
      activeIcon: Icons.person_rounded,
      label: 'Profil',
    ),
  ];

  static const _routes = [
    '/',
    '/bookings',
    '/concierge',
    '/profile',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: child,
      bottomNavigationBar: LuxoraBottomNav(
        items: _items,
        currentIndex: currentIndex,
        onTap: (index) {
          if (index == currentIndex) return;
          context.go(_routes[index]);
        },
      ),
    );
  }
}
