import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Indicateur "concierge en train d'écrire".
class TypingIndicator extends StatefulWidget {
  const TypingIndicator({super.key});

  @override
  State<TypingIndicator> createState() => _TypingIndicatorState();
}

class _TypingIndicatorState extends State<TypingIndicator>
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
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 6),
      child: Row(
        children: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: LuxoraColors.charcoal,
              border: Border.all(
                color: LuxoraColors.champagne.withOpacity(0.4),
                width: 0.8,
              ),
            ),
            child: const Icon(
              Icons.support_agent_rounded,
              size: 14,
              color: LuxoraColors.champagne,
            ),
          ),
          const SizedBox(width: 10),
          Container(
            padding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
            decoration: BoxDecoration(
              color: LuxoraColors.charcoal,
              borderRadius: BorderRadius.only(
                topLeft: LuxoraRadii.lg,
                topRight: LuxoraRadii.lg,
                bottomRight: LuxoraRadii.lg,
                bottomLeft: LuxoraRadii.xs,
              ),
              border: Border.all(
                color: LuxoraColors.divider,
                width: 0.5,
              ),
            ),
            child: AnimatedBuilder(
              animation: _controller,
              builder: (_, __) {
                return Row(
                  mainAxisSize: MainAxisSize.min,
                  children: List.generate(3, (i) {
                    final phase =
                        (_controller.value + i * 0.2) % 1.0;
                    final opacity =
                        0.3 + (1 - (phase - 0.5).abs() * 2) * 0.7;
                    return Padding(
                      padding: EdgeInsets.only(
                        right: i < 2 ? 5 : 0,
                      ),
                      child: Opacity(
                        opacity: opacity.clamp(0.3, 1.0),
                        child: Container(
                          width: 6,
                          height: 6,
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
            ),
          ),
          const SizedBox(width: 8),
          Text(
            'écrit…',
            style: LuxoraTextStyles.caption.copyWith(
              fontSize: 10,
              fontStyle: FontStyle.italic,
            ),
          ),
        ],
      ),
    );
  }
}
