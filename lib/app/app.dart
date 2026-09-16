import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../design_system/theme/luxora_theme.dart';
import 'router/app_router.dart';

class LuxoraApp extends ConsumerWidget {
  const LuxoraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);

    return MaterialApp.router(
      title: 'LUXORA',
      debugShowCheckedModeBanner: false,
      theme: LuxoraTheme.light,
      darkTheme: LuxoraTheme.dark,
      themeMode: ThemeMode.dark,
      routerConfig: router,
    );
  }
}
