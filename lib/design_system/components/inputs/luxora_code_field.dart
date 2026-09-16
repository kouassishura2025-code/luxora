import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

class LuxoraCodeField extends StatefulWidget {
  const LuxoraCodeField({
    super.key,
    required this.length,
    required this.onCompleted,
    this.onChanged,
    this.autofocus = true,
  });

  final int length;
  final ValueChanged<String> onCompleted;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  @override
  State<LuxoraCodeField> createState() => _LuxoraCodeFieldState();
}

class _LuxoraCodeFieldState extends State<LuxoraCodeField> {
  late final TextEditingController _controller;
  late final FocusNode _focusNode;

  @override
  void initState() {
    super.initState();
    _controller = TextEditingController();
    _focusNode = FocusNode();
    _focusNode.addListener(() => setState(() {}));
  }

  @override
  void dispose() {
    _controller.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Opacity(
          opacity: 0,
          child: TextField(
            controller: _controller,
            focusNode: _focusNode,
            autofocus: widget.autofocus,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(widget.length),
            ],
            onChanged: (value) {
              widget.onChanged?.call(value);
              setState(() {});
              if (value.length == widget.length) {
                widget.onCompleted(value);
              }
            },
          ),
        ),
        GestureDetector(
          onTap: () => _focusNode.requestFocus(),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: List.generate(widget.length, (index) {
              final hasValue = index < _controller.text.length;
              final digit = hasValue ? _controller.text[index] : '';
              final isCurrent =
                  _focusNode.hasFocus && index == _controller.text.length;

              return AnimatedContainer(
                duration: const Duration(milliseconds: 150),
                width: 48,
                height: 60,
                decoration: BoxDecoration(
                  color: LuxoraColors.charcoal,
                  borderRadius: LuxoraRadii.brMd,
                  border: Border.all(
                    color: isCurrent
                        ? LuxoraColors.champagne
                        : hasValue
                            ? LuxoraColors.champagne.withOpacity(0.4)
                            : LuxoraColors.divider,
                    width: isCurrent ? 1.5 : 0.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    digit,
                    style: LuxoraTextStyles.titleMedium.copyWith(
                      fontSize: 22,
                      color: LuxoraColors.champagne,
                    ),
                  ),
                ),
              );
            }),
          ),
        ),
      ],
    );
  }
}
