import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/containers/set_payment_record/set_payment_record_form_container.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

void main() {
  const screen = Size(390, 844);

  final debtor = Debtor.create(id: 1, nickname: 'João').asRight();

  Future<void> pumpPage(WidgetTester tester, MediaQueryData mediaQuery) async {
    tester.view
      ..physicalSize = screen
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MediaQuery(
        data: mediaQuery.copyWith(
          size: screen,
          // The test font draws every glyph 1em wide, so the payment method
          // hint would overflow a 390px screen here even though it fits on a
          // device. The button has a fixed height, so text size doesn't move it.
          textScaler: const TextScaler.linear(0.5),
        ),
        child: MaterialApp(
          home: SetPaymentRecordFormContainer(
            recordDebtor: debtor,
            fromDebtorPage: false,
          ),
        ),
      ),
    );
  }

  double continueButtonBottom(WidgetTester tester) => tester
      .getBottomLeft(find.widgetWithText(OweMeElevatedButton, 'Continuar'))
      .dy;

  group('the "Continuar" button', () {
    testWidgets('sits above the iPhone home indicator', (tester) async {
      await pumpPage(
        tester,
        const MediaQueryData(
          padding: EdgeInsets.only(bottom: 34),
          viewPadding: EdgeInsets.only(bottom: 34),
        ),
      );

      expect(continueButtonBottom(tester), lessThanOrEqualTo(844 - 34 - 16));
    });

    // The amount field takes focus on open, so this is how the page first
    // shows up on a phone.
    testWidgets('sits right above the keyboard, with no home-indicator gap', (
      tester,
    ) async {
      await pumpPage(
        tester,
        const MediaQueryData(
          viewInsets: EdgeInsets.only(bottom: 300),
          viewPadding: EdgeInsets.only(bottom: 34),
        ),
      );

      expect(continueButtonBottom(tester), 844 - 300 - 16);
    });
  });
}
