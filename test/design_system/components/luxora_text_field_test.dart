import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:luxora/design_system/components/inputs/luxora_text_field.dart';

void main() {
  group('LuxoraTextField', () {
    testWidgets('affiche le hint', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LuxoraTextField(
              hint: 'Votre numéro',
            ),
          ),
        ),
      );
      expect(find.text('Votre numéro'), findsOneWidget);
    });

    testWidgets('affiche le label en majuscules', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LuxoraTextField(
              label: 'Téléphone',
              hint: '',
            ),
          ),
        ),
      );
      expect(find.text('TÉLÉPHONE'), findsOneWidget);
    });

    testWidgets('accepte la saisie utilisateur', (tester) async {
      final controller = TextEditingController();
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraTextField(
              controller: controller,
              hint: 'Tapez ici',
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextFormField), 'Test');
      expect(controller.text, 'Test');
      controller.dispose();
    });

    testWidgets('appelle onChanged à la saisie', (tester) async {
      String? value;
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: LuxoraTextField(
              hint: 'Tapez',
              onChanged: (v) => value = v,
            ),
          ),
        ),
      );
      await tester.enterText(find.byType(TextFormField), 'Hello');
      expect(value, 'Hello');
    });

    testWidgets('affiche l\'errorText si fourni', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: LuxoraTextField(
              hint: '',
              errorText: 'Erreur de test',
            ),
          ),
        ),
      );
      expect(find.text('Erreur de test'), findsOneWidget);
    });
  });
}
