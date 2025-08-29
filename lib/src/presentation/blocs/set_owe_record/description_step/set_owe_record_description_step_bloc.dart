import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/core/shared/error/failures.dart';
import 'package:owe_me/src/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/src/domain/entities/debtor.dart';
import 'package:owe_me/src/domain/entities/favorite_description.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/add_favorite_description.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_credits.dart';
import 'package:owe_me/src/domain/use_cases/favorite_descriptions/load_debtor_favorite_debts.dart';

part 'set_owe_record_description_step_event.dart';
part 'set_owe_record_description_step_state.dart';

class SetOweRecordDescriptionStepBloc
    extends Bloc<SetOweRecordDescriptionStepEvent, SetOweRecordDescriptionStepState> {
  late String _description;
  late List<FavoriteDescription> _favoriteDescriptions;
  late final OweRecordDraft _initialOweRecordDraft;
  late final Debtor _initialRecordDebtor;
  late bool _isEdition;
  final AddFavoriteDescription _addFavoriteDescriptionUseCase;
  final LoadDebtorFavoriteDebts _loadDebtorFavoriteDebtsUseCase;
  final LoadDebtorFavoriteCredits _loadDebtorFavoriteCreditsUseCase;

  SetOweRecordDescriptionStepBloc({
    required AddFavoriteDescription addFavoriteDescription,
    required LoadDebtorFavoriteDebts loadDebtorFavoriteDebts,
    required LoadDebtorFavoriteCredits loadDebtorFavoriteCredits,
  })  : _addFavoriteDescriptionUseCase = addFavoriteDescription,
        _loadDebtorFavoriteDebtsUseCase = loadDebtorFavoriteDebts,
        _loadDebtorFavoriteCreditsUseCase = loadDebtorFavoriteCredits,
        super(SetOweRecordDescriptionStepInitial()) {
    on<SetOweRecordDescriptionStepPageInitialized>(_loadInitialData);
    on<SetOweRecordDescriptionStepDescriptionChanged>(_setDescription);
    on<SetOweRecordDescriptionStepFavoriteDescriptionSelected>(
      _setDescriptionAndSendValueToTextField,
    );
    on<SetOweRecordDescriptionStepDescriptionAddedToFavorites>(
      _addDescriptionToFavorites,
    );
    on<SetOweRecordDescriptionStepNextPageRequested>(
      _sendDescriptionToNavigateToNextPage,
    );
  }

  OweType get _oweRecordType => _initialOweRecordDraft.oweType;

  FutureOr<void> _loadInitialData(
    SetOweRecordDescriptionStepPageInitialized event,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) async {
    emit(SetOweRecordDescriptionStepPageLoading());
    final oweRecordDraft = event.oweRecordDraft;
    final oweRecordType = oweRecordDraft.oweType;
    final recordDebtor = event.recordDebtor;

    _description = oweRecordDraft.description ?? '';
    _initialOweRecordDraft = oweRecordDraft;
    _initialRecordDebtor = recordDebtor;
    _isEdition = oweRecordDraft.date != null;

    final result = await _loadFavoriteDescriptions(oweRecordType, recordDebtor);
    if (result.isLeft()) {
      emit(SetOweRecordDescriptionStepPageError());
      return;
    }
    _favoriteDescriptions = result.getOrElse(() => []);

    emit(
      SetOweRecordDescriptionStepPageLoaded(
        initialDescription: _description,
        initialFavoriteDescriptions: _favoriteDescriptions,
        oweRecordType: oweRecordType,
      ),
    );
  }

  FutureOr<Either<Failure, List<FavoriteDescription>>> _loadFavoriteDescriptions(
    OweType oweRecordType,
    Debtor debtor,
  ) async {
    final favoriteDescriptions = switch (oweRecordType) {
      OweType.debt => await _loadDebtorFavoriteDebtsUseCase(debtor),
      OweType.credit => await _loadDebtorFavoriteCreditsUseCase(debtor),
    };

    return favoriteDescriptions;
  }

  FutureOr<void> _setDescription(
    SetOweRecordDescriptionStepDescriptionChanged event,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) async {
    _description = event.description;
  }

  FutureOr<void> _setDescriptionAndSendValueToTextField(
    SetOweRecordDescriptionStepFavoriteDescriptionSelected event,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) async {
    _description = event.selectedDescription.description;
    emit(
      SetOweRecordDescriptionStepSendingDescriptionToTextField(description: _description),
    );
  }

  FutureOr<void> _addDescriptionToFavorites(
    SetOweRecordDescriptionStepDescriptionAddedToFavorites event,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) async {
    emit(SetOweRecordDescriptionStepFavoriteDescriptionsLoading());

    final isDescriptionValid = _validateDescriptionToAddToFavorites(_description, emit);
    if (!isDescriptionValid) {
      return;
    }

    final newFavoriteDescription =
        FavoriteDescription(description: _description, favoriteType: _oweRecordType);

    final result = await _addFavoriteDescriptionUseCase(
      AddFavoriteDescriptionParams(
        debtor: _initialRecordDebtor,
        favoriteDescription: newFavoriteDescription,
      ),
    );
    if (result.isLeft()) {
      emit(SetOweRecordDescriptionStepFavoriteDescriptionsError(
        //TODO map failures to messages
        message: result.asLeft().message,
      ));
      return;
    }

    _favoriteDescriptions.add(newFavoriteDescription);
    _favoriteDescriptions.sort(
        (a, b) => a.description.toLowerCase().compareTo(b.description.toLowerCase()));

    emit(
      SetOweRecordDescriptionStepFavoriteDescriptionsUpdated(
        favoriteDescriptions: _favoriteDescriptions,
      ),
    );
  }

  bool _validateDescriptionToAddToFavorites(
    String description,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) {
    if (description.trim().isEmpty) {
      emit(
        SetOweRecordDescriptionStepFavoriteDescriptionsError(
          message: 'Descrição não pode estar vazia para ser adicionada aos favoritos',
        ),
      );
      return false;
    }

    if (_isDescriptionInFavorites(description)) {
      emit(
        SetOweRecordDescriptionStepFavoriteDescriptionsError(
          message: 'Descrição já está entre os favoritos',
        ),
      );
      return false;
    }
    return true;
  }

  bool _isDescriptionInFavorites(String description) {
    for (var favoriteDescription in _favoriteDescriptions) {
      if (favoriteDescription.description.toLowerCase() == description.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  FutureOr<void> _sendDescriptionToNavigateToNextPage(
    SetOweRecordDescriptionStepNextPageRequested event,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) async {
    emit(SetOweRecordDescriptionStepLoading());
    emit(
      SetOweRecordDescriptionStepNavigatingToNextPage(
        oweRecordDraft: _initialOweRecordDraft.copyWith(description: _description),
        recordDebtor: _initialRecordDebtor,
        isEdition: _isEdition,
      ),
    );
  }
}
