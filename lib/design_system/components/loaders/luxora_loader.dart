import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';

/// Loader signature LUXORA — trois points dorés qui pulsent.
class LuxoraLoader extends StatefulWidget {
  const LuxoraLoader({
    super.key,
    this.size = 8,
    this.spacing = 8,
  });

  final double size;
  final double spacing;

  @override
  State<LuxoraLoader> createState() => _LuxoraLoaderState();
}

class _LuxoraLoaderState extends State<LuxoraLoader>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
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
        return Row(
          mainAxisSize: MainAxisSize.min,
          children: List.generate(3, (index) {
            final phase = (_controller.value + index * 0.2) % 1.0;
            final opacity = 0.3 + (1 - (phase - 0.5).abs() * 2) * 0.7;
            return Padding(
              padding: EdgeInsets.only(right: index < 2 ? widget.spacing : 0),
              child: Opacity(
                opacity: opacity.clamp(0.3, 1.0),
                child: Container(
                  width: widget.size,
                  height: widget.size,
                  decoration: const BoxDecoration(
                    color: LuxoraColors.champagne,
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
