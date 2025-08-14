import 'dart:async';

import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/domain/entities/money.dart';

part 'set_owe_record_amount_step_event.dart';
part 'set_owe_record_amount_step_state.dart';

class SetOweRecordAmountStepBloc
    extends Bloc<SetOweRecordAmountStepEvent, SetOweRecordAmountStepState> {
  late Money _amount;

  SetOweRecordAmountStepBloc() : super(SetOweRecordAmountStepInitial()) {
    on<SetOweRecordAmountStepPageInitializedEvent>(_loadInitialData);
    on<SetOweRecordAmountStepAmountChangedEvent>(_setAmount);
    on<SetOweRecordAmountStepNextPageRequestedEvent>(_sendAmountToNavigateToNextPage);
  }

  FutureOr<void> _loadInitialData(
    SetOweRecordAmountStepPageInitializedEvent event,
    Emitter<SetOweRecordAmountStepState> emit,
  ) async {
    emit(SetOweRecordAmountStepPageLoading());
    _amount = event.amountToEdit ?? const Money(cents: 0);
    emit(SetOweRecordAmountStepPageLoaded(amountToEdit: _amount));
  }

  FutureOr<void> _setAmount(
    SetOweRecordAmountStepAmountChangedEvent event,
    Emitter<SetOweRecordAmountStepState> emit,
  ) async {
    _amount = event.amount;
  }

  FutureOr<void> _sendAmountToNavigateToNextPage(
    SetOweRecordAmountStepNextPageRequestedEvent event,
    Emitter<SetOweRecordAmountStepState> emit,
  ) async {
    emit(SetOweRecordAmountStepLoading());
    //TODO validate amount
    emit(SetOweRecordAmountStepNavigatingToNextPage(amount: _amount));
  }
}
