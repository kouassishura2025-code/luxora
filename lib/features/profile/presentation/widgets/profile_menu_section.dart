import 'package:flutter/material.dart';

import '../../../../design_system/components/surfaces/luxora_card.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Section de menu avec titre + items.
class ProfileMenuSection extends StatelessWidget {
  const ProfileMenuSection({
    super.key,
    required this.title,
    required this.items,
  });

  final String title;
  final List<ProfileMenuItem> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 4, bottom: 10),
          child: Text(
            title.toUpperCase(),
            style: LuxoraTextStyles.overline.copyWith(
              fontSize: 10,
              color: LuxoraColors.textSecondary,
            ),
          ),
        ),
        LuxoraCard(
          padding: EdgeInsets.zero,
          child: Column(
            children: [
              for (var i = 0; i < items.length; i++) ...[
                items[i],
                if (i != items.length - 1)
                  const Divider(
                    color: LuxoraColors.divider,
                    height: 1,
                    indent: 56,
                  ),
              ],
            ],
          ),
        ),
      ],
    );
  }
}

/// Un item de menu profil.
class ProfileMenuItem extends StatelessWidget {
  const ProfileMenuItem({
    super.key,
    required this.icon,
    required this.label,
    this.trailing,
    this.trailingHighlight = false,
    this.destructive = false,
    this.onTap,
  });

  final IconData icon;
  final String label;
  final String? trailing;
  final bool trailingHighlight;
  final bool destructive;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final color =
        destructive ? LuxoraColors.error : LuxoraColors.textPrimary;

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
          child: Row(
            children: [
              Icon(icon, size: 20, color: color),
              const SizedBox(width: 16),
              Expanded(
                child: Text(
                  label,
                  style: LuxoraTextStyles.bodyLarge.copyWith(
                    fontSize: 15,
                    color: color,
                  ),
                ),
              ),
              if (trailing != null) ...[
                Text(
                  trailing!,
                  style: LuxoraTextStyles.caption.copyWith(
                    fontSize: 9,
                    color: trailingHighlight
                        ? LuxoraColors.champagne
                        : LuxoraColors.textTertiary,
                  ),
                ),
                const SizedBox(width: 8),
              ],
              if (!destructive)
                const Icon(
                  Icons.arrow_forward_ios_rounded,
                  size: 12,
                  color: LuxoraColors.textTertiary,
                ),
            ],
          ),
        ),
      ),
    );
  }
}
