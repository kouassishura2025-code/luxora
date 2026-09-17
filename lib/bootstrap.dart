import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'app/app.dart';
import 'app/splash/luxora_splash_screen.dart';
import 'core/di/injection_container.dart' as di;

Future<void> bootstrap() async {
  WidgetsFlutterBinding.ensureInitialized();

  // ─── Firebase désactivé (mock auth actuellement) ────────
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );

  // ─── Affiche le splash immédiatement ────────────────────
  runApp(
    const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: LuxoraSplashScreen(),
    ),
  );

  // ─── Initialisation en arrière-plan ─────────────────────
  await di.init();

  // ─── Durée minimum du splash (pour laisser l'anim finir) ─
  await Future<void>.delayed(const Duration(milliseconds: 2400));

  // ─── Lance l'app réelle ─────────────────────────────────
  runApp(
    const ProviderScope(
      child: LuxoraApp(),
    ),
  );
}
