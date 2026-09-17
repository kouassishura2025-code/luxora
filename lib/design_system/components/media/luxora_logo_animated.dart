import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/motion/luxora_curves.dart';
import '../../foundations/motion/luxora_durations.dart';
import '../../foundations/typography/luxora_text_styles.dart';
import 'luxora_logo.dart';

/// Logo LUXORA avec animation d'apparition signature.
///
/// Fade + scale doux avec courbe `ceremonial`.
class LuxoraLogoAnimated extends StatefulWidget {
  const LuxoraLogoAnimated({
    super.key,
    this.size = 120,
    this.showWordmark = true,
    this.delay = Duration.zero,
    this.autoPlay = true,
  });

  final double size;
  final bool showWordmark;
  final Duration delay;
  final bool autoPlay;

  @override
  State<LuxoraLogoAnimated> createState() => _LuxoraLogoAnimatedState();
}

class _LuxoraLogoAnimatedState extends State<LuxoraLogoAnimated>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<double> _scale;
  late final Animation<double> _wordmarkFade;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: LuxoraDurations.ceremonial,
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.0, 0.6, curve: LuxoraCurves.ceremonial),
    );

    _scale = Tween<double>(begin: 0.85, end: 1.0).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 0.7, curve: LuxoraCurves.ceremonial),
      ),
    );

    _wordmarkFade = CurvedAnimation(
      parent: _controller,
      curve: const Interval(0.4, 1.0, curve: LuxoraCurves.ceremonial),
    );

    if (widget.autoPlay) {
      Future<void>.delayed(widget.delay, () {
        if (mounted) _controller.forward();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, _) {
        return Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Opacity(
              opacity: _fade.value,
              child: Transform.scale(
                scale: _scale.value,
                child: LuxoraLogo(size: widget.size),
              ),
            ),
            if (widget.showWordmark) ...[
              SizedBox(height: widget.size * 0.18),
              Opacity(
                opacity: _wordmarkFade.value,
                child: Column(
                  children: [
                    Text(
                      'LUXORA',
                      style: LuxoraTextStyles.displayLarge.copyWith(
                        fontSize: widget.size * 0.28,
                        letterSpacing: widget.size * 0.06,
                        color: LuxoraColors.champagne,
                      ),
                    ),
                    SizedBox(height: widget.size * 0.08),
                    Text(
                      'CHAUFFEUR PRIVÉ',
                      style: LuxoraTextStyles.overline.copyWith(
                        fontSize: widget.size * 0.07,
                        letterSpacing: widget.size * 0.03,
                        color: LuxoraColors.textSecondary,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }
}
