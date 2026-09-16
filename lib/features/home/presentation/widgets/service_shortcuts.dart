import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Un raccourci service.
class ServiceShortcut {
  const ServiceShortcut({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
}

/// Grille de 4 raccourcis services LUXORA.
class ServiceShortcuts extends StatelessWidget {
  const ServiceShortcuts({
    super.key,
    required this.shortcuts,
  });

  final List<ServiceShortcut> shortcuts;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        for (var i = 0; i < shortcuts.length; i++) ...[
          Expanded(child: _ShortcutTile(shortcut: shortcuts[i])),
          if (i != shortcuts.length - 1) const SizedBox(width: 10),
        ],
      ],
    );
  }
}

class _ShortcutTile extends StatelessWidget {
  const _ShortcutTile({required this.shortcut});

  final ServiceShortcut shortcut;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: shortcut.onTap,
        borderRadius: LuxoraRadii.brLg,
        splashColor: LuxoraColors.champagne.withOpacity(0.08),
        highlightColor: LuxoraColors.champagne.withOpacity(0.04),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brLg,
          ),
          child: Column(
            children: [
              Icon(
                shortcut.icon,
                size: 22,
                color: LuxoraColors.champagne,
              ),
              const SizedBox(height: 10),
              Text(
                shortcut.label,
                style: LuxoraTextStyles.labelMedium.copyWith(
                  color: LuxoraColors.textSecondary,
                  fontSize: 12,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
