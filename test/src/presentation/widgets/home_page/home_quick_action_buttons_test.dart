import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/presentation/widgets/home_page/home_quick_action_buttons.dart';
import 'package:owe_me/src/presentation/widgets/shared/quick_action_button.dart';

void main() {
  const screenSize = Size(360, 800);
  const pagePadding = 16.0;
  const labels = ['Pagamento', 'Crédito', 'Débito'];
  const textScales = [1.0, 1.5, 2.0];

  /// Pumps the row the way `HomeBody` lays it out: inside a scroll view with
  /// 16px padding, on a 360x800 screen.
  Future<void> pumpRow(WidgetTester tester, {required double textScale}) async {
    tester.view.physicalSize = screenSize;
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        builder: (context, child) => MediaQuery(
          data: MediaQuery.of(context)
              .copyWith(textScaler: TextScaler.linear(textScale)),
          child: child!,
        ),
        home: const Scaffold(
          body: SingleChildScrollView(
            padding: EdgeInsets.all(pagePadding),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [HomeQuickActionButtons()],
            ),
          ),
        ),
      ),
    );
  }

  Finder buttonWithLabel(String label) => find.ancestor(
    of: find.text(label),
    matching: find.byType(QuickActionButton),
  );

  group('HomeQuickActionButtons', () {
    for (final textScale in textScales) {
      testWidgets(
        'lays out three equal-height buttons without overflow at text scale '
        '$textScale',
        (tester) async {
          await pumpRow(tester, textScale: textScale);

          expect(tester.takeException(), isNull);

          for (final label in labels) {
            expect(find.text(label), findsOneWidget);
            final labelRect = tester.getRect(find.text(label));
            final buttonRect = tester.getRect(buttonWithLabel(label));
            expect(
              buttonRect.intersect(labelRect),
              labelRect,
              reason: '"$label" must be drawn entirely inside its button',
            );
          }

          final buttonRects = labels
              .map((label) => tester.getRect(buttonWithLabel(label)))
              .toList();
          expect(
            buttonRects.map((rect) => rect.height).toSet(),
            hasLength(1),
            reason: 'all buttons must share the same height',
          );
          expect(
            buttonRects.map((rect) => rect.width),
            everyElement(104),
            reason: 'buttons keep their width so the row fits 360dp',
          );
          expect(
            buttonRects.last.right,
            lessThanOrEqualTo(screenSize.width - pagePadding),
          );
        },
      );
    }
  });
}
