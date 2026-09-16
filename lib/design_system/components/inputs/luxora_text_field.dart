import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Champ de saisie premium LUXORA.
class LuxoraTextField extends StatelessWidget {
  const LuxoraTextField({
    super.key,
    this.controller,
    this.label,
    this.hint,
    this.prefixIcon,
    this.suffixIcon,
    this.obscureText = false,
    this.keyboardType,
    this.textInputAction,
    this.onChanged,
    this.onSubmitted,
    this.validator,
    this.errorText,
    this.maxLines = 1,
    this.enabled = true,
  });

  final TextEditingController? controller;
  final String? label;
  final String? hint;
  final IconData? prefixIcon;
  final Widget? suffixIcon;
  final bool obscureText;
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final ValueChanged<String>? onChanged;
  final ValueChanged<String>? onSubmitted;
  final String? Function(String?)? validator;
  final String? errorText;
  final int maxLines;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (label != null) ...[
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 8),
            child: Text(
              label!.toUpperCase(),
              style: LuxoraTextStyles.caption.copyWith(
                color: LuxoraColors.textSecondary,
              ),
            ),
          ),
        ],
        TextFormField(
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          textInputAction: textInputAction,
          onChanged: onChanged,
          onFieldSubmitted: onSubmitted,
          validator: validator,
          maxLines: maxLines,
          enabled: enabled,
          style: LuxoraTextStyles.bodyLarge,
          cursorColor: LuxoraColors.champagne,
          decoration: InputDecoration(
            hintText: hint,
            errorText: errorText,
            prefixIcon: prefixIcon != null
                ? Icon(prefixIcon, color: LuxoraColors.textTertiary, size: 20)
                : null,
            suffixIcon: suffixIcon,
            filled: true,
            fillColor: LuxoraColors.charcoal,
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 18,
            ),
            border: const OutlineInputBorder(
              borderRadius: LuxoraRadii.brMd,
              borderSide: BorderSide.none,
            ),
            enabledBorder: const OutlineInputBorder(
              borderRadius: LuxoraRadii.brMd,
              borderSide: BorderSide.none,
            ),
            focusedBorder: const OutlineInputBorder(
              borderRadius: LuxoraRadii.brMd,
              borderSide: BorderSide(
                color: LuxoraColors.champagne,
                width: 1,
              ),
            ),
            errorBorder: const OutlineInputBorder(
              borderRadius: LuxoraRadii.brMd,
              borderSide: BorderSide(color: LuxoraColors.error, width: 1),
            ),
            focusedErrorBorder: const OutlineInputBorder(
              borderRadius: LuxoraRadii.brMd,
              borderSide: BorderSide(color: LuxoraColors.error, width: 1),
            ),
            hintStyle: LuxoraTextStyles.bodyMedium.copyWith(
              color: LuxoraColors.textTertiary,
            ),
          ),
        ),
      ],
    );
  }
}
