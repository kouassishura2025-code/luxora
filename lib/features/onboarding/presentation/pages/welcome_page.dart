import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/components/media/luxora_logo_animated.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';
import '../../../../l10n/generated/app_localizations.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = AppLocalizations.of(context);

    return LuxoraScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),

          const Center(
            child: LuxoraLogoAnimated(
              size: 140,
              showWordmark: true,
            ),
          ),

          const SizedBox(height: 32),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              l10n.appTagline,
              style: LuxoraTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(flex: 3),

          LuxoraPrimaryButton(
            label: l10n.welcomeStart,
            onPressed: () => context.push(RouteNames.onboarding),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
