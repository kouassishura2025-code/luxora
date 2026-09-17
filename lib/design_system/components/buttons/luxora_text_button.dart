import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/motion/luxora_durations.dart';
import '../../foundations/motion/luxora_haptics.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Bouton texte discret LUXORA.
class LuxoraTextButton extends StatefulWidget {
  const LuxoraTextButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.icon,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;

  @override
  State<LuxoraTextButton> createState() => _LuxoraTextButtonState();
}

class _LuxoraTextButtonState extends State<LuxoraTextButton> {
  bool _pressed = false;

  bool get _isEnabled => widget.onPressed != null;

  void _onTapDown(_) {
    if (!_isEnabled) return;
    setState(() => _pressed = true);
  }

  void _onTapUp(_) {
    if (!_isEnabled) return;
    setState(() => _pressed = false);
    LuxoraHaptics.selection();
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
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      decoration: BoxDecoration(
        color: _pressed
            ? LuxoraColors.champagne.withOpacity(0.08)
            : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (widget.icon != null) ...[
            Icon(
              widget.icon,
              size: 16,
              color: _isEnabled
                  ? LuxoraColors.champagne
                  : LuxoraColors.textDisabled,
            ),
            const SizedBox(width: 6),
          ],
          Text(
            widget.label,
            style: LuxoraTextStyles.labelMedium.copyWith(
              color: _isEnabled
                  ? LuxoraColors.champagne
                  : LuxoraColors.textDisabled,
            ),
          ),
        ],
      ),
    );

    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      behavior: HitTestBehavior.opaque,
      child: AnimatedScale(
        scale: _pressed ? 0.96 : 1.0,
        duration: LuxoraDurations.instant,
        curve: Curves.easeOut,
        child: content,
      ),
    );
  }
}
