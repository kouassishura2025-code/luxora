import 'package:flutter/material.dart';

import '../../foundations/colors/luxora_colors.dart';

/// Bouton retour LUXORA — discret, flèche fine.
class LuxoraBackButton extends StatelessWidget {
  const LuxoraBackButton({super.key, this.onPressed});

  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed ?? () => Navigator.of(context).maybePop(),
        borderRadius: BorderRadius.circular(22),
        child: Container(
          width: 44,
          height: 44,
          alignment: Alignment.center,
          child: const Icon(
            Icons.arrow_back_ios_new_rounded,
            size: 18,
            color: LuxoraColors.textPrimary,
          ),
        ),
      ),
    );
  }
}
