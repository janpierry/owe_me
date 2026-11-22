part of 'set_owe_record_description_step_bloc.dart';

sealed class SetOweRecordDescriptionStepEvent extends Equatable {
  const SetOweRecordDescriptionStepEvent();

  @override
  List<Object> get props => [];
}

class SetOweRecordDescriptionStepPageInitialized
    extends SetOweRecordDescriptionStepEvent {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;

  const SetOweRecordDescriptionStepPageInitialized({
    required this.oweRecordDraft,
    required this.recordDebtor,
  });

  @override
  List<Object> get props => [oweRecordDraft, recordDebtor];
}

class SetOweRecordDescriptionStepDescriptionChanged
    extends SetOweRecordDescriptionStepEvent {
  final String description;

  const SetOweRecordDescriptionStepDescriptionChanged({required this.description});

  @override
  List<Object> get props => [description];
}

class SetOweRecordDescriptionStepDescriptionAddedToFavorites
    extends SetOweRecordDescriptionStepEvent {
  const SetOweRecordDescriptionStepDescriptionAddedToFavorites();
}

class SetOweRecordDescriptionStepFavoriteDescriptionSelected
    extends SetOweRecordDescriptionStepEvent {
  final FavoriteDescription selectedDescription;

  const SetOweRecordDescriptionStepFavoriteDescriptionSelected({
    required this.selectedDescription,
  });

  @override
  List<Object> get props => [selectedDescription];
}

class SetOweRecordDescriptionStepNextPageRequested
    extends SetOweRecordDescriptionStepEvent {}
