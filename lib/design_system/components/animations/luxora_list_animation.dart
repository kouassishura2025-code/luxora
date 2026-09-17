import 'package:flutter/material.dart';

import '../../foundations/motion/luxora_curves.dart';
import '../../foundations/motion/luxora_durations.dart';

/// Wrapper d'entrée animée pour les items de liste.
class LuxoraListAnimation extends StatefulWidget {
  const LuxoraListAnimation({
    super.key,
    required this.child,
    required this.index,
    this.delayPerItem = const Duration(milliseconds: 60),
    this.initialDelay = Duration.zero,
    this.slideOffset = const Offset(0, 0.15),
  });

  final Widget child;
  final int index;
  final Duration delayPerItem;
  final Duration initialDelay;
  final Offset slideOffset;

  @override
  State<LuxoraListAnimation> createState() => _LuxoraListAnimationState();
}

class _LuxoraListAnimationState extends State<LuxoraListAnimation>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fade;
  late final Animation<Offset> _slide;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: LuxoraDurations.relaxed,
    );

    _fade = CurvedAnimation(
      parent: _controller,
      curve: LuxoraCurves.ceremonial,
    );

    _slide = Tween<Offset>(
      begin: widget.slideOffset,
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: LuxoraCurves.ceremonial,
      ),
    );

    final totalDelay = widget.initialDelay +
        Duration(
          milliseconds:
              widget.delayPerItem.inMilliseconds * widget.index,
        );

    Future<void>.delayed(totalDelay, () {
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
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return Opacity(
          opacity: _fade.value,
          child: Transform.translate(
            offset: Offset(
              _slide.value.dx * MediaQuery.sizeOf(context).width,
              _slide.value.dy * 100,
            ),
            child: child,
          ),
        );
      },
      child: widget.child,
    );
  }
}
