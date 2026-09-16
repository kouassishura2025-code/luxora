import 'package:flutter/material.dart';

import '../foundations/colors/luxora_colors.dart';
import '../foundations/spacing/luxora_spacing.dart';

/// Extensions BuildContext LUXORA.
///
/// Permettent d'écrire `context.colors.obsidian` au lieu de
/// `LuxoraColors.obsidian` partout.
extension LuxoraContextX on BuildContext {
  LuxoraColorsX get luxoraColors => const LuxoraColorsX();
  LuxoraSpacingX get luxoraSpacing => const LuxoraSpacingX();

  /// Raccourci vers MediaQuery pour éviter `MediaQuery.of(context)`.
  Size get screenSize => MediaQuery.sizeOf(this);
  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Safe area paddings.
  EdgeInsets get viewPadding => MediaQuery.viewPaddingOf(this);
  EdgeInsets get viewInsets => MediaQuery.viewInsetsOf(this);
}

/// Wrapper const autour des couleurs (permet `context.luxoraColors`).
class LuxoraColorsX {
  const LuxoraColorsX();

  Color get obsidian => LuxoraColors.obsidian;
  Color get charcoal => LuxoraColors.charcoal;
  Color get ivory => LuxoraColors.ivory;
  Color get champagne => LuxoraColors.champagne;
  Color get textPrimary => LuxoraColors.textPrimary;
  Color get textSecondary => LuxoraColors.textSecondary;
  Color get divider => LuxoraColors.divider;
}

/// Wrapper const autour des espacements.
class LuxoraSpacingX {
  const LuxoraSpacingX();

  double get xs => LuxoraSpacing.xs;
  double get sm => LuxoraSpacing.sm;
  double get md => LuxoraSpacing.md;
  double get lg => LuxoraSpacing.lg;
  double get xl => LuxoraSpacing.xl;
  double get screenPadding => LuxoraSpacing.screenPadding;
  double get sectionGap => LuxoraSpacing.sectionGap;
}
