import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/spacing/luxora_radii.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// Champ téléphone international LUXORA.
///
/// Affiche un indicatif pays à gauche (sélectionnable) et le numéro.
class LuxoraPhoneField extends StatelessWidget {
  const LuxoraPhoneField({
    super.key,
    required this.controller,
    this.countryCode = '+225',
    this.onCountryTap,
    this.onChanged,
    this.errorText,
    this.enabled = true,
  });

  final TextEditingController controller;
  final String countryCode;
  final VoidCallback? onCountryTap;
  final ValueChanged<String>? onChanged;
  final String? errorText;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 8),
          child: Text(
            'NUMÉRO DE TÉLÉPHONE',
            style: LuxoraTextStyles.caption.copyWith(
              color: LuxoraColors.textSecondary,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: LuxoraColors.charcoal,
            borderRadius: LuxoraRadii.brMd,
            border: errorText != null
                ? Border.all(color: LuxoraColors.error, width: 1)
                : null,
          ),
          child: Row(
            children: [
              // ─── Indicatif pays ────────────────────────
              Material(
                color: Colors.transparent,
                child: InkWell(
                  onTap: enabled ? onCountryTap : null,
                  borderRadius: const BorderRadius.horizontal(
                    left: LuxoraRadii.md,
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                    child: Row(
                      children: [
                        Text(
                          countryCode,
                          style: LuxoraTextStyles.bodyLarge,
                        ),
                        const SizedBox(width: 6),
                        Icon(
                          Icons.keyboard_arrow_down_rounded,
                          size: 16,
                          color: LuxoraColors.textSecondary,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                width: 0.5,
                height: 28,
                color: LuxoraColors.divider,
              ),
              // ─── Numéro ──────────────────────────────
              Expanded(
                child: TextField(
                  controller: controller,
                  enabled: enabled,
                  onChanged: onChanged,
                  keyboardType: TextInputType.phone,
                  inputFormatters: [
                    FilteringTextInputFormatter.digitsOnly,
                    LengthLimitingTextInputFormatter(15),
                  ],
                  style: LuxoraTextStyles.bodyLarge,
                  cursorColor: LuxoraColors.champagne,
                  decoration: InputDecoration(
                    hintText: '07 18 14 87 79',
                    hintStyle: LuxoraTextStyles.bodyMedium.copyWith(
                      color: LuxoraColors.textTertiary,
                    ),
                    border: InputBorder.none,
                    contentPadding: const EdgeInsets.symmetric(
                      horizontal: 16,
                      vertical: 18,
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
        if (errorText != null)
          Padding(
            padding: const EdgeInsets.only(left: 4, top: 8),
            child: Text(
              errorText!,
              style: LuxoraTextStyles.bodySmall.copyWith(
                color: LuxoraColors.error,
                fontSize: 12,
              ),
            ),
          ),
      ],
    );
  }
}
