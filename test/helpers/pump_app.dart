import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

/// Helper pour tester un widget LUXORA avec un ProviderScope.
///
/// ## Exemple
/// ```dart
/// testWidgets('affiche le bouton', (tester) async {
///   await pumpLuxoraApp(
///     tester,
///     child: const LuxoraPrimaryButton(
///       label: 'Test',
///       onPressed: null,
///     ),
///   );
///   expect(find.text('Test'), findsOneWidget);
/// });
/// ```
extension LuxoraPumpX on WidgetTester {
  Future<void> pumpLuxoraApp({
    required Widget child,
    List<Override> overrides = const [],
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: Scaffold(body: child),
        ),
      ),
    );
    await pump();
  }

  Future<void> pumpLuxoraScaffold({
    required Widget child,
    List<Override> overrides = const [],
  }) async {
    await pumpWidget(
      ProviderScope(
        overrides: overrides,
        child: MaterialApp(
          theme: ThemeData.dark(),
          home: child,
        ),
      ),
    );
    await pump();
  }
}
