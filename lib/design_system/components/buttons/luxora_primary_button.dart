import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/colors/luxora_gradients.dart';
import '../../foundations/motion/luxora_durations.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Bouton principal LUXORA — or champagne, signature de l'app.
///
/// Règle : un seul bouton principal par écran.
/// Pour une action secondaire, utiliser `LuxoraGhostButton`.
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

  /// Si `true`, le bouton prend toute la largeur.
  final bool expanded;

  @override
  State<LuxoraPrimaryButton> createState() => _LuxoraPrimaryButtonState();
}

class _LuxoraPrimaryButtonState extends State<LuxoraPrimaryButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final isEnabled = widget.onPressed != null && !widget.isLoading;

    final content = AnimatedContainer(
      duration: LuxoraDurations.instant,
      height: 56,
      padding: const EdgeInsets.symmetric(horizontal: 24),
      decoration: BoxDecoration(
        gradient: isEnabled ? LuxoraGradients.champagne : null,
        color: isEnabled ? null : LuxoraColors.slate,
        borderRadius: LuxoraRadii.brMd,
        boxShadow: _pressed ? null : null,
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
                      color: isEnabled
                          ? LuxoraColors.obsidian
                          : LuxoraColors.textDisabled,
                    ),
                    const SizedBox(width: 10),
                  ],
                  Text(
                    widget.label,
                    style: LuxoraTextStyles.buttonLabel.copyWith(
                      color: isEnabled
                          ? LuxoraColors.obsidian
                          : LuxoraColors.textDisabled,
                    ),
                  ),
                ],
              ),
      ),
    );

    final button = GestureDetector(
      onTapDown: isEnabled ? (_) => setState(() => _pressed = true) : null,
      onTapUp: isEnabled ? (_) => setState(() => _pressed = false) : null,
      onTapCancel: isEnabled ? () => setState(() => _pressed = false) : null,
      onTap: isEnabled ? widget.onPressed : null,
      child: AnimatedScale(
        scale: _pressed ? 0.98 : 1.0,
        duration: LuxoraDurations.instant,
        child: content,
      ),
    );

    return widget.expanded ? SizedBox(width: double.infinity, child: button) : button;
  }
}
