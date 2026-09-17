import 'package:flutter/material.dart';

import '../../../../design_system/components/media/luxora_avatar.dart';
import '../../../../design_system/components/navigation/notification_bell.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../l10n/generated/app_localizations.dart';

class GreetingHeader extends StatelessWidget {
  const GreetingHeader({
    super.key,
    required this.initials,
    this.onAvatarTap,
  });

  final String initials;
  final VoidCallback? onAvatarTap;

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
      child: Row(
        children: [
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
            l10n.homeCity,
            style: LuxoraTextStyles.caption.copyWith(
              color: LuxoraColors.textSecondary,
            ),
          ),

          const Spacer(),

          const NotificationBell(),

          const SizedBox(width: 4),

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
