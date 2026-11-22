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
import 'package:owe_me/src/presentation/widgets/shared/owe_me_elevated_button.dart';

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

  group('the "Continuar" button', () {
    const screen = Size(390, 844);

    Future<void> pumpPage(
      WidgetTester tester,
      MediaQueryData mediaQuery,
    ) async {
      tester.view
        ..physicalSize = screen
        ..devicePixelRatio = 1;
      addTearDown(tester.view.reset);

      await tester.pumpWidget(
        MediaQuery(
          data: mediaQuery.copyWith(size: screen),
          child: MaterialApp(
            home: SetOweRecordAmountStepContainer(
              recordDebtor: debtor,
              oweRecordType: OweType.debt,
              fromDebtorPage: true,
            ),
          ),
        ),
      );
    }

    double continueButtonBottom(WidgetTester tester) => tester
        .getBottomLeft(find.widgetWithText(OweMeElevatedButton, 'Continuar'))
        .dy;

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

    // The amount field takes focus on open, so this is how the step first
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
