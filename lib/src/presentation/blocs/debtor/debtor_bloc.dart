import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/use_cases/debtor/edit_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/remove_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/load_debtor_monetary_record_history.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/remove_monetary_record_and_update_debtor.dart';

part 'debtor_event.dart';
part 'debtor_state.dart';

class DebtorBloc extends Bloc<DebtorEvent, DebtorState> {
  final LoadDebtorMonetaryRecordHistory _loadDebtorMonetaryRecordHistoryUseCase;
  final EditDebtor _editDebtorUseCase;
  final RemoveDebtor _removeDebtorUseCase;
  final RemoveMonetaryRecordAndUpdateDebtor _removeMonetaryRecordAndUpdateDebtorUseCase;
  late Debtor _debtor;

  DebtorBloc({
    required LoadDebtorMonetaryRecordHistory loadDebtorMonetaryRecordHistory,
    required EditDebtor editDebtor,
    required RemoveDebtor removeDebtor,
    required RemoveMonetaryRecordAndUpdateDebtor removeMonetaryRecordAndUpdateDebtor,
  })  : _loadDebtorMonetaryRecordHistoryUseCase = loadDebtorMonetaryRecordHistory,
        _editDebtorUseCase = editDebtor,
        _removeDebtorUseCase = removeDebtor,
        _removeMonetaryRecordAndUpdateDebtorUseCase = removeMonetaryRecordAndUpdateDebtor,
        super(DebtorMonetaryRecordHistoryInitial()) {
    on<DebtorPageInitialized>(_loadInitialData);
    on<DebtorMonetaryRecordHistoryLoadRequested>(_loadDebtorMonetaryRecordHistory);
    on<DebtorEditRequested>(_editDebtor);
    on<DebtorRemoveRequested>(_removeDebtor);
    on<DebtorRemoveMonetaryRecordRequested>(_removeDebtorMonetaryRecord);
  }

  FutureOr<void> _loadInitialData(
    DebtorPageInitialized event,
    Emitter<DebtorState> emit,
  ) {
    _loadDebtor(emit, event.debtor);
  }

  FutureOr<void> _loadDebtor(Emitter<DebtorState> emit, Debtor debtor) {
    emit(DebtorPageLoading());
    _debtor = debtor;
    emit(DebtorPageLoaded(debtor: _debtor));
    add(DebtorMonetaryRecordHistoryLoadRequested());
  }

  FutureOr<void> _loadDebtorMonetaryRecordHistory(
    DebtorMonetaryRecordHistoryLoadRequested event,
    Emitter<DebtorState> emit,
  ) async {
    emit(DebtorMonetaryRecordHistoryLoading());
    final response = await _loadDebtorMonetaryRecordHistoryUseCase(_debtor);
    response.fold(
      (exception) => emit(DebtorMonetaryRecordHistoryError(message: exception.message)),
      (monetaryRecordHistory) {
        if (monetaryRecordHistory.isEmpty) {
          emit(DebtorMonetaryRecordHistoryEmpty());
          return;
        }
        emit(
          DebtorMonetaryRecordHistoryLoaded(
            monetaryRecordHistory: monetaryRecordHistory,
            debtor: _debtor,
          ),
        );
      },
    );
  }

  FutureOr<void> _editDebtor(
    DebtorEditRequested event,
    Emitter<DebtorState> emit,
  ) async {
    emit(DebtorEditInProgress());
    final debtor = _debtor.copyWith(nickname: event.nickname);
    final response = await _editDebtorUseCase(
      debtor: debtor,
    );
    response.fold(
      (exception) => emit(DebtorEditError(message: exception.message)),
      (_) {
        _loadDebtor(emit, debtor);
        emit(DebtorEditSuccess());
      },
    );
  }

  FutureOr<void> _removeDebtor(
    DebtorRemoveRequested event,
    Emitter<DebtorState> emit,
  ) async {
    emit(DebtorRemoveInProgress());
    final response = await _removeDebtorUseCase(debtor: _debtor);
    response.fold(
      (exception) => emit(DebtorRemoveError(message: exception.message)),
      (_) {
        emit(DebtorRemoveSuccess());
      },
    );
  }

  FutureOr<void> _removeDebtorMonetaryRecord(
    DebtorRemoveMonetaryRecordRequested event,
    Emitter<DebtorState> emit,
  ) async {
    emit(DebtorRemoveMonetaryRecordInProgress());
    final response = await _removeMonetaryRecordAndUpdateDebtorUseCase(
      monetaryRecord: event.monetaryRecord,
      recordDebtor: _debtor,
    );
    response.fold(
      (exception) => emit(DebtorRemoveMonetaryRecordError(message: exception.message)),
      (updatedDebtor) {
        emit(DebtorRemoveMonetaryRecordSuccess(updatedDebtor: updatedDebtor));
      },
    );
  }
}
