import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// AppBar signature LUXORA.
///
/// Pas de titre centré par défaut. Le titre est optionnel.
/// En l'absence de titre, l'or est réservé au contenu, pas à la barre.
class LuxoraAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LuxoraAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.overline,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;
  final String? overline;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: leading ??
          (showBackButton && Navigator.of(context).canPop()
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: LuxoraColors.textPrimary,
                    size: 20,
                  ),
                  onPressed: () => Navigator.of(context).pop(),
                )
              : null),
      titleSpacing: showBackButton ? 0 : 20,
      title: title != null || overline != null
          ? Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                if (overline != null)
                  Text(
                    overline!.toUpperCase(),
                    style: LuxoraTextStyles.overline,
                  ),
                if (title != null)
                  Text(
                    title!,
                    style: LuxoraTextStyles.titleMedium,
                  ),
              ],
            )
          : null,
      actions: actions,
    );
  }
}
