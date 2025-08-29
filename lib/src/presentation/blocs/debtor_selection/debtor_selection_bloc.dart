import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/load_debtors.dart';

part 'debtor_selection_event.dart';
part 'debtor_selection_state.dart';

class DebtorSelectionBloc extends Bloc<DebtorSelectionEvent, DebtorSelectionState> {
  final LoadDebtors _loadDebtorsUseCase;

  DebtorSelectionBloc({
    required LoadDebtors loadDebtors,
  })  : _loadDebtorsUseCase = loadDebtors,
        super(DebtorSelectionLoadDebtorsInitial()) {
    on<DebtorSelectionLoadDebtorsRequested>(_loadDebtors);
  }

  FutureOr<void> _loadDebtors(
    DebtorSelectionLoadDebtorsRequested event,
    Emitter<DebtorSelectionState> emit,
  ) async {
    emit(DebtorSelectionLoadDebtorsInProgress());
    final response = await _loadDebtorsUseCase();
    response.fold(
      (exception) => emit(DebtorSelectionLoadDebtorsError()),
      (debtors) {
        emit(DebtorSelectionLoadDebtorsSuccess(debtors: debtors));
      },
    );
  }
}
