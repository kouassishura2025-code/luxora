import 'package:flutter/material.dart';

import '../../../../design_system/foundations/typography/luxora_text_styles.dart';

class GreetingSection extends StatelessWidget {
  const GreetingSection({
    super.key,
    required this.greeting,
    required this.name,
  });

  final String greeting;
  final String name;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(greeting, style: LuxoraTextStyles.bodyMedium),
        const SizedBox(height: 6),
        Text(name, style: LuxoraTextStyles.titleLarge),
      ],
    );
  }
}
