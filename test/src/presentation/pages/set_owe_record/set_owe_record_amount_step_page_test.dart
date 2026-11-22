import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get_it/get_it.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/add_favorite_description.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_credits.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_debts.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_amount_step_container.dart';
import 'package:owe_me/src/presentation/widgets/set_owe_record/description_step_page/set_owe_record_description_text_form_field.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_amount_text_form_field.dart';

class MockAddFavoriteDescription extends Mock
    implements AddFavoriteDescription {}

class MockLoadDebtorFavoriteDebts extends Mock
    implements LoadDebtorFavoriteDebts {}

class MockLoadDebtorFavoriteCredits extends Mock
    implements LoadDebtorFavoriteCredits {}

void main() {
  final debtor = Debtor.create(id: 1, nickname: 'João').asRight();

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
    'creating a record: "Continuar" opens the description step with no '
    'description',
    (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: SetOweRecordAmountStepContainer(
            recordDebtor: debtor,
            oweRecordType: OweType.debt,
            fromDebtorPage: true,
          ),
        ),
      );

      await tester.enterText(find.byType(OweMeAmountTextFormField), '2500');
      await tester.pump();
      await tester.tap(find.text('Continuar'));
      await tester.pumpAndSettle();

      final descriptionField = tester.widget<EditableText>(
        find.descendant(
          of: find.byType(SetOweRecordDescriptionTextFormField),
          matching: find.byType(EditableText),
        ),
      );
      expect(descriptionField.controller.text, isEmpty);
    },
  );
}
