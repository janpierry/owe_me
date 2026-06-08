import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/add_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/edit_monetary_record_and_update_debtor.dart';
import 'package:owe_me/src/presentation/models/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';

part 'set_owe_record_info_review_event.dart';
part 'set_owe_record_info_review_state.dart';

class SetOweRecordInfoReviewBloc
    extends Bloc<SetOweRecordInfoReviewEvent, SetOweRecordInfoReviewState> {
  late OweRecordDraft _oweRecordDraft;
  late Debtor _recordDebtor;
  OweRecord? _oweRecordToEdit;
  final AddMonetaryRecordAndUpdateDebtor _addMonetaryRecordAndUpdateDebtorUseCase;
  final EditMonetaryRecordAndUpdateDebtor _editMonetaryRecordAndUpdateDebtorUseCase;

  bool get _isEdition => _oweRecordToEdit != null;

  SetOweRecordInfoReviewBloc({
    required AddMonetaryRecordAndUpdateDebtor addMonetaryRecordAndUpdateDebtor,
    required EditMonetaryRecordAndUpdateDebtor editMonetaryRecordAndUpdateDebtor,
  })  : _addMonetaryRecordAndUpdateDebtorUseCase = addMonetaryRecordAndUpdateDebtor,
        _editMonetaryRecordAndUpdateDebtorUseCase = editMonetaryRecordAndUpdateDebtor,
        super(SetOweRecordInfoReviewInitial()) {
    on<SetOweRecordInfoReviewPageInitialized>(_loadInitialData);
    on<SetOweRecordInfoReviewSetRecordRequested>(_setOweRecord);
  }

  Future<void> _loadInitialData(
    SetOweRecordInfoReviewPageInitialized event,
    Emitter<SetOweRecordInfoReviewState> emit,
  ) async {
    _oweRecordDraft = event.oweRecordDraft;
    _recordDebtor = event.recordDebtor;
    _oweRecordToEdit = event.oweRecordToEdit;
  }

  Future<void> _setOweRecord(
    SetOweRecordInfoReviewSetRecordRequested event,
    Emitter<SetOweRecordInfoReviewState> emit,
  ) async {
    emit(SetOweRecordInfoReviewSettingRecord());
    try {
      final value = _oweRecordDraft.toEntity();
      if (value.isLeft()) {
        final failure = value.asLeft();
        emit(SetOweRecordInfoReviewError(message: failure.message));
        return;
      }

      final oweRecord = value.asRight();
      var recordToSave = oweRecord;
      if (_isEdition) {
        final editedRecord = oweRecord.copyWith(id: _oweRecordToEdit!.id);
        if (editedRecord.isLeft()) {
          emit(SetOweRecordInfoReviewError());
          return;
        }
        recordToSave = editedRecord.asRight();
      }
      final result = _isEdition
          ? await _editMonetaryRecordAndUpdateDebtorUseCase(
              newMonetaryRecord: recordToSave,
              oldMonetaryRecord: _oweRecordToEdit!,
              recordDebtor: _recordDebtor,
            )
          : await _addMonetaryRecordAndUpdateDebtorUseCase(
              monetaryRecord: recordToSave,
              recordDebtor: _recordDebtor,
            );

      result.fold(
        (failure) {
          //TODO Handle failure case
          emit(SetOweRecordInfoReviewError());
        },
        (updatedDebtor) => emit(
          SetOweRecordInfoReviewRecordSetFinished(updatedDebtor: updatedDebtor),
        ),
      );
    } catch (e) {
      //TODO Handle specific error cases
      emit(SetOweRecordInfoReviewError());
    }
  }
}
