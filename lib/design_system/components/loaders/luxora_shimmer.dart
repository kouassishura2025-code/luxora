import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';

/// Effet shimmer LUXORA — balayage doré subtil.
class LuxoraShimmer extends StatefulWidget {
  const LuxoraShimmer({
    super.key,
    this.width,
    this.height = 16,
    this.borderRadius = LuxoraRadii.brSm,
  });

  final double? width;
  final double height;
  final BorderRadius borderRadius;

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
    return AnimatedBuilder(
      animation: _controller,
      builder: (_, __) {
        return Container(
          width: widget.width,
          height: widget.height,
          decoration: BoxDecoration(
            borderRadius: widget.borderRadius,
            gradient: LinearGradient(
              begin: Alignment(-1.5 + _controller.value * 3, 0),
              end: Alignment(-0.5 + _controller.value * 3, 0),
              colors: [
                LuxoraColors.charcoal,
                LuxoraColors.champagne.withOpacity(0.08),
                LuxoraColors.charcoal,
              ],
              stops: const [0.0, 0.5, 1.0],
            ),
          ),
        );
      },
    );
  }
}
