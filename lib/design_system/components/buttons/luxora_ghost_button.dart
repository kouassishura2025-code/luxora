import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/motion/luxora_durations.dart';
import '../../foundations/motion/luxora_haptics.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Bouton fantôme LUXORA — contour or, fond transparent.
class LuxoraGhostButton extends StatefulWidget {
  const LuxoraGhostButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool expanded;

  @override
  State<LuxoraGhostButton> createState() => _LuxoraGhostButtonState();
}

class _LuxoraGhostButtonState extends State<LuxoraGhostButton> {
  bool _pressed = false;

  bool get _isEnabled => widget.onPressed != null;

  void _onTapDown(_) {
    if (!_isEnabled) return;
    setState(() => _pressed = true);
  }

  void _onTapUp(_) {
    if (!_isEnabled) return;
    setState(() => _pressed = false);
    LuxoraHaptics.light();
    widget.onPressed?.call();
  }

  void _onTapCancel() {
    if (!_isEnabled) return;
    setState(() => _pressed = false);
  }

  @override
  Widget build(BuildContext context) {
    final content = AnimatedContainer(
      duration: LuxoraDurations.instant,
      height: 56,
      decoration: BoxDecoration(
        color: _pressed
            ? LuxoraColors.champagne.withOpacity(0.08)
            : Colors.transparent,
        borderRadius: LuxoraRadii.brMd,
        border: Border.all(
          color: _isEnabled
              ? LuxoraColors.champagne.withOpacity(_pressed ? 0.8 : 0.5)
              : LuxoraColors.divider,
          width: 1,
        ),
      ),
      child: Center(
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (widget.icon != null) ...[
              Icon(
                widget.icon,
                size: 18,
                color: _isEnabled
                    ? LuxoraColors.champagne
                    : LuxoraColors.textDisabled,
              ),
              const SizedBox(width: 10),
            ],
            Text(
              widget.label,
              style: LuxoraTextStyles.buttonLabel.copyWith(
                color: _isEnabled
                    ? LuxoraColors.champagne
                    : LuxoraColors.textDisabled,
              ),
            ),
          ],
        ),
      ),
    );

    final button = GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: LuxoraDurations.instant,
        curve: Curves.easeOut,
        child: content,
      ),
    );

    return widget.expanded
        ? SizedBox(width: double.infinity, child: button)
        : button;
  }
}
