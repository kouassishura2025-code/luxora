import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';

/// Effet shimmer doré réutilisable.
///
/// Enveloppe n'importe quel widget et fait balayer un dégradé
/// or subtil de gauche à droite.
class LuxoraShimmer extends StatefulWidget {
  const LuxoraShimmer({
    super.key,
    required this.child,
    this.enabled = true,
  });

  final Widget child;
  final bool enabled;

  @override
  State<LuxoraShimmer> createState() => _LuxoraShimmerState();
}

class _LuxoraShimmerState extends State<LuxoraShimmer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1600),
    )..repeat();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    if (!widget.enabled) return widget.child;

    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ShaderMask(
          blendMode: BlendMode.srcATop,
          shaderCallback: (bounds) {
            final slide = _controller.value * 2 - 1;
            return LinearGradient(
              begin: Alignment(-1 + slide, 0),
              end: Alignment(0 + slide, 0),
              colors: [
                Colors.transparent,
                LuxoraColors.champagne.withOpacity(0.08),
                Colors.transparent,
              ],
              stops: const [0.0, 0.5, 1.0],
            ).createShader(bounds);
          },
          child: child,
        );
      },
      child: widget.child,
    );
  }
}

/// Bloc skeleton simple — rectangle arrondi charcoal.
class LuxoraSkeletonBlock extends StatelessWidget {
  const LuxoraSkeletonBlock({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = LuxoraRadii.brSm,
  });

  final double? width;
  final double height;
  final BorderRadius borderRadius;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color: LuxoraColors.charcoal,
        borderRadius: borderRadius,
      ),
    );
  }
}
