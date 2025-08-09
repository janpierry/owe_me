import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/monetary_record.dart';
import 'package:owe_me/domain/use_cases/debtor/edit_debtor.dart';
import 'package:owe_me/domain/use_cases/debtor/remove_debtor.dart';
import 'package:owe_me/domain/use_cases/monetary_record/load_debtor_monetary_record_history.dart';

part 'debtor_monetary_record_history_event.dart';
part 'debtor_monetary_record_history_state.dart';

//TODO this Bloc needs to be DebtorBloc
class DebtorMonetaryRecordHistoryBloc
    extends Bloc<DebtorMonetaryRecordHistoryEvent, DebtorMonetaryRecordHistoryState> {
  final LoadDebtorMonetaryRecordHistory _loadDebtorMonetaryRecordHistoryUseCase;
  final EditDebtor _editDebtorUseCase;
  final RemoveDebtor _removeDebtorUseCase;

  DebtorMonetaryRecordHistoryBloc({
    required LoadDebtorMonetaryRecordHistory loadDebtorMonetaryRecordHistory,
    required EditDebtor editDebtor,
    required RemoveDebtor removeDebtor,
  })  : _loadDebtorMonetaryRecordHistoryUseCase = loadDebtorMonetaryRecordHistory,
        _editDebtorUseCase = editDebtor,
        _removeDebtorUseCase = removeDebtor,
        super(DebtorMonetaryRecordHistoryInitial()) {
    on<LoadDebtorMonetaryRecordHistoryEvent>(_loadDebtorMonetaryRecordHistory);
    on<EditDebtorRequestedEvent>(_editDebtor);
    on<RemoveDebtorRequestedEvent>(_removeDebtor);
  }

  FutureOr<void> _loadDebtorMonetaryRecordHistory(
    LoadDebtorMonetaryRecordHistoryEvent event,
    Emitter<DebtorMonetaryRecordHistoryState> emit,
  ) async {
    emit(DebtorMonetaryRecordHistoryLoading());
    final response = await _loadDebtorMonetaryRecordHistoryUseCase(event.debtor);
    response.fold(
      (exception) => emit(DebtorMonetaryRecordHistoryError(message: exception.message)),
      (monetaryRecordHistory) {
        if (monetaryRecordHistory.isEmpty) {
          emit(DebtorMonetaryRecordHistoryEmpty());
          return;
        }
        emit(
          DebtorMonetaryRecordHistoryLoaded(monetaryRecordHistory: monetaryRecordHistory),
        );
      },
    );
  }

  FutureOr<void> _editDebtor(
    EditDebtorRequestedEvent event,
    Emitter<DebtorMonetaryRecordHistoryState> emit,
  ) async {
    emit(DebtorMonetaryRecordHistoryLoading());
    final response = await _editDebtorUseCase(debtor: event.debtor);
    response.fold(
      //TODO create custom error
      (exception) => emit(DebtorMonetaryRecordHistoryError(message: exception.message)),
      (_) {
        emit(EditDebtorSuccess(updatedDebtor: event.debtor));
      },
    );
  }

  FutureOr<void> _removeDebtor(
    RemoveDebtorRequestedEvent event,
    Emitter<DebtorMonetaryRecordHistoryState> emit,
  ) async {
    //TODO create custom loading
    emit(DebtorMonetaryRecordHistoryLoading());
    final response = await _removeDebtorUseCase(debtor: event.debtor);
    response.fold(
      //TODO create custom error
      (exception) => emit(DebtorMonetaryRecordHistoryError(message: exception.message)),
      (_) {
        emit(RemoveDebtorSuccess());
      },
    );
  }
}
