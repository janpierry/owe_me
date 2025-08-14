import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record.dart';
import 'package:owe_me/src/presentation/drafts/payment_record_draft.dart';
import 'package:owe_me/src/presentation/mappers/payment_record_mapper.dart';

part 'set_payment_record_info_review_event.dart';
part 'set_payment_record_info_review_state.dart';

class SetPaymentRecordInfoReviewBloc
    extends Bloc<SetPaymentRecordInfoReviewEvent, SetPaymentRecordInfoReviewState> {
  late PaymentRecordDraft _paymentRecordDraft;
  late Debtor _recordDebtor;
  final AddMonetaryRecord _addMonetaryRecordUseCase;

  SetPaymentRecordInfoReviewBloc({
    required AddMonetaryRecord addMonetaryRecord,
  })  : _addMonetaryRecordUseCase = addMonetaryRecord,
        super(SetPaymentRecordInfoReviewInitial()) {
    on<SetPaymentRecordInfoReviewPageInitializedEvent>(_loadInitialData);
    on<SetPaymentRecordInfoReviewSetRecordRequested>(_setPaymentRecord);
  }

  Future<void> _loadInitialData(
    SetPaymentRecordInfoReviewPageInitializedEvent event,
    Emitter<SetPaymentRecordInfoReviewState> emit,
  ) async {
    _paymentRecordDraft = event.paymentRecordDraft;
    _recordDebtor = event.recordDebtor;
  }

  Future<void> _setPaymentRecord(
    SetPaymentRecordInfoReviewSetRecordRequested event,
    Emitter<SetPaymentRecordInfoReviewState> emit,
  ) async {
    emit(SetPaymentRecordInfoReviewSettingRecord());
    try {
      final paymentRecord = PaymentRecordMapper.toEntity(_paymentRecordDraft);
      final result = await _addMonetaryRecordUseCase(
        monetaryRecord: paymentRecord,
        recordDebtor: _recordDebtor,
      );
      if (result.isLeft()) {
        //TODO Handle failure case
        emit(SetPaymentRecordInfoReviewError());
        return;
      }
      emit(SetPaymentRecordInfoReviewRecordSetFinished());
    } catch (e) {
      //TODO Handle specific error cases
      emit(SetPaymentRecordInfoReviewError());
    }
  }
}
