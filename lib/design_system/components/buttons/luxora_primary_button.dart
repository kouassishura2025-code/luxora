import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/colors/luxora_gradients.dart';
import '../../foundations/motion/luxora_durations.dart';
import '../../foundations/motion/luxora_haptics.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Bouton principal LUXORA — or champagne, signature de l'app.
///
/// ## Micro-interactions
/// - Scale 0.98 au tap
/// - Halo doré subtil au tap
/// - Haptic feedback (mobile uniquement)
class LuxoraPrimaryButton extends StatefulWidget {
  const LuxoraPrimaryButton({
    super.key,
    required this.label,
    required this.onPressed,
    this.isLoading = false,
    this.icon,
    this.expanded = true,
  });

  final String label;
  final VoidCallback? onPressed;
  final bool isLoading;
  final IconData? icon;
  final bool expanded;

  @override
  State<LuxoraPrimaryButton> createState() => _LuxoraPrimaryButtonState();
}

class _LuxoraPrimaryButtonState extends State<LuxoraPrimaryButton> {
  bool _pressed = false;

  bool get _isEnabled => widget.onPressed != null && !widget.isLoading;

  void _onTapDown(_) {
    if (!_isEnabled) return;
    setState(() => _pressed = true);
  }

  void _onTapUp(_) {
    if (!_isEnabled) return;
    setState(() => _pressed = false);
    LuxoraHaptics.medium();
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
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: _isEnabled ? LuxoraGradients.champagne : null,
        color: _isEnabled ? null : LuxoraColors.slate,
        borderRadius: LuxoraRadii.brMd,
        boxShadow: _pressed && _isEnabled
            ? [
                BoxShadow(
                  color: LuxoraColors.champagne.withOpacity(0.35),
                  blurRadius: 24,
                  spreadRadius: -2,
                ),
              ]
            : null,
      ),
      child: Center(
        child: widget.isLoading
            ? const SizedBox(
                height: 20,
                width: 20,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  color: LuxoraColors.obsidian,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (widget.icon != null) ...[
                    Icon(
                      widget.icon,
                      size: 20,
                      color: _isEnabled
                          ? LuxoraColors.obsidian
                          : LuxoraColors.textDisabled,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    widget.label,
                    style: LuxoraTextStyles.buttonLabel.copyWith(
                      color: _isEnabled
                          ? LuxoraColors.obsidian
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
