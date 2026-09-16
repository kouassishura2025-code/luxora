import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../providers/chat_provider.dart';
import '../widgets/chat_input.dart';
import '../widgets/message_bubble.dart';
import '../widgets/quick_replies.dart';
import '../widgets/typing_indicator.dart';

class ConciergeChatPage extends ConsumerStatefulWidget {
  const ConciergeChatPage({super.key});

  @override
  ConsumerState<ConciergeChatPage> createState() =>
      _ConciergeChatPageState();
}

class _ConciergeChatPageState extends ConsumerState<ConciergeChatPage> {
  final _scrollController = ScrollController();

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToBottom() {
    if (!_scrollController.hasClients) return;
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 320),
        curve: Curves.easeOutCubic,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    final messagesAsync = ref.watch(messagesProvider);
    final typingAsync = ref.watch(conciergeTypingProvider);
    final isTyping = typingAsync.valueOrNull ?? false;

    // Auto-scroll à chaque changement.
    ref.listen(messagesProvider, (_, __) => _scrollToBottom());
    ref.listen(conciergeTypingProvider, (_, __) => _scrollToBottom());

    return LuxoraScaffold(
      applyPadding: false,
      body: Column(
        children: [
          // ─── Header signature ─────────────────────
          const _ChatHeader(),

          // ─── Messages ─────────────────────────────
          Expanded(
            child: messagesAsync.when(
              data: (messages) {
                return ListView.builder(
                  controller: _scrollController,
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.symmetric(
                    horizontal: 16,
                    vertical: 12,
                  ),
                  itemCount: messages.length + (isTyping ? 1 : 0),
                  itemBuilder: (context, index) {
                    if (index == messages.length && isTyping) {
                      return const TypingIndicator();
                    }
                    return MessageBubble(message: messages[index]);
                  },
                );
              },
              loading: () => const Center(
                child: SizedBox(
                  width: 20,
                  height: 20,
                  child: CircularProgressIndicator(
                    strokeWidth: 2,
                    color: LuxoraColors.champagne,
                  ),
                ),
              ),
              error: (_, __) => const Center(
                child: Text(
                  'Erreur de chargement',
                  style: TextStyle(color: LuxoraColors.textSecondary),
                ),
              ),
            ),
          ),

          // ─── Réponses rapides ─────────────────────
          Padding(
            padding: const EdgeInsets.only(bottom: 8),
            child: QuickReplies(
              replies: kQuickReplies,
              onTap: (reply) {
                ref.read(sendMessageProvider)(reply.message);
              },
            ),
          ),

          // ─── Input ────────────────────────────────
          ChatInput(
            onSend: (text) {
              ref.read(sendMessageProvider)(text);
            },
          ),
        ],
      ),
    );
  }
}

/// En-tête du chat avec statut "en ligne".
class _ChatHeader extends StatelessWidget {
  const _ChatHeader();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      decoration: const BoxDecoration(
        color: LuxoraColors.obsidian,
        border: Border(
          bottom: BorderSide(color: LuxoraColors.divider, width: 0.5),
        ),
      ),
      child: SafeArea(
        bottom: false,
        child: Row(
          children: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back_ios_new_rounded,
                size: 18,
                color: LuxoraColors.textPrimary,
              ),
              onPressed: () => Navigator.of(context).maybePop(),
            ),
            const SizedBox(width: 4),
            Container(
              width: 44,
              height: 44,
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
                size: 22,
                color: LuxoraColors.champagne,
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Concierge LUXORA',
                    style: LuxoraTextStyles.titleMedium.copyWith(
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Row(
                    children: [
                      Container(
                        width: 6,
                        height: 6,
                        decoration: const BoxDecoration(
                          color: LuxoraColors.success,
                          shape: BoxShape.circle,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(
                        'En ligne · réponse en 2 min',
                        style: LuxoraTextStyles.caption.copyWith(
                          fontSize: 10,
                          color: LuxoraColors.textTertiary,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
