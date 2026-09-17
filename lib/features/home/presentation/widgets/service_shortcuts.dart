import 'package:flutter/material.dart';

import '../../../../design_system/components/animations/luxora_list_animation.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/motion/luxora_durations.dart';
import '../../../../design_system/foundations/motion/luxora_haptics.dart';
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
          Expanded(
            child: LuxoraListAnimation(
              index: i,
              child: _ShortcutTile(shortcut: shortcuts[i]),
            ),
          ),
          if (i != shortcuts.length - 1) const SizedBox(width: 10),
        ],
      ],
    );
  }
}

class _ShortcutTile extends StatefulWidget {
  const _ShortcutTile({required this.shortcut});

  final ServiceShortcut shortcut;

  @override
  State<_ShortcutTile> createState() => _ShortcutTileState();
}

class _ShortcutTileState extends State<_ShortcutTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        LuxoraHaptics.light();
        widget.shortcut.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? 0.95 : 1.0,
        duration: LuxoraDurations.instant,
        child: AnimatedContainer(
          duration: LuxoraDurations.instant,
          padding: const EdgeInsets.symmetric(vertical: 18),
          decoration: BoxDecoration(
            color: _pressed
                ? LuxoraColors.graphite
                : LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brLg,
            boxShadow: _pressed
                ? [
                    BoxShadow(
                      color: LuxoraColors.champagne.withOpacity(0.15),
                      blurRadius: 12,
                      spreadRadius: -2,
                    ),
                  ]
                : null,
          ),
          child: Column(
            children: [
              Icon(
                widget.shortcut.icon,
                size: 22,
                color: LuxoraColors.champagne,
              ),
              const SizedBox(height: 10),
              Text(
                widget.shortcut.label,
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
