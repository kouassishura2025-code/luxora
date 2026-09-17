import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/design_system/components/surfaces/luxora_card.dart';

void main() {
  group('LuxoraCard', () {
    testWidgets('affiche son child', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LuxoraCard(child: Text('Contenu')),
          ),
        ),
      );
      expect(find.text('Contenu'), findsOneWidget);
    });

    testWidgets('appelle onTap si fourni', (tester) async {
      var tapped = false;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraCard(
              onTap: () => tapped = true,
              child: const Text('Taper'),
            ),
          ),
        ),
      );
      await tester.tap(find.text('Taper'));
      await tester.pump();
      expect(tapped, isTrue);
    });

    testWidgets('ne throw pas si onTap est null', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LuxoraCard(child: Text('Pas de tap')),
          ),
        ),
      );
      expect(find.text('Pas de tap'), findsOneWidget);
    });
  });
}
