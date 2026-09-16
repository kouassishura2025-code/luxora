import 'package:flutter/material.dart';

import '../../../../design_system/components/media/luxora_avatar.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/emergency_contact.dart';

/// Tuile avec case à cocher pour sélectionner un contact.
class ContactCheckboxTile extends StatelessWidget {
  const ContactCheckboxTile({
    super.key,
    required this.contact,
    required this.isSelected,
    required this.onToggle,
  });

  final EmergencyContact contact;
  final bool isSelected;
  final VoidCallback onToggle;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onToggle,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              LuxoraAvatar(
                initials: contact.initials,
                size: 36,
                goldBorder: isSelected,
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Text(
                  contact.displayName,
                  style: LuxoraTextStyles.bodyLarge.copyWith(fontSize: 14),
                ),
              ),
              AnimatedContainer(
                duration: const Duration(milliseconds: 200),
                width: 22,
                height: 22,
                decoration: BoxDecoration(
                  color: isSelected
                      ? LuxoraColors.champagne
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(6),
                  border: Border.all(
                    color: isSelected
                        ? LuxoraColors.champagne
                        : LuxoraColors.divider,
                    width: 1.5,
                  ),
                ),
                child: isSelected
                    ? const Icon(
                        Icons.check_rounded,
                        size: 14,
                        color: LuxoraColors.obsidian,
                      )
                    : null,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
