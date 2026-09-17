import 'package:flutter/material.dart';

/// Extensions BuildContext LUXORA.
extension ContextX on BuildContext {
  /// Taille de l'écran.
  Size get screenSize => MediaQuery.sizeOf(this);

  /// Largeur de l'écran.
  double get screenWidth => MediaQuery.sizeOf(this).width;

  /// Hauteur de l'écran.
  double get screenHeight => MediaQuery.sizeOf(this).height;

  /// Affiche un SnackBar simple.
  void showSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  /// Affiche un SnackBar d'erreur (fond rouge feutré).
  void showErrorSnackBar(String message) {
    ScaffoldMessenger.of(this).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: const Color(0xFF9B4A3F),
      ),
    );
  }

  /// Ferme le clavier.
  void unfocus() => FocusScope.of(this).unfocus();

  /// Vrai si le clavier est ouvert.
  bool get isKeyboardOpen => MediaQuery.viewInsetsOf(this).bottom > 0;
}
