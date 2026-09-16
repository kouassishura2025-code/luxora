import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'core/di/injection_container.dart' as di;

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ─── Firebase désactivé (plan Blaze requis) ─────────────
  // Réactive quand le compte Blaze sera configuré :
  //
  // import 'firebase_options.dart';
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  await di.init();

  runApp(
    const ProviderScope(
      child: LuxoraApp(),
    ),
  );
}
