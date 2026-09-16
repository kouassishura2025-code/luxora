import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../app/router/route_names.dart';
import '../../../../design_system/components/buttons/luxora_primary_button.dart';
import '../../../../design_system/foundations/colors/luxora_colors.dart';
import '../../../../design_system/foundations/typography/luxora_text_styles.dart';
import '../../../../design_system/layouts/luxora_scaffold.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return LuxoraScaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Spacer(flex: 2),

          Text(
            'BIENVENUE',
            style: LuxoraTextStyles.overline,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 16),

          Text(
            'LUXORA',
            style: LuxoraTextStyles.displayLarge,
            textAlign: TextAlign.center,
          ),

          const SizedBox(height: 20),

          Center(
            child: Container(
              width: 40,
              height: 0.5,
              color: LuxoraColors.champagne,
            ),
          ),

          const SizedBox(height: 20),

          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24),
            child: Text(
              'Chauffeur privé &\nconciergerie de luxe',
              style: LuxoraTextStyles.bodyMedium,
              textAlign: TextAlign.center,
            ),
          ),

          const Spacer(flex: 3),

          LuxoraPrimaryButton(
            label: 'Commencer',
            onPressed: () => context.go(RouteNames.onboarding),
          ),

          const SizedBox(height: 32),
        ],
      ),
    );
  }
}
