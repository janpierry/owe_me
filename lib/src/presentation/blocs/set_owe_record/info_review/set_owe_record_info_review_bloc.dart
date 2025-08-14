import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record.dart';
import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/presentation/mappers/owe_record_mapper.dart';

part 'set_owe_record_info_review_event.dart';
part 'set_owe_record_info_review_state.dart';

class SetOweRecordInfoReviewBloc
    extends Bloc<SetOweRecordInfoReviewEvent, SetOweRecordInfoReviewState> {
  late OweRecordDraft _oweRecordDraft;
  late Debtor _recordDebtor;
  final AddMonetaryRecord _addMonetaryRecordUseCase;

  SetOweRecordInfoReviewBloc({
    required AddMonetaryRecord addMonetaryRecord,
  })  : _addMonetaryRecordUseCase = addMonetaryRecord,
        super(SetOweRecordInfoReviewInitial()) {
    on<SetOweRecordInfoReviewPageInitializedEvent>(_loadInitialData);
    on<SetOweRecordInfoReviewSetRecordRequested>(_setOweRecord);
  }

  Future<void> _loadInitialData(
    SetOweRecordInfoReviewPageInitializedEvent event,
    Emitter<SetOweRecordInfoReviewState> emit,
  ) async {
    _oweRecordDraft = event.oweRecordDraft;
    _recordDebtor = event.recordDebtor;
  }

  Future<void> _setOweRecord(
    SetOweRecordInfoReviewSetRecordRequested event,
    Emitter<SetOweRecordInfoReviewState> emit,
  ) async {
    emit(SetOweRecordInfoReviewSettingRecord());
    try {
      final oweRecord = OweRecordMapper.toEntity(_oweRecordDraft);
      final result = await _addMonetaryRecordUseCase(
        monetaryRecord: oweRecord,
        recordDebtor: _recordDebtor,
      );
      if (result.isLeft()) {
        //TODO Handle failure case
        emit(SetOweRecordInfoReviewError());
        return;
      }
      emit(SetOweRecordInfoReviewRecordSetFinished());
    } catch (e) {
      //TODO Handle specific error cases
      emit(SetOweRecordInfoReviewError());
    }
  }
}
