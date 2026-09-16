import 'package:flutter/material.dart';

import '../foundations/colors/luxora_colors.dart';

/// Scaffold signature LUXORA.
class LuxoraScaffold extends StatelessWidget {
  const LuxoraScaffold({
    super.key,
    required this.body,
    this.appBar,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.applyPadding = true,
    this.resizeToAvoidBottomInset = true,
    this.backgroundColor,
  });

  final Widget body;
  final PreferredSizeWidget? appBar;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final bool applyPadding;
  final bool resizeToAvoidBottomInset;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Container(
      color: backgroundColor ?? LuxoraColors.obsidian,
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: appBar,
        resizeToAvoidBottomInset: resizeToAvoidBottomInset,
        bottomNavigationBar: bottomNavigationBar,
        floatingActionButton: floatingActionButton,
        body: SafeArea(
          child: Padding(
            padding: applyPadding
                ? const EdgeInsets.symmetric(horizontal: 24)
                : EdgeInsets.zero,
            child: body,
          ),
        ),
      ),
    );
  }
}
