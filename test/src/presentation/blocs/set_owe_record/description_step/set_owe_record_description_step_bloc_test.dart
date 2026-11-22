import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/add_favorite_description.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_credits.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_debts.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/description_step/set_owe_record_description_step_bloc.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';

class MockAddFavoriteDescription extends Mock implements AddFavoriteDescription {}

class MockLoadDebtorFavoriteDebts extends Mock implements LoadDebtorFavoriteDebts {}

class MockLoadDebtorFavoriteCredits extends Mock implements LoadDebtorFavoriteCredits {}

/// Stands in for `SetOweRecordDescriptionTextFormField`: it shows whatever text
/// the bloc sends to it, and reports every change of its text back to the
/// bloc, the same way the real field's controller listener does.
class FakeDescriptionField {
  final SetOweRecordDescriptionStepBloc _bloc;
  late final StreamSubscription<SetOweRecordDescriptionStepState> _subscription;
  String text;

  FakeDescriptionField(this._bloc, {required this.text}) {
    _subscription = _bloc.stream.listen((state) {
      if (state is SetOweRecordDescriptionStepSendingDescriptionToTextField) {
        _changeText(state.description);
      }
    });
  }

  void type(String newText) => _changeText(newText);

  void _changeText(String newText) {
    text = newText;
    _bloc.add(SetOweRecordDescriptionStepDescriptionChanged(description: newText));
  }

  Future<void> dispose() => _subscription.cancel();
}

void main() {
  const amount = Money(cents: 2500);
  final debtor = Debtor.create(id: 1, nickname: 'João').asRight();
  final lunchFavorite = FavoriteDescription.create(
    id: 1,
    description: 'Almoço',
    favoriteType: OweType.debt,
  ).asRight();
  final recordToEdit = OweRecord.create(
    id: 7,
    amount: RecordAmount.create(amount).asRight(),
    date: DateTime(2026, 11, 1),
    description: 'Almoço',
    oweType: OweType.debt,
  ).asRight();

  late SetOweRecordDescriptionStepBloc bloc;
  late List<SetOweRecordDescriptionStepState> states;
  late StreamSubscription<SetOweRecordDescriptionStepState> statesSubscription;
  FakeDescriptionField? field;

  setUp(() {
    final loadDebtorFavoriteDebts = MockLoadDebtorFavoriteDebts();
    when(() => loadDebtorFavoriteDebts(debtor))
        .thenAnswer((_) async => Right([lunchFavorite]));

    bloc = SetOweRecordDescriptionStepBloc(
      addFavoriteDescription: MockAddFavoriteDescription(),
      loadDebtorFavoriteDebts: loadDebtorFavoriteDebts,
      loadDebtorFavoriteCredits: MockLoadDebtorFavoriteCredits(),
    );
    states = [];
    statesSubscription = bloc.stream.listen(states.add);
  });

  tearDown(() async {
    await field?.dispose();
    field = null;
    await statesSubscription.cancel();
    await bloc.close();
  });

  /// Opens the step and returns the field it builds, filled with the
  /// description the bloc chose to show.
  Future<FakeDescriptionField> openStep(OweRecordDraft draft) async {
    bloc.add(
      SetOweRecordDescriptionStepPageInitialized(
        oweRecordDraft: draft,
        recordDebtor: debtor,
      ),
    );
    await pumpEventQueue();
    final loaded = states.whereType<SetOweRecordDescriptionStepPageLoaded>().single;
    return field = FakeDescriptionField(bloc, text: loaded.initialDescription);
  }

  Future<void> type(String text) async {
    field!.type(text);
    await pumpEventQueue();
  }

  /// Taps "Continuar" / "Salvar alterações" and returns the draft the step
  /// hands to the next page.
  Future<OweRecordDraft> continueToNextPage() async {
    bloc.add(SetOweRecordDescriptionStepNextPageRequested());
    await pumpEventQueue();
    return states
        .whereType<SetOweRecordDescriptionStepNavigatingToNextPage>()
        .last
        .oweRecordDraft;
  }

  group('clearing the description', () {
    test(
      'new record: clearing a description set earlier removes it from the draft',
      () async {
        // Coming back from the review page with a description already chosen.
        final draft = OweRecordDraft(
          oweType: OweType.debt,
          amount: amount,
          description: 'Almoço',
        );
        final field = await openStep(draft);
        expect(field.text, 'Almoço');

        await type('');
        final nextDraft = await continueToNextPage();

        expect(nextDraft.description, isNull);
      },
    );

    test(
      'edited record: clearing the description it started with removes it',
      () async {
        // The edit flow starts the draft with the record's description.
        final draft = OweRecordDraft(
          oweType: OweType.debt,
          amount: amount,
          description: recordToEdit.description,
        );
        final field = await openStep(draft);
        expect(field.text, 'Almoço');

        await type('');
        final nextDraft = await continueToNextPage();

        expect(nextDraft.description, isNull);
      },
    );

    test(
      'edited record: a cleared description stays cleared when the step is '
      'opened again from the review page',
      () async {
        // The record still has "Almoço", but the user already cleared it, so
        // the draft coming back from the review page has no description.
        final clearedDraft = OweRecordDraft(oweType: OweType.debt, amount: amount);
        final field = await openStep(clearedDraft);
        expect(field.text, isEmpty);

        final nextDraft = await continueToNextPage();

        expect(nextDraft.description, isNull);
      },
    );
  });
}
