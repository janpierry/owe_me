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
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/presentation/containers/set_owe_record/set_owe_record_description_step_container.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

class _MockAddFavoriteDescription extends Mock
    implements AddFavoriteDescription {}

class _MockLoadDebtorFavoriteDebts extends Mock
    implements LoadDebtorFavoriteDebts {}

class _MockLoadDebtorFavoriteCredits extends Mock
    implements LoadDebtorFavoriteCredits {}

void main() {
  const screen = Size(390, 844);

  final debtor = Debtor.create(id: 1, nickname: 'João').asRight();

  setUp(() {
    final loadDebtorFavoriteDebts = _MockLoadDebtorFavoriteDebts();
    when(() => loadDebtorFavoriteDebts(debtor))
        .thenAnswer((_) async => const Right([]));

    GetIt.instance.registerFactory<SetOweRecordDescriptionStepBloc>(
      () => SetOweRecordDescriptionStepBloc(
        addFavoriteDescription: _MockAddFavoriteDescription(),
        loadDebtorFavoriteDebts: loadDebtorFavoriteDebts,
        loadDebtorFavoriteCredits: _MockLoadDebtorFavoriteCredits(),
      ),
    );
  });

  tearDown(() => GetIt.instance.reset());

  testWidgets('"Continuar" sits above the iPhone home indicator', (
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
        ),
        child: MaterialApp(
          home: SetOweRecordDescriptionStepContainer(
            oweRecordDraft: OweRecordDraft(
              amount: const Money(cents: 2500),
              oweType: OweType.debt,
            ),
            recordDebtor: debtor,
            oweRecordToEdit: null,
            isReviewing: false,
            fromDebtorPage: false,
          ),
        ),
      ),
    );
    await tester.pumpAndSettle();

    expect(
      tester
          .getBottomLeft(find.widgetWithText(OweMeElevatedButton, 'Continuar'))
          .dy,
      lessThanOrEqualTo(844 - 34 - 16),
    );
  });
}
