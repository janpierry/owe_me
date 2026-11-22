import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/add_favorite_description.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_credits.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_debts.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/description_step_page/set_owe_record_description_text_form_field.dart';

class MockAddFavoriteDescription extends Mock implements AddFavoriteDescription {}

class MockLoadDebtorFavoriteDebts extends Mock implements LoadDebtorFavoriteDebts {}

class MockLoadDebtorFavoriteCredits extends Mock implements LoadDebtorFavoriteCredits {}

void main() {
  final debtor = Debtor.create(id: 1, nickname: 'João').asRight();
  final recordToEdit = OweRecord.create(
    id: 7,
    amount: RecordAmount.create(const Money(cents: 2500)).asRight(),
    date: DateTime(2026, 11, 1),
    description: 'Almoço',
    oweType: OweType.debt,
  ).asRight();

  setUp(() {
    final loadDebtorFavoriteDebts = MockLoadDebtorFavoriteDebts();
    when(() => loadDebtorFavoriteDebts(debtor))
        .thenAnswer((_) async => const Right([]));

    GetIt.instance.registerFactory<SetOweRecordDescriptionStepBloc>(
      () => SetOweRecordDescriptionStepBloc(
        addFavoriteDescription: MockAddFavoriteDescription(),
        loadDebtorFavoriteDebts: loadDebtorFavoriteDebts,
        loadDebtorFavoriteCredits: MockLoadDebtorFavoriteCredits(),
      ),
    );
  });

  tearDown(() => GetIt.instance.reset());

  testWidgets(
    "editing a record opens the description step with the record's description",
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SetOweRecordAmountStepContainer(
            recordDebtor: debtor,
            oweRecordType: OweType.debt,
            oweRecordToEdit: recordToEdit,
            fromDebtorPage: true,
          ),
        ),
      );

      await tester.tap(find.text('Continuar'));
      await tester.pumpAndSettle();

      expect(
        find.widgetWithText(SetOweRecordDescriptionTextFormField, 'Almoço'),
        findsOneWidget,
      );
    },
  );
}
