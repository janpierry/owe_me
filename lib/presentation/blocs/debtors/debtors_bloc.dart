import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/use_cases/debtor/add_debtor.dart';
import 'package:owe_me/domain/use_cases/debtor/load_debtors.dart';

part 'debtors_event.dart';
part 'debtors_state.dart';

//TODO Have a single bloc for each page. Will be better to handle behaviors
class DebtorsBloc extends Bloc<DebtorsEvent, DebtorsState> {
  final LoadDebtors _loadDebtorsUseCase;
  final AddDebtor _addDebtorUseCase;
  List<Debtor> _debtors = [];

  DebtorsBloc({
    required LoadDebtors loadDebtors,
    required AddDebtor addDebtor,
  })  : _loadDebtorsUseCase = loadDebtors,
        _addDebtorUseCase = addDebtor,
        super(DebtorsInitial()) {
    on<LoadDebtorsRequestedEvent>(_loadDebtors);
    on<AddDebtorRequestedEvent>(_addNewDebtor);
  }

  FutureOr<void> _loadDebtors(
    LoadDebtorsRequestedEvent event,
    Emitter<DebtorsState> emit,
  ) async {
    emit(DebtorsLoading());
    final response = await _loadDebtorsUseCase();
    response.fold(
      (exception) => emit(DebtorsError()),
      (debtors) {
        _debtors = debtors;
        emit(DebtorsLoaded(debtors: _debtors));
      },
    );
  }

  FutureOr<void> _addNewDebtor(
    AddDebtorRequestedEvent event,
    Emitter<DebtorsState> emit,
  ) async {
    emit(DebtorsLoading());
    final response = await _addDebtorUseCase(
      debtor: Debtor(name: event.debtorName),
    );
    response.fold(
      (exception) => emit(DebtorsError()),
      (savedDebtor) {
        _debtors.add(savedDebtor);
        emit(DebtorsLoaded(debtors: _debtors));
      },
    );
  }
}
