import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Champ de saisie avec bouton d'envoi doré.
class ChatInput extends StatefulWidget {
  const ChatInput({
    super.key,
    required this.onSend,
  });

  final void Function(String) onSend;

  @override
  State<ChatInput> createState() => _ChatInputState();
}

class _ChatInputState extends State<ChatInput> {
  final _controller = TextEditingController();
  final _focusNode = FocusNode();
  bool _hasText = false;

  @override
  void initState() {
    super.initState();
    _controller.addListener(() {
      final hasText = _controller.text.trim().isNotEmpty;
      if (hasText != _hasText) {
        setState(() => _hasText = hasText);
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _send() {
    final text = _controller.text.trim();
    if (text.isEmpty) return;
    widget.onSend(text);
    _controller.clear();
    _focusNode.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
      decoration: const BoxDecoration(
        color: LuxoraColors.obsidian,
        border: Border(
          top: BorderSide(color: LuxoraColors.divider, width: 0.5),
        ),
      ),
      child: SafeArea(
        top: false,
        child: Row(
          children: [
            Expanded(
              child: Container(
                decoration: BoxDecoration(
                  color: LuxoraColors.charcoal,
                  borderRadius: LuxoraRadii.brPill,
                ),
                child: TextField(
                  controller: _controller,
                  focusNode: _focusNode,
                  onSubmitted: (_) => _send(),
                  textInputAction: TextInputAction.send,
                  maxLines: 4,
                  minLines: 1,
                  style: LuxoraTextStyles.bodyMedium.copyWith(
                    color: LuxoraColors.textPrimary,
                    fontSize: 14,
                  ),
                  cursorColor: LuxoraColors.champagne,
                  decoration: InputDecoration(
                    hintText: 'Écrivez un message…',
                    hintStyle: LuxoraTextStyles.bodyMedium.copyWith(
                      color: LuxoraColors.textTertiary,
                      fontSize: 14,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 18,
                      vertical: 12,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(width: 10),
            AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: _hasText
                    ? LuxoraColors.champagne
                    : LuxoraColors.graphite,
                shape: BoxShape.circle,
                boxShadow: _hasText
                    ? [
                        BoxShadow(
                          color: LuxoraColors.champagne.withOpacity(0.3),
                          blurRadius: 12,
                          spreadRadius: -2,
                        ),
                      ]
                    : null,
              ),
              child: Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: _hasText ? _send : null,
                  borderRadius: BorderRadius.circular(22),
                  child: Icon(
                    Icons.arrow_upward_rounded,
                    size: 20,
                    color: _hasText
                        ? LuxoraColors.obsidian
                        : LuxoraColors.textTertiary,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
