import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/motion/luxora_durations.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/message.dart';

/// Bulle de message signature LUXORA.
class MessageBubble extends StatelessWidget {
  const MessageBubble({super.key, required this.message});

  final ConciergeMessage message;

  @override
  Widget build(BuildContext context) {
    final isClient = message.author == MessageAuthor.client;

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment:
            isClient ? MainAxisAlignment.end : MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (!isClient) const _ConciergeAvatar(),

          if (!isClient) const SizedBox(width: 10),

          Flexible(
            child: Column(
              crossAxisAlignment: isClient
                  ? CrossAxisAlignment.end
                  : CrossAxisAlignment.start,
              children: [
                AnimatedContainer(
                  duration: LuxoraDurations.quick,
                  constraints: BoxConstraints(
                    maxWidth:
                        MediaQuery.sizeOf(context).width * 0.72,
                  ),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  decoration: BoxDecoration(
                    color: isClient
                        ? LuxoraColors.champagne
                        : LuxoraColors.charcoal,
                    borderRadius: BorderRadius.only(
                      topLeft: LuxoraRadii.lg,
                      topRight: LuxoraRadii.lg,
                      bottomLeft: isClient
                          ? LuxoraRadii.lg
                          : LuxoraRadii.xs,
                      bottomRight: isClient
                          ? LuxoraRadii.xs
                          : LuxoraRadii.lg,
                    ),
                    border: !isClient
                        ? Border.all(
                            color: LuxoraColors.divider,
                            width: 0.5,
                          )
                        : null,
                  ),
                  child: Text(
                    message.content,
                    style: LuxoraTextStyles.bodyMedium.copyWith(
                      color: isClient
                          ? LuxoraColors.obsidian
                          : LuxoraColors.textPrimary,
                      fontSize: 14,
                      height: 1.4,
                    ),
                  ),
                ),
                const SizedBox(height: 4),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 6),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        _formatTime(message.sentAt),
                        style: LuxoraTextStyles.caption.copyWith(
                          fontSize: 9,
                          color: LuxoraColors.textTertiary,
                        ),
                      ),
                      if (isClient) ...[
                        const SizedBox(width: 4),
                        Icon(
                          message.isPending
                              ? Icons.schedule_rounded
                              : Icons.done_all_rounded,
                          size: 11,
                          color: message.isPending
                              ? LuxoraColors.textTertiary
                              : LuxoraColors.champagne,
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  String _formatTime(DateTime dt) {
    final h = dt.hour.toString().padLeft(2, '0');
    final m = dt.minute.toString().padLeft(2, '0');
    return '$h:$m';
  }
}

/// Avatar doré du concierge.
class _ConciergeAvatar extends StatelessWidget {
  const _ConciergeAvatar();

  @override
  Widget build(BuildContext context) {
    return Container(
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
    );
  }
}
