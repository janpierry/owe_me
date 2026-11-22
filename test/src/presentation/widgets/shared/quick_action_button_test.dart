import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/presentation/widgets/shared/quick_action_button.dart';

void main() {
  const textScales = [1.0, 1.5, 2.0];

  Future<void> pumpButton(
    WidgetTester tester, {
    required String label,
    double textScale = 1.0,
  }) async {
    tester.view.physicalSize = const Size(360, 800);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: Scaffold(
          body: Center(
            child: QuickActionButton(
              label: label,
              icon: Icons.credit_card,
              onPressed: () {},
            ),
          ),
        ),
      ),
    );
  }

  group('QuickActionButton', () {
    testWidgets('keeps its 104x80 size at the default text scale', (
      tester,
    ) async {
      await pumpButton(tester, label: 'Débito');

      expect(
        tester.getSize(find.byType(QuickActionButton)),
        const Size(104, 80),
      );
    });

    for (final textScale in textScales) {
      testWidgets(
        'shows a wrapping label without overflow at text scale $textScale',
        (tester) async {
          await pumpButton(tester, label: 'Pagamento', textScale: textScale);

          expect(tester.takeException(), isNull);
          expect(find.text('Pagamento'), findsOneWidget);
          final labelRect = tester.getRect(find.text('Pagamento'));
          final buttonRect = tester.getRect(find.byType(QuickActionButton));
          expect(
            buttonRect.intersect(labelRect),
            labelRect,
            reason: 'the label must be drawn entirely inside the button',
          );
          expect(tester.getSize(find.byType(QuickActionButton)).width, 104);
        },
      );
    }
  });
}
