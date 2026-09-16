import 'package:flutter/material.dart';

import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/spacing/luxora_radii.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../providers/notification_provider.dart';

/// Barre de filtres horizontale.
class NotificationFilterBar extends StatelessWidget {
  const NotificationFilterBar({
    super.key,
    required this.current,
    required this.onChanged,
  });

  final NotificationFilter current;
  final ValueChanged<NotificationFilter> onChanged;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 38,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: NotificationFilter.values.length,
        separatorBuilder: (_, __) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final filter = NotificationFilter.values[index];
          final isActive = filter == current;

          return Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => onChanged(filter),
              borderRadius: LuxoraRadii.brPill,
              child: AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                padding: const EdgeInsets.symmetric(
                  horizontal: 16,
                  vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: isActive
                      ? LuxoraColors.champagne.withOpacity(0.15)
                      : LuxoraColors.charcoal,
                  borderRadius: LuxoraRadii.brPill,
                  border: Border.all(
                    color: isActive
                        ? LuxoraColors.champagne
                        : LuxoraColors.divider,
                    width: isActive ? 1 : 0.5,
                  ),
                ),
                child: Center(
                  child: Text(
                    filter.label,
                    style: LuxoraTextStyles.labelMedium.copyWith(
                      fontSize: 12,
                      color: isActive
                          ? LuxoraColors.champagne
                          : LuxoraColors.textSecondary,
                    ),
                  ),
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
