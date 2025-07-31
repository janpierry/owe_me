import 'dart:async';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:owe_me/core/error/failures.dart';
import 'package:owe_me/presentation/drafts/owe_record_draft.dart';
import 'package:owe_me/domain/entities/debtor.dart';
import 'package:owe_me/domain/entities/favorite_description.dart';
import 'package:owe_me/domain/enums/owe_type.dart';
import 'package:owe_me/domain/use_cases/favorite_descriptions/add_favorite_description.dart';
import 'package:owe_me/domain/use_cases/favorite_descriptions/load_debtor_favorite_credits.dart';
import 'package:owe_me/domain/use_cases/favorite_descriptions/load_debtor_favorite_debts.dart';

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
    on<SetOweRecordDescriptionStepPageInitializedEvent>(_loadInitialData);
    on<SetOweRecordDescriptionStepDescriptionChangedEvent>(_setDescription);
    on<SetOweRecordDescriptionStepFavoriteDescriptionSelectedEvent>(
      _setDescriptionAndSendValueToTextField,
    );
    on<SetOweRecordDescriptionStepDescriptionAddedToFavoritesEvent>(
      _addDescriptionToFavorites,
    );
    on<SetOweRecordDescriptionStepNextPageRequestedEvent>(
      _sendDescriptionToNavigateToNextPage,
    );
  }

  OweType get _oweRecordType => _initialOweRecordDraft.oweType;

  FutureOr<void> _loadInitialData(
    SetOweRecordDescriptionStepPageInitializedEvent event,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) async {
    emit(SetOweRecordDescriptionStepLoading());
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
        isEdition: _isEdition,
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
    SetOweRecordDescriptionStepDescriptionChangedEvent event,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) async {
    _description = event.description;
  }

  FutureOr<void> _setDescriptionAndSendValueToTextField(
    SetOweRecordDescriptionStepFavoriteDescriptionSelectedEvent event,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) async {
    _description = event.selectedDescription.description;
    emit(
      SetOweRecordDescriptionStepSendingDescriptionToTextField(description: _description),
    );
  }

  FutureOr<void> _addDescriptionToFavorites(
    SetOweRecordDescriptionStepDescriptionAddedToFavoritesEvent event,
    Emitter<SetOweRecordDescriptionStepState> emit,
  ) async {
    //TODO should affect the page?
    emit(SetOweRecordDescriptionStepFavoriteDescriptionsLoading());

    if (_description.isEmpty || _isDescriptionInFavorites(_description)) {
      emit(SetOweRecordDescriptionStepFavoriteDescriptionsError());
      return;
      //TODO Show page again or it does not affect page?
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
      emit(SetOweRecordDescriptionStepFavoriteDescriptionsError());
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

  bool _isDescriptionInFavorites(String description) {
    for (var favoriteDescription in _favoriteDescriptions) {
      if (favoriteDescription.description.toLowerCase() == description.toLowerCase()) {
        return true;
      }
    }
    return false;
  }

  FutureOr<void> _sendDescriptionToNavigateToNextPage(
    SetOweRecordDescriptionStepNextPageRequestedEvent event,
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
