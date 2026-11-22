import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/error/failures/failures.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/failures/owe_record_failures.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';
import 'package:owe_me/src/presentation/blocs/set_owe_record/info_review/set_owe_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';

class _MockAddMonetaryRecordAndUpdateDebtor extends Mock
    implements AddMonetaryRecordAndUpdateDebtor {}

class _MockEditMonetaryRecordAndUpdateDebtor extends Mock
    implements EditMonetaryRecordAndUpdateDebtor {}

class _MockOweRecordDraft extends Mock implements OweRecordDraft {}

class _MockOweRecord extends Mock implements OweRecord {}

// RecordAmount has no value equality, so two OweRecords built from the same
// data are not ==. Compare field by field instead.
Matcher _isOweRecordLike(OweRecord expected) => isA<OweRecord>()
    .having((r) => r.id, 'id', expected.id)
    .having((r) => r.amount.value, 'amount', expected.amount.value)
    .having((r) => r.date, 'date', expected.date)
    .having((r) => r.description, 'description', expected.description)
    .having((r) => r.oweType, 'oweType', expected.oweType);

void main() {
  late _MockAddMonetaryRecordAndUpdateDebtor mockAdd;
  late _MockEditMonetaryRecordAndUpdateDebtor mockEdit;
  late SetOweRecordInfoReviewBloc bloc;

  final tDebtor = Debtor.create(
    id: 1,
    nickname: 'João',
    totalDebt: const Money(cents: 10000),
  ).asRight();
  final tUpdatedDebtor = tDebtor
      .copyWith(totalDebt: const Money(cents: 15000))
      .asRight();
  final tDraft = OweRecordDraft(
    amount: const Money(cents: 5000),
    description: 'Almoço',
    date: DateTime(2026, 1, 15),
    oweType: OweType.debt,
  );
  final tRecordFromDraft = tDraft.toEntity().asRight();
  final tRecordToEdit = OweRecord.create(
    id: 42,
    amount: RecordAmount.create(const Money(cents: 3000)).asRight(),
    date: DateTime(2026, 1, 10),
    description: 'Jantar',
    oweType: OweType.debt,
  ).asRight();

  setUpAll(() {
    registerFallbackValue(tRecordFromDraft);
    registerFallbackValue(tDebtor);
  });

  setUp(() {
    mockAdd = _MockAddMonetaryRecordAndUpdateDebtor();
    mockEdit = _MockEditMonetaryRecordAndUpdateDebtor();
    bloc = SetOweRecordInfoReviewBloc(
      addMonetaryRecordAndUpdateDebtor: mockAdd,
      editMonetaryRecordAndUpdateDebtor: mockEdit,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  void initialize({OweRecordDraft? draft, OweRecord? recordToEdit}) {
    bloc.add(
      SetOweRecordInfoReviewPageInitialized(
        oweRecordDraft: draft ?? tDraft,
        recordDebtor: tDebtor,
        oweRecordToEdit: recordToEdit,
      ),
    );
  }

  void stubAdd(Future<Either<Failure, Debtor>> Function() answer) {
    when(
      () => mockAdd(
        monetaryRecord: any(named: 'monetaryRecord'),
        recordDebtor: any(named: 'recordDebtor'),
      ),
    ).thenAnswer((_) => answer());
  }

  void stubEdit(Future<Either<Failure, Debtor>> Function() answer) {
    when(
      () => mockEdit(
        newMonetaryRecord: any(named: 'newMonetaryRecord'),
        oldMonetaryRecord: any(named: 'oldMonetaryRecord'),
        recordDebtor: any(named: 'recordDebtor'),
      ),
    ).thenAnswer((_) => answer());
  }

  group('SetOweRecordInfoReviewBloc', () {
    group('when adding a new record', () {
      test('emits [SettingRecord, RecordSetFinished] when the add use case succeeds', () async {
        stubAdd(() async => Right(tUpdatedDebtor));

        final expectation = expectLater(
          bloc.stream,
          emitsInOrder([
            SetOweRecordInfoReviewSettingRecord(),
            SetOweRecordInfoReviewRecordSetFinished(
              updatedDebtor: tUpdatedDebtor,
            ),
          ]),
        );
        initialize();
        bloc.add(SetOweRecordInfoReviewSetRecordRequested());
        await expectation;

        verify(
          () => mockAdd(
            monetaryRecord: any(
              named: 'monetaryRecord',
              that: _isOweRecordLike(tRecordFromDraft),
            ),
            recordDebtor: any(named: 'recordDebtor', that: equals(tDebtor)),
          ),
        ).called(1);
        verifyZeroInteractions(mockEdit);
      });

      test(
        'emits [SettingRecord, Error] when the add use case fails',
        () async {
          stubAdd(() async => const Left(DefaultFailure()));

          final expectation = expectLater(
            bloc.stream,
            emitsInOrder([
              SetOweRecordInfoReviewSettingRecord(),
              const SetOweRecordInfoReviewError(),
            ]),
          );
          initialize();
          bloc.add(SetOweRecordInfoReviewSetRecordRequested());
          await expectation;
        },
      );

      test(
        'emits [SettingRecord, Error] when the add use case throws',
        () async {
          stubAdd(() async => throw Exception('db exploded'));

          final expectation = expectLater(
            bloc.stream,
            emitsInOrder([
              SetOweRecordInfoReviewSettingRecord(),
              const SetOweRecordInfoReviewError(),
            ]),
          );
          initialize();
          bloc.add(SetOweRecordInfoReviewSetRecordRequested());
          await expectation;
        },
      );

      test('emits [SettingRecord, Error(message)] and saves nothing when the draft is invalid', () async {
        final expectation = expectLater(
          bloc.stream,
          emitsInOrder([
            SetOweRecordInfoReviewSettingRecord(),
            const SetOweRecordInfoReviewError(message: 'Data é obrigatória'),
          ]),
        );
        initialize(draft: tDraft.copyWith(removeDate: true));
        bloc.add(SetOweRecordInfoReviewSetRecordRequested());
        await expectation;

        verifyZeroInteractions(mockAdd);
        verifyZeroInteractions(mockEdit);
      });

      test('calls the add use case only once when save is requested twice in a row', () async {
        final saveCompleter = Completer<Either<Failure, Debtor>>();
        stubAdd(() => saveCompleter.future);

        initialize();
        bloc.add(SetOweRecordInfoReviewSetRecordRequested());
        bloc.add(SetOweRecordInfoReviewSetRecordRequested());
        await pumpEventQueue();

        saveCompleter.complete(Right(tUpdatedDebtor));
        await pumpEventQueue();

        verify(
          () => mockAdd(
            monetaryRecord: any(named: 'monetaryRecord'),
            recordDebtor: any(named: 'recordDebtor'),
          ),
        ).called(1);
        expect(
          bloc.state,
          SetOweRecordInfoReviewRecordSetFinished(
            updatedDebtor: tUpdatedDebtor,
          ),
        );
      });
    });

    group('when editing an existing record', () {
      test(
        'calls the edit use case with the draft record carrying the edited id',
        () async {
          stubEdit(() async => Right(tUpdatedDebtor));

          final expectation = expectLater(
            bloc.stream,
            emitsInOrder([
              SetOweRecordInfoReviewSettingRecord(),
              SetOweRecordInfoReviewRecordSetFinished(
                updatedDebtor: tUpdatedDebtor,
              ),
            ]),
          );
          initialize(recordToEdit: tRecordToEdit);
          bloc.add(SetOweRecordInfoReviewSetRecordRequested());
          await expectation;

          verify(
            () => mockEdit(
              newMonetaryRecord: any(
                named: 'newMonetaryRecord',
                that: _isOweRecordLike(
                  tRecordFromDraft.copyWith(id: 42).asRight(),
                ),
              ),
              oldMonetaryRecord: any(
                named: 'oldMonetaryRecord',
                that: same(tRecordToEdit),
              ),
              recordDebtor: any(named: 'recordDebtor', that: equals(tDebtor)),
            ),
          ).called(1);
          verifyZeroInteractions(mockAdd);
        },
      );

      test(
        'emits [SettingRecord, Error] when the edit use case fails',
        () async {
          stubEdit(() async => const Left(DefaultFailure()));

          final expectation = expectLater(
            bloc.stream,
            emitsInOrder([
              SetOweRecordInfoReviewSettingRecord(),
              const SetOweRecordInfoReviewError(),
            ]),
          );
          initialize(recordToEdit: tRecordToEdit);
          bloc.add(SetOweRecordInfoReviewSetRecordRequested());
          await expectation;
        },
      );

      test('emits [SettingRecord, Error] and saves nothing when copyWith returns Left', () async {
        final mockDraft = _MockOweRecordDraft();
        final mockRecord = _MockOweRecord();
        when(() => mockDraft.toEntity()).thenReturn(Right(mockRecord));
        when(
          () => mockRecord.copyWith(id: any(named: 'id')),
        ).thenReturn(Left(OweRecordValidationFailure(const DefaultFailure())));

        final expectation = expectLater(
          bloc.stream,
          emitsInOrder([
            SetOweRecordInfoReviewSettingRecord(),
            const SetOweRecordInfoReviewError(),
          ]),
        );
        initialize(draft: mockDraft, recordToEdit: tRecordToEdit);
        bloc.add(SetOweRecordInfoReviewSetRecordRequested());
        await expectation;

        verify(() => mockRecord.copyWith(id: 42)).called(1);
        verifyZeroInteractions(mockAdd);
        verifyZeroInteractions(mockEdit);
      });

      test('calls the edit use case only once when save is requested twice in a row', () async {
        final saveCompleter = Completer<Either<Failure, Debtor>>();
        stubEdit(() => saveCompleter.future);

        initialize(recordToEdit: tRecordToEdit);
        bloc.add(SetOweRecordInfoReviewSetRecordRequested());
        bloc.add(SetOweRecordInfoReviewSetRecordRequested());
        await pumpEventQueue();

        saveCompleter.complete(Right(tUpdatedDebtor));
        await pumpEventQueue();

        verify(
          () => mockEdit(
            newMonetaryRecord: any(named: 'newMonetaryRecord'),
            oldMonetaryRecord: any(named: 'oldMonetaryRecord'),
            recordDebtor: any(named: 'recordDebtor'),
          ),
        ).called(1);
        expect(
          bloc.state,
          SetOweRecordInfoReviewRecordSetFinished(
            updatedDebtor: tUpdatedDebtor,
          ),
        );
      });
    });
  });
}
