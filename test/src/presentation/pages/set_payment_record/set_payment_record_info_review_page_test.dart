import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/pages/set_payment_record/set_payment_record_info_review_page.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

class _MockAddMonetaryRecordAndUpdateDebtor extends Mock
    implements AddMonetaryRecordAndUpdateDebtor {}

class _MockEditMonetaryRecordAndUpdateDebtor extends Mock
    implements EditMonetaryRecordAndUpdateDebtor {}

void main() {
  const screen = Size(390, 844);

  final debtor = Debtor.create(id: 1, nickname: 'João').asRight();
  final draft = PaymentRecordDraft(
    amount: const Money(cents: 5000),
    date: DateTime(2026, 1, 15),
    paymentMethod: PaymentMethod.pix,
  );

  testWidgets('"Confirmar" sits above the iPhone home indicator', (
    tester,
  ) async {
    tester.view
      ..physicalSize = screen
      ..devicePixelRatio = 1;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MediaQuery(
        data: const MediaQueryData(
          size: screen,
          padding: EdgeInsets.only(bottom: 34),
          viewPadding: EdgeInsets.only(bottom: 34),
          // The test font draws every glyph 1em wide, so the payment method
          // row would overflow a 390px screen here even though it fits on a
          // device. The button has a fixed height, so text size doesn't move it.
          textScaler: TextScaler.linear(0.5),
        ),
        child: MaterialApp(
          home: BlocProvider(
            create: (_) =>
                SetPaymentRecordInfoReviewBloc(
                  addMonetaryRecordAndUpdateDebtor:
                      _MockAddMonetaryRecordAndUpdateDebtor(),
                  editMonetaryRecordAndUpdateDebtor:
                      _MockEditMonetaryRecordAndUpdateDebtor(),
                )..add(
                  SetPaymentRecordInfoReviewPageInitialized(
                    paymentRecordDraft: draft,
                    recordDebtor: debtor,
                    paymentRecordToEdit: null,
                  ),
                ),
            child: SetPaymentRecordInfoReviewPage(
              paymentRecordDraft: draft,
              recordDebtor: debtor,
              paymentRecordToEdit: null,
              fromDebtorPage: false,
            ),
          ),
        ),
      ),
    );
    await tester.pump();

    expect(
      tester
          .getBottomLeft(find.widgetWithText(OweMeElevatedButton, 'Confirmar'))
          .dy,
      lessThanOrEqualTo(844 - 34 - 16),
    );
  });
}
