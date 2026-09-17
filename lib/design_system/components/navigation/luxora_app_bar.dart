import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../foundations/colors/luxora_colors.dart';
import '../../foundations/typography/luxora_text_styles.dart';

/// AppBar signature LUXORA.
///
/// Affiche un chevron retour si [showBackButton] est `true`
/// ET si GoRouter a une route à dépiler (ou si on force son affichage).
class LuxoraAppBar extends StatelessWidget implements PreferredSizeWidget {
  const LuxoraAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.showBackButton = true,
    this.forceBackButton = false,
    this.onBackPressed,
    this.overline,
  });

  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;

  /// Force l'affichage du chevron même si GoRouter ne peut pas pop.
  final bool forceBackButton;

  /// Callback personnalisé pour le retour.
  /// Si null, utilise `context.pop()` ou fallback vers Home.
  final VoidCallback? onBackPressed;

  final String? overline;

  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    // Affiche le chevron si forcé OU si GoRouter peut pop
    final canPop = showBackButton && context.canPop();
    final shouldShowBack = leading != null ||
        (showBackButton && (canPop || forceBackButton));

    void handleBack() {
      if (onBackPressed != null) {
        onBackPressed!();
      } else if (context.canPop()) {
        context.pop();
      } else {
        // Fallback : aller à Home
        context.go('/');
      }
    }

    return AppBar(
      backgroundColor: Colors.transparent,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: false,
      automaticallyImplyLeading: false,
      leading: leading ??
          (shouldShowBack
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios_new_rounded,
                    color: LuxoraColors.textPrimary,
                    size: 20,
                  ),
                  onPressed: handleBack,
                )
              : null),
      titleSpacing: shouldShowBack ? 0 : 20,
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
