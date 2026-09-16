import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/motion/luxora_durations.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Bandeau concierge 24/7 avec point vert pulsant.
class ConciergeBanner extends StatefulWidget {
  const ConciergeBanner({
    super.key,
    required this.message,
    required this.onTap,
  });

  final String message;
  final VoidCallback onTap;

  @override
  State<ConciergeBanner> createState() => _ConciergeBannerState();
}

class _ConciergeBannerState extends State<ConciergeBanner>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: LuxoraDurations.breathe,
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: widget.onTap,
        borderRadius: LuxoraRadii.brLg,
        splashColor: LuxoraColors.champagne.withOpacity(0.08),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
          decoration: BoxDecoration(
            color: LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brLg,
            border: Border.all(
              color: LuxoraColors.dividerGold,
              width: 0.5,
            ),
          ),
          child: Row(
            children: [
              // ─── Point vert pulsant ─────────────────────
              AnimatedBuilder(
                animation: _controller,
                builder: (_, __) {
                  return Container(
                    width: 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: LuxoraColors.success,
                      shape: BoxShape.circle,
                      boxShadow: [
                        BoxShadow(
                          color: LuxoraColors.success.withOpacity(
                            0.3 + _controller.value * 0.4,
                          ),
                          blurRadius: 8 + _controller.value * 6,
                          spreadRadius: _controller.value * 2,
                        ),
                      ],
                    ),
                  );
                },
              ),

              const SizedBox(width: 14),

              // ─── Texte ──────────────────────────────────
              Expanded(
                child: Text(
                  widget.message,
                  style: LuxoraTextStyles.bodyMedium.copyWith(
                    color: LuxoraColors.textPrimary,
                  ),
                ),
              ),

              // ─── Flèche ─────────────────────────────────
              Icon(
                Icons.arrow_forward_ios_rounded,
                size: 14,
                color: LuxoraColors.champagne,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
