import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../design_system/components/media/luxora_avatar.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../domain/entities/emergency_contact.dart';

/// Ligne d'un contact d'urgence.
class EmergencyContactTile extends StatelessWidget {
  const EmergencyContactTile({
    super.key,
    required this.contact,
    this.onRemove,
  });

  final EmergencyContact contact;
  final VoidCallback? onRemove;

  Future<void> _callContact() async {
    final phone = contact.phoneNumber.replaceAll(RegExp(r'[\s+]'), '');
    final uri = Uri.parse('tel:+$phone');
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      child: Row(
        children: [
          LuxoraAvatar(
            initials: contact.initials,
            size: 40,
            goldBorder: contact.isPrimary,
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Flexible(
                      child: Text(
                        contact.displayName,
                        style: LuxoraTextStyles.labelLarge
                            .copyWith(fontSize: 14),
                        overflow: TextOverflow.ellipsis,
                      ),
                    ),
                    if (contact.isPrimary) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 6,
                          vertical: 2,
                        ),
                        decoration: BoxDecoration(
                          color: LuxoraColors.champagne.withOpacity(0.15),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'PRINCIPAL',
                          style: LuxoraTextStyles.caption.copyWith(
                            fontSize: 7,
                            color: LuxoraColors.champagne,
                            letterSpacing: 1,
                          ),
                        ),
                      ),
                    ],
                  ],
                ),
                const SizedBox(height: 3),
                Text(
                  contact.phoneNumber,
                  style: LuxoraTextStyles.bodySmall.copyWith(fontSize: 12),
                ),
              ],
            ),
          ),
          IconButton(
            icon: const Icon(
              Icons.phone_outlined,
              size: 20,
              color: LuxoraColors.champagne,
            ),
            onPressed: _callContact,
            tooltip: 'Appeler',
          ),
          if (onRemove != null)
            IconButton(
              icon: const Icon(
                Icons.close_rounded,
                size: 18,
                color: LuxoraColors.textTertiary,
              ),
              onPressed: onRemove,
              tooltip: 'Retirer',
            ),
        ],
      ),
    );
  }
}
