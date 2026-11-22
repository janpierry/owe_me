import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/error/failures/failures.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/widgets/set_payment_record/info_review/set_payment_record_info_review_finish_button.dart';

class _MockAddMonetaryRecordAndUpdateDebtor extends Mock
    implements AddMonetaryRecordAndUpdateDebtor {}

class _MockEditMonetaryRecordAndUpdateDebtor extends Mock
    implements EditMonetaryRecordAndUpdateDebtor {}

void main() {
  final tDebtor = Debtor.create(id: 1, nickname: 'João').asRight();
  final tDraft = PaymentRecordDraft(
    amount: const Money(cents: 5000),
    date: DateTime(2026, 1, 15),
    paymentMethod: PaymentMethod.pix,
  );

  setUpAll(() {
    registerFallbackValue(tDraft.toEntity().asRight());
    registerFallbackValue(tDebtor);
  });

  ElevatedButton findButton(WidgetTester tester) =>
      tester.widget<ElevatedButton>(find.byType(ElevatedButton));

  testWidgets(
    'is disabled with a spinner while saving, and re-enabled after an error',
    (tester) async {
      final mockAdd = _MockAddMonetaryRecordAndUpdateDebtor();
      final saveCompleter = Completer<Either<Failure, Debtor>>();
      when(
        () => mockAdd(
          monetaryRecord: any(named: 'monetaryRecord'),
          recordDebtor: any(named: 'recordDebtor'),
        ),
      ).thenAnswer((_) => saveCompleter.future);

      final bloc =
          SetPaymentRecordInfoReviewBloc(
            addMonetaryRecordAndUpdateDebtor: mockAdd,
            editMonetaryRecordAndUpdateDebtor:
                _MockEditMonetaryRecordAndUpdateDebtor(),
          )..add(
            SetPaymentRecordInfoReviewPageInitialized(
              paymentRecordDraft: tDraft,
              recordDebtor: tDebtor,
              paymentRecordToEdit: null,
            ),
          );

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: BlocProvider(
              // Like the real container: the provider owns the bloc and closes it
              // when the tree is torn down.
              create: (_) => bloc,
              child: const SetPaymentRecordInfoReviewFinishButton(
                isEditing: false,
              ),
            ),
          ),
        ),
      );

      expect(find.text('Confirmar'), findsOneWidget);
      expect(findButton(tester).onPressed, isNotNull);

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump();

      expect(bloc.state, isA<SetPaymentRecordInfoReviewSettingRecord>());
      expect(find.text('Confirmar'), findsNothing);
      expect(find.byType(CircularProgressIndicator), findsOneWidget);
      expect(findButton(tester).onPressed, isNull);

      saveCompleter.complete(const Left(DefaultFailure()));
      await tester.pump();

      expect(bloc.state, isA<SetPaymentRecordInfoReviewError>());
      expect(find.text('Confirmar'), findsOneWidget);
      expect(find.byType(CircularProgressIndicator), findsNothing);
      expect(findButton(tester).onPressed, isNotNull);
    },
  );
}
