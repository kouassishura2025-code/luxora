import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/design_system/components/buttons/luxora_primary_button.dart';
import 'package:luxora/design_system/components/buttons/luxora_ghost_button.dart';
import 'package:luxora/design_system/components/buttons/luxora_text_button.dart';

void main() {
  group('LuxoraPrimaryButton', () {
    testWidgets('affiche le label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraPrimaryButton(
              label: 'Réserver',
              onPressed: () {},
            ),
          ),
        ),
      );
      expect(find.text('Réserver'), findsOneWidget);
    });

    testWidgets('appelle onPressed au tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraPrimaryButton(
              label: 'Tester',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );
      await tester.tap(find.text('Tester'));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('affiche CircularProgressIndicator si isLoading', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraPrimaryButton(
              label: 'Tester',
              isLoading: true,
              onPressed: () {},
            ),
          ),
        ),
      );
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(find.text('Tester'), findsNothing);
    });

    testWidgets('désactivé si onPressed null', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraPrimaryButton(
              label: 'Test',
              onPressed: null,
            ),
          ),
        ),
      );
      // Le tap ne doit rien faire
      await tester.tap(find.text('Test'));
      await tester.pump();
      expect(tester.takeException(), isNull);
    });
  });

  group('LuxoraGhostButton', () {
    testWidgets('affiche le label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraGhostButton(
              label: 'Annuler',
              onPressed: () {},
            ),
          ),
        ),
      );
      expect(find.text('Annuler'), findsOneWidget);
    });

    testWidgets('appelle onPressed au tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraGhostButton(
              label: 'Tester',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );
      await tester.tap(find.text('Tester'));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });

  group('LuxoraTextButton', () {
    testWidgets('affiche le label', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraTextButton(
              label: 'Passer',
              onPressed: () {},
            ),
          ),
        ),
      );
      expect(find.text('Passer'), findsOneWidget);
    });

    testWidgets('appelle onPressed au tap', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraTextButton(
              label: 'Tester',
              onPressed: () => tapped = true,
            ),
          ),
        ),
      );
      await tester.tap(find.text('Tester'));
      await tester.pump();
      expect(tapped, isTrue);
    });
  });
}
