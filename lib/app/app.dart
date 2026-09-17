import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../core/l10n/locale_provider.dart';
import '../design_system/theme/luxora_theme.dart';
import '../l10n/generated/app_localizations.dart';
import 'router/app_router.dart';

class LuxoraApp extends ConsumerWidget {
  const LuxoraApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final router = ref.watch(appRouterProvider);
    final locale = ref.watch(localeProvider);

    return MaterialApp.router(
      title: 'LUXORA',
      debugShowCheckedModeBanner: false,
      theme: LuxoraTheme.light,
      darkTheme: LuxoraTheme.dark,
      themeMode: ThemeMode.dark,
      locale: locale,
      supportedLocales: supportedLocales,
      localizationsDelegates: const [
        AppLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      routerConfig: router,
    );
  }
}
