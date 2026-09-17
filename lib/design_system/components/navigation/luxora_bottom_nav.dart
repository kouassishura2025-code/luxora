import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/motion/luxora_durations.dart';
import '../../foundations/motion/luxora_haptics.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Un item de la bottom nav.
class LuxoraNavItem {
  const LuxoraNavItem({
    required this.icon,
    required this.activeIcon,
    required this.label,
  });

  final IconData icon;
  final IconData activeIcon;
  final String label;
}

/// Barre de navigation inférieure LUXORA.
class LuxoraBottomNav extends StatelessWidget {
  const LuxoraBottomNav({
    super.key,
    required this.items,
    required this.currentIndex,
    required this.onTap,
  });

  final List<LuxoraNavItem> items;
  final int currentIndex;
  final ValueChanged<int> onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        color: LuxoraColors.obsidian,
        border: Border(
          top: BorderSide(color: LuxoraColors.divider, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Row(
            children: [
              for (var i = 0; i < items.length; i++)
                Expanded(
                  child: _NavTile(
                    item: items[i],
                    isActive: i == currentIndex,
                    onTap: () {
                      if (i == currentIndex) return;
                      LuxoraHaptics.selection();
                      onTap(i);
                    },
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _NavTile extends StatefulWidget {
  const _NavTile({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  final LuxoraNavItem item;
  final bool isActive;
  final VoidCallback onTap;

  @override
  State<_NavTile> createState() => _NavTileState();
}

class _NavTileState extends State<_NavTile> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        widget.onTap();
      },
      onTapCancel: () => setState(() => _pressed = false),
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? 0.92 : 1.0,
        duration: LuxoraDurations.instant,
        curve: Curves.easeOut,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 8),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(
                widget.isActive ? widget.item.activeIcon : widget.item.icon,
                size: 22,
                color: widget.isActive
                    ? LuxoraColors.champagne
                    : LuxoraColors.textTertiary,
              ),
              const SizedBox(height: 6),
              Text(
                widget.item.label,
                style: LuxoraTextStyles.caption.copyWith(
                  fontSize: 10,
                  letterSpacing: 0.4,
                  color: widget.isActive
                      ? LuxoraColors.champagne
                      : LuxoraColors.textTertiary,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
