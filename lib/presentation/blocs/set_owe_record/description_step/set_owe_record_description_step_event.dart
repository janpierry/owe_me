part of 'set_owe_record_description_step_bloc.dart';

sealed class SetOweRecordDescriptionStepEvent extends Equatable {
  const SetOweRecordDescriptionStepEvent();

  @override
  List<Object> get props => [];
}

class SetOweRecordDescriptionStepPageInitializedEvent
    extends SetOweRecordDescriptionStepEvent {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;

  const SetOweRecordDescriptionStepPageInitializedEvent({
    required this.oweRecordDraft,
    required this.recordDebtor,
  });

  @override
  List<Object> get props => [oweRecordDraft, recordDebtor];
}

class SetOweRecordDescriptionStepDescriptionChangedEvent
    extends SetOweRecordDescriptionStepEvent {
  final String description;

  const SetOweRecordDescriptionStepDescriptionChangedEvent({required this.description});

  @override
  List<Object> get props => [description];
}

class SetOweRecordDescriptionStepDescriptionAddedToFavoritesEvent
    extends SetOweRecordDescriptionStepEvent {
  const SetOweRecordDescriptionStepDescriptionAddedToFavoritesEvent();
}

class SetOweRecordDescriptionStepFavoriteDescriptionSelectedEvent
    extends SetOweRecordDescriptionStepEvent {
  final FavoriteDescription selectedDescription;

  const SetOweRecordDescriptionStepFavoriteDescriptionSelectedEvent({
    required this.selectedDescription,
  });

  @override
  List<Object> get props => [selectedDescription];
}

class SetOweRecordDescriptionStepNextPageRequestedEvent
    extends SetOweRecordDescriptionStepEvent {}
