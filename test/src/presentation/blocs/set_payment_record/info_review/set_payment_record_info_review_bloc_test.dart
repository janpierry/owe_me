import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mocktail/mocktail.dart';
import 'package:owe_me/src/core/error/failures/failures.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';
import 'package:owe_me/src/presentation/blocs/set_payment_record/info_review/set_payment_record_info_review_bloc.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';

class _MockAddMonetaryRecordAndUpdateDebtor extends Mock
    implements AddMonetaryRecordAndUpdateDebtor {}

class _MockEditMonetaryRecordAndUpdateDebtor extends Mock
    implements EditMonetaryRecordAndUpdateDebtor {}

// RecordAmount has no value equality, so two PaymentRecords built from the
// same data are not ==. Compare field by field instead.
Matcher _isPaymentRecordLike(PaymentRecord expected) => isA<PaymentRecord>()
    .having((r) => r.id, 'id', expected.id)
    .having((r) => r.amount.value, 'amount', expected.amount.value)
    .having((r) => r.date, 'date', expected.date)
    .having((r) => r.paymentMethod, 'paymentMethod', expected.paymentMethod);

void main() {
  late _MockAddMonetaryRecordAndUpdateDebtor mockAdd;
  late _MockEditMonetaryRecordAndUpdateDebtor mockEdit;
  late SetPaymentRecordInfoReviewBloc bloc;

  final tDebtor = Debtor.create(
    id: 1,
    nickname: 'João',
    totalDebt: const Money(cents: 10000),
  ).asRight();
  final tUpdatedDebtor = tDebtor
      .copyWith(totalDebt: const Money(cents: 5000))
      .asRight();
  final tDraft = PaymentRecordDraft(
    amount: const Money(cents: 5000),
    date: DateTime(2026, 1, 15),
    paymentMethod: PaymentMethod.pix,
  );
  final tRecordFromDraft = tDraft.toEntity().asRight();
  final tRecordToEdit = PaymentRecord(
    id: 42,
    amount: RecordAmount.create(const Money(cents: 3000)).asRight(),
    date: DateTime(2026, 1, 10),
    paymentMethod: PaymentMethod.cash,
  );

  setUpAll(() {
    registerFallbackValue(tRecordFromDraft);
    registerFallbackValue(tDebtor);
  });

  setUp(() {
    mockAdd = _MockAddMonetaryRecordAndUpdateDebtor();
    mockEdit = _MockEditMonetaryRecordAndUpdateDebtor();
    bloc = SetPaymentRecordInfoReviewBloc(
      addMonetaryRecordAndUpdateDebtor: mockAdd,
      editMonetaryRecordAndUpdateDebtor: mockEdit,
    );
  });

  tearDown(() async {
    await bloc.close();
  });

  void initialize({PaymentRecordDraft? draft, PaymentRecord? recordToEdit}) {
    bloc.add(
      SetPaymentRecordInfoReviewPageInitialized(
        paymentRecordDraft: draft ?? tDraft,
        recordDebtor: tDebtor,
        paymentRecordToEdit: recordToEdit,
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

  group('SetPaymentRecordInfoReviewBloc', () {
    group('when adding a new record', () {
      test('emits [SettingRecord, RecordSetFinished] when the add use case succeeds', () async {
        stubAdd(() async => Right(tUpdatedDebtor));

        final expectation = expectLater(
          bloc.stream,
          emitsInOrder([
            SetPaymentRecordInfoReviewSettingRecord(),
            SetPaymentRecordInfoReviewRecordSetFinished(
              updatedDebtor: tUpdatedDebtor,
            ),
          ]),
        );
        initialize();
        bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
        await expectation;

        verify(
          () => mockAdd(
            monetaryRecord: any(
              named: 'monetaryRecord',
              that: _isPaymentRecordLike(tRecordFromDraft),
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
              SetPaymentRecordInfoReviewSettingRecord(),
              const SetPaymentRecordInfoReviewError(),
            ]),
          );
          initialize();
          bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
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
              SetPaymentRecordInfoReviewSettingRecord(),
              const SetPaymentRecordInfoReviewError(),
            ]),
          );
          initialize();
          bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
          await expectation;
        },
      );

      test('emits [SettingRecord, Error(message)] and saves nothing when the draft is invalid', () async {
        final expectation = expectLater(
          bloc.stream,
          emitsInOrder([
            SetPaymentRecordInfoReviewSettingRecord(),
            const SetPaymentRecordInfoReviewError(
              message: 'Método de pagamento é obrigatório',
            ),
          ]),
        );
        initialize(draft: tDraft.copyWith(removePaymentMethod: true));
        bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
        await expectation;

        verifyZeroInteractions(mockAdd);
        verifyZeroInteractions(mockEdit);
      });

      test('calls the add use case only once when save is requested twice in a row', () async {
        final saveCompleter = Completer<Either<Failure, Debtor>>();
        stubAdd(() => saveCompleter.future);

        initialize();
        bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
        bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
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
          SetPaymentRecordInfoReviewRecordSetFinished(
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
              SetPaymentRecordInfoReviewSettingRecord(),
              SetPaymentRecordInfoReviewRecordSetFinished(
                updatedDebtor: tUpdatedDebtor,
              ),
            ]),
          );
          initialize(recordToEdit: tRecordToEdit);
          bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
          await expectation;

          verify(
            () => mockEdit(
              newMonetaryRecord: any(
                named: 'newMonetaryRecord',
                that: _isPaymentRecordLike(tRecordFromDraft.copyWith(id: 42)),
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
              SetPaymentRecordInfoReviewSettingRecord(),
              const SetPaymentRecordInfoReviewError(),
            ]),
          );
          initialize(recordToEdit: tRecordToEdit);
          bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
          await expectation;
        },
      );

      test('calls the edit use case only once when save is requested twice in a row', () async {
        final saveCompleter = Completer<Either<Failure, Debtor>>();
        stubEdit(() => saveCompleter.future);

        initialize(recordToEdit: tRecordToEdit);
        bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
        bloc.add(SetPaymentRecordInfoReviewSetRecordRequested());
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
          SetPaymentRecordInfoReviewRecordSetFinished(
            updatedDebtor: tUpdatedDebtor,
          ),
        );
      });
    });
  });
}
