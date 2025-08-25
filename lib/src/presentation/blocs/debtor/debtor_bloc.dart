import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/use_cases/debtor/edit_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/remove_debtor.dart';
import 'package:owe_me/src/domain/use_cases/monetary_record/load_debtor_monetary_record_history.dart';

part 'debtor_event.dart';
part 'debtor_state.dart';

class DebtorBloc extends Bloc<DebtorEvent, DebtorState> {
  final LoadDebtorMonetaryRecordHistory _loadDebtorMonetaryRecordHistoryUseCase;
  final EditDebtor _editDebtorUseCase;
  final RemoveDebtor _removeDebtorUseCase;
  late Debtor _debtor;

  DebtorBloc({
    required LoadDebtorMonetaryRecordHistory loadDebtorMonetaryRecordHistory,
    required EditDebtor editDebtor,
    required RemoveDebtor removeDebtor,
  })  : _loadDebtorMonetaryRecordHistoryUseCase = loadDebtorMonetaryRecordHistory,
        _editDebtorUseCase = editDebtor,
        _removeDebtorUseCase = removeDebtor,
        super(DebtorMonetaryRecordHistoryInitial()) {
    on<DebtorPageInitializedEvent>(_loadInitialData);
    on<DebtorMonetaryRecordHistoryLoadRequestedEvent>(_loadDebtorMonetaryRecordHistory);
    on<DebtorEditRequestedEvent>(_editDebtor);
    on<DebtorRemoveRequestedEvent>(_removeDebtor);
  }

  FutureOr<void> _loadInitialData(
    DebtorPageInitializedEvent event,
    Emitter<DebtorState> emit,
  ) {
    _loadDebtor(emit, event.debtor);
  }

  FutureOr<void> _loadDebtor(Emitter<DebtorState> emit, Debtor debtor) {
    emit(DebtorPageLoading());
    _debtor = debtor;
    emit(DebtorPageLoaded(debtor: _debtor));
    add(DebtorMonetaryRecordHistoryLoadRequestedEvent());
  }

  FutureOr<void> _loadDebtorMonetaryRecordHistory(
    DebtorMonetaryRecordHistoryLoadRequestedEvent event,
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
          DebtorMonetaryRecordHistoryLoaded(monetaryRecordHistory: monetaryRecordHistory),
        );
      },
    );
  }

  FutureOr<void> _editDebtor(
    DebtorEditRequestedEvent event,
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
    DebtorRemoveRequestedEvent event,
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
}
