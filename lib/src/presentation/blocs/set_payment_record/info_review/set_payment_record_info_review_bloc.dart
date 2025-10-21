import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/presentation/models/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/models/mappers/payment_record_mapper.dart';

part 'set_payment_record_info_review_event.dart';
part 'set_payment_record_info_review_state.dart';

class SetPaymentRecordInfoReviewBloc
    extends Bloc<SetPaymentRecordInfoReviewEvent, SetPaymentRecordInfoReviewState> {
  late PaymentRecordDraft _paymentRecordDraft;
  late Debtor _recordDebtor;
  PaymentRecord? _paymentRecordToEdit;
  final AddMonetaryRecordAndUpdateDebtor _addMonetaryRecordAndUpdateDebtorUseCase;
  final EditMonetaryRecordAndUpdateDebtor _editMonetaryRecordAndUpdateDebtorUseCase;

  bool get _isEdition => _paymentRecordToEdit != null;

  SetPaymentRecordInfoReviewBloc({
    required AddMonetaryRecordAndUpdateDebtor addMonetaryRecordAndUpdateDebtor,
    required EditMonetaryRecordAndUpdateDebtor editMonetaryRecordAndUpdateDebtor,
  })  : _addMonetaryRecordAndUpdateDebtorUseCase = addMonetaryRecordAndUpdateDebtor,
        _editMonetaryRecordAndUpdateDebtorUseCase = editMonetaryRecordAndUpdateDebtor,
        super(SetPaymentRecordInfoReviewInitial()) {
    on<SetPaymentRecordInfoReviewPageInitialized>(_loadInitialData);
    on<SetPaymentRecordInfoReviewSetRecordRequested>(_setPaymentRecord);
  }

  Future<void> _loadInitialData(
    SetPaymentRecordInfoReviewPageInitialized event,
    Emitter<SetPaymentRecordInfoReviewState> emit,
  ) async {
    _paymentRecordDraft = event.paymentRecordDraft;
    _recordDebtor = event.recordDebtor;
    _paymentRecordToEdit = event.paymentRecordToEdit;
  }

  Future<void> _setPaymentRecord(
    SetPaymentRecordInfoReviewSetRecordRequested event,
    Emitter<SetPaymentRecordInfoReviewState> emit,
  ) async {
    emit(SetPaymentRecordInfoReviewSettingRecord());
    try {
      final paymentRecord = PaymentRecordMapper.toEntity(_paymentRecordDraft);

      final result = _isEdition
          ? await _editMonetaryRecordAndUpdateDebtorUseCase(
              newMonetaryRecord: paymentRecord.copyWith(id: _paymentRecordToEdit!.id),
              oldMonetaryRecord: _paymentRecordToEdit!,
              recordDebtor: _recordDebtor,
            )
          : await _addMonetaryRecordAndUpdateDebtorUseCase(
              monetaryRecord: paymentRecord,
              recordDebtor: _recordDebtor,
            );
      result.fold(
        (failure) {
          //TODO Handle failure case
          emit(SetPaymentRecordInfoReviewError());
        },
        (updatedDebtor) => emit(
          SetPaymentRecordInfoReviewRecordSetFinished(updatedDebtor: updatedDebtor),
        ),
      );
    } catch (e) {
      //TODO Handle specific error cases
      emit(SetPaymentRecordInfoReviewError());
    }
  }
}
