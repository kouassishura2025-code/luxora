import 'package:flutter/material.dart';

import '../../../../design_system/components/media/luxora_avatar.dart';
import '../../../../design_system/components/navigation/notification_bell.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

/// Header signature de la Home : LUXORA · Ville + Cloche + Avatar.
class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.city,
    required this.initials,
    this.onAvatarTap,
  });

  final String city;
  final String initials;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
          // ─── Marque ──────────────────────────────────────
          Text(
            'LUXORA',
            style: LuxoraTextStyles.overline.copyWith(
              fontSize: 13,
              letterSpacing: 3,
            ),
          ),
          const SizedBox(width: 12),
          Container(
            width: 1,
            height: 12,
            color: LuxoraColors.divider,
          ),
          const SizedBox(width: 12),
          Text(
            city,
            style: LuxoraTextStyles.caption.copyWith(
              color: LuxoraColors.textSecondary,
            ),
          ),

          const Spacer(),

          // ─── Cloche ──────────────────────────────────────
          const NotificationBell(),

          const SizedBox(width: 4),

          // ─── Avatar ──────────────────────────────────────
          LuxoraAvatar(
            initials: initials,
            goldBorder: true,
            onTap: onAvatarTap,
          ),
        ],
      ),
    );
  }
}
