import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/add_debtor.dart';
import 'package:owe_me/src/domain/use_cases/debtor/load_debtors.dart';

part 'home_debtors_event.dart';
part 'home_debtors_state.dart';

class HomeDebtorsBloc extends Bloc<HomeDebtorsEvent, HomeDebtorsState> {
  final LoadDebtors _loadDebtorsUseCase;
  final AddDebtor _addDebtorUseCase;
  List<Debtor> _debtors = [];

  HomeDebtorsBloc({
    required LoadDebtors loadDebtors,
    required AddDebtor addDebtor,
  })  : _loadDebtorsUseCase = loadDebtors,
        _addDebtorUseCase = addDebtor,
        super(HomeDebtorsInitial()) {
    on<HomeLoadDebtorsRequested>(_loadDebtors);
    on<HomeAddDebtorRequested>(_addNewDebtor);
  }

  FutureOr<void> _loadDebtors(
    HomeLoadDebtorsRequested event,
    Emitter<HomeDebtorsState> emit,
  ) async {
    emit(HomeDebtorsLoading());
    final response = await _loadDebtorsUseCase();
    response.fold(
      (exception) => emit(HomeDebtorsError()),
      (debtors) {
        _debtors = debtors;
        emit(HomeDebtorsLoaded(debtors: _debtors));
      },
    );
  }

  FutureOr<void> _addNewDebtor(
    HomeAddDebtorRequested event,
    Emitter<HomeDebtorsState> emit,
  ) async {
    emit(HomeDebtorsLoading());
    final response = await _addDebtorUseCase(
      debtor: Debtor(nickname: event.debtorNickname),
    );
    response.fold(
      (exception) => emit(HomeDebtorsError()),
      (savedDebtor) {
        _debtors.add(savedDebtor);
        emit(HomeDebtorsLoaded(debtors: _debtors));
      },
    );
  }
}
