import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_bottom_action_area.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

void main() {
  const screen = Size(390, 844);
  const buttonHeight = 56.0;

  /// Lays the area out the way the record pages do: pinned under an
  /// [Expanded] in a [Scaffold] body, on a 390×844 screen.
  Future<void> pumpArea(WidgetTester tester, MediaQueryData mediaQuery) async {
    tester.view
      ..physicalSize = screen
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MediaQuery(
        data: mediaQuery.copyWith(size: screen),
        child: MaterialApp(
          home: Scaffold(
            body: Column(
              children: [
                const Expanded(child: SizedBox.expand()),
                OweMeBottomActionArea(
                  child: OweMeElevatedButton(
                    label: 'Confirmar',
                    onPressed: () {},
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Rect buttonRect(WidgetTester tester) =>
      tester.getRect(find.byType(OweMeElevatedButton));

  testWidgets('without a bottom inset, keeps 16px around the button', (
    tester,
  ) async {
    await pumpArea(tester, const MediaQueryData());

    expect(
      buttonRect(tester),
      const Rect.fromLTRB(16, 844 - 16 - buttonHeight, 390 - 16, 844 - 16),
    );
  });

  testWidgets('keeps the button above the home indicator', (tester) async {
    await pumpArea(
      tester,
      const MediaQueryData(
        padding: EdgeInsets.only(bottom: 34),
        viewPadding: EdgeInsets.only(bottom: 34),
      ),
    );

    expect(
      buttonRect(tester),
      const Rect.fromLTRB(
        16,
        844 - 34 - 16 - buttonHeight,
        390 - 16,
        844 - 34 - 16,
      ),
    );
  });

  testWidgets(
    'with the keyboard open, sits right above it with no home-indicator gap',
    (tester) async {
      // The keyboard covers the home indicator, so the platform reports no
      // bottom padding while it is up; only viewPadding still remembers it.
      await pumpArea(
        tester,
        const MediaQueryData(
          viewInsets: EdgeInsets.only(bottom: 300),
          viewPadding: EdgeInsets.only(bottom: 34),
        ),
      );

      expect(buttonRect(tester).bottom, 844 - 300 - 16);
    },
  );
}
