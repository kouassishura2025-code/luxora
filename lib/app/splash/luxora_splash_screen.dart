import 'package:flutter/material.dart';

import '../../design_system/components/media/luxora_logo_animated.dart';
import '../../design_system/foundations/colors/luxora_colors.dart';
import '../../design_system/foundations/motion/luxora_curves.dart';
import '../../design_system/foundations/motion/luxora_durations.dart';
import '../../design_system/foundations/typography/luxora_text_styles.dart';

/// Splash screen LUXORA — animation signature d'ouverture.
class LuxoraSplashScreen extends StatefulWidget {
  const LuxoraSplashScreen({super.key});

  @override
  State<LuxoraSplashScreen> createState() => _LuxoraSplashScreenState();
}

class _LuxoraSplashScreenState extends State<LuxoraSplashScreen>
    with SingleTickerProviderStateMixin {
  late final AnimationController _haloController;

  @override
  void initState() {
    super.initState();
    _haloController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2400),
    )..repeat(reverse: true);
  }

  @override
  void dispose() {
    _haloController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: LuxoraColors.obsidian,
      child: Stack(
        children: [
          // ─── Halo doré en arrière-plan ────────────
          Center(
            child: AnimatedBuilder(
              animation: _haloController,
              builder: (context, _) {
                final scale = 0.9 + _haloController.value * 0.15;
                final opacity = 0.06 + _haloController.value * 0.04;
                return Transform.scale(
                  scale: scale,
                  child: Container(
                    width: 400,
                    height: 400,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: RadialGradient(
                        colors: [
                          LuxoraColors.champagne.withOpacity(opacity),
                          Colors.transparent,
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          // ─── Logo animé ───────────────────────────
          const Center(
            child: LuxoraLogoAnimated(
              size: 140,
              showWordmark: true,
            ),
          ),

          // ─── Version en bas ───────────────────────
          Positioned(
            left: 0,
            right: 0,
            bottom: 48,
            child: _FooterFade(),
          ),
        ],
      ),
    );
  }
}

/// Fade du footer (apparition tardive).
class _FooterFade extends StatefulWidget {
  @override
  State<_FooterFade> createState() => _FooterFadeState();
}

class _FooterFadeState extends State<_FooterFade>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: LuxoraDurations.relaxed,
    );
    Future<void>.delayed(const Duration(milliseconds: 1200), () {
      if (mounted) _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return FadeTransition(
      opacity: CurvedAnimation(
        parent: _controller,
        curve: LuxoraCurves.ceremonial,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'v0.1.0',
            style: LuxoraTextStyles.caption.copyWith(
              fontSize: 10,
              letterSpacing: 2,
            ),
          ),
        ],
      ),
    );
  }
}
