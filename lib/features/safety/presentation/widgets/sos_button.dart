import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Bouton SOS LUXORA — à maintenir 3 secondes.
class SosButton extends StatefulWidget {
  const SosButton({
    super.key,
    required this.onTriggered,
    this.holdDuration = const Duration(seconds: 3),
  });

  final VoidCallback onTriggered;
  final Duration holdDuration;

  @override
  State<SosButton> createState() => _SosButtonState();
}

class _SosButtonState extends State<SosButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  Timer? _timer;
  bool _isHolding = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: widget.holdDuration,
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed) {
        _onComplete();
      }
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  void _startHold() {
    setState(() => _isHolding = true);
    HapticFeedback.mediumImpact();
    _controller.forward(from: 0);
  }

  void _cancelHold() {
    if (!_isHolding) return;
    setState(() => _isHolding = false);
    _controller.reverse();
  }

  void _onComplete() {
    HapticFeedback.heavyImpact();
    setState(() => _isHolding = false);
    widget.onTriggered();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => _startHold(),
      onTapUp: (_) => _cancelHold(),
      onTapCancel: _cancelHold,
      child: AnimatedBuilder(
        animation: _controller,
        builder: (context, _) {
          final progress = _controller.value;
          return SizedBox(
            width: 200,
            height: 200,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // ─── Cercle de progression ───────────
                SizedBox(
                  width: 200,
                  height: 200,
                  child: CircularProgressIndicator(
                    value: progress,
                    strokeWidth: 3,
                    backgroundColor:
                        LuxoraColors.champagne.withOpacity(0.15),
                    valueColor: const AlwaysStoppedAnimation(
                      LuxoraColors.champagne,
                    ),
                  ),
                ),

                // ─── Cercle intérieur ────────────────
                AnimatedContainer(
                  duration: const Duration(milliseconds: 200),
                  width: _isHolding ? 160 : 150,
                  height: _isHolding ? 160 : 150,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: _isHolding
                        ? LuxoraColors.error.withOpacity(0.15)
                        : LuxoraColors.charcoal,
                    border: Border.all(
                      color: _isHolding
                          ? LuxoraColors.error
                          : LuxoraColors.champagne,
                      width: _isHolding ? 2 : 1,
                    ),
                    boxShadow: _isHolding
                        ? [
                            BoxShadow(
                              color: LuxoraColors.error.withOpacity(0.3),
                              blurRadius: 32,
                              spreadRadius: 4,
                            ),
                          ]
                        : [
                            BoxShadow(
                              color:
                                  LuxoraColors.champagne.withOpacity(0.15),
                              blurRadius: 24,
                              spreadRadius: 2,
                            ),
                          ],
                  ),
                  child: Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.priority_high_rounded,
                          size: 32,
                          color: _isHolding
                              ? LuxoraColors.error
                              : LuxoraColors.champagne,
                        ),
                        const SizedBox(height: 8),
                        Text(
                          'SOS',
                          style: LuxoraTextStyles.displayMedium.copyWith(
                            fontSize: 24,
                            letterSpacing: 4,
                            color: _isHolding
                                ? LuxoraColors.error
                                : LuxoraColors.champagne,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
