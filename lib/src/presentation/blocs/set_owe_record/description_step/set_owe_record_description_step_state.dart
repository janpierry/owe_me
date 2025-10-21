part of 'set_owe_record_description_step_bloc.dart';

sealed class SetOweRecordDescriptionStepState extends Equatable {
  const SetOweRecordDescriptionStepState();

  @override
  List<Object> get props => [];
}

final class SetOweRecordDescriptionStepInitial extends SetOweRecordDescriptionStepState {}

sealed class SetOweRecordDescriptionStepPageBuildState
    extends SetOweRecordDescriptionStepState {
  const SetOweRecordDescriptionStepPageBuildState();
}

final class SetOweRecordDescriptionStepPageLoading
    extends SetOweRecordDescriptionStepPageBuildState {}

final class SetOweRecordDescriptionStepPageLoaded
    extends SetOweRecordDescriptionStepPageBuildState {
  final String initialDescription;
  final List<FavoriteDescription> initialFavoriteDescriptions;

  const SetOweRecordDescriptionStepPageLoaded({
    required this.initialDescription,
    required this.initialFavoriteDescriptions,
  });

  @override
  List<Object> get props => [
        initialDescription,
        initialFavoriteDescriptions,
      ];
}

final class SetOweRecordDescriptionStepPageError
    extends SetOweRecordDescriptionStepPageBuildState {}

sealed class SetOweRecordDescriptionStepFavoriteDescriptionsState
    extends SetOweRecordDescriptionStepState {
  const SetOweRecordDescriptionStepFavoriteDescriptionsState();
}

final class SetOweRecordDescriptionStepFavoriteDescriptionsLoading
    extends SetOweRecordDescriptionStepFavoriteDescriptionsState {}

final class SetOweRecordDescriptionStepFavoriteDescriptionsError
    extends SetOweRecordDescriptionStepFavoriteDescriptionsState {
  final String message;

  const SetOweRecordDescriptionStepFavoriteDescriptionsError({
    required this.message,
  });

  @override
  List<Object> get props => [message];
}

final class SetOweRecordDescriptionStepFavoriteDescriptionsUpdated
    extends SetOweRecordDescriptionStepFavoriteDescriptionsState {
  final List<FavoriteDescription> favoriteDescriptions;

  const SetOweRecordDescriptionStepFavoriteDescriptionsUpdated({
    required this.favoriteDescriptions,
  });

  @override
  List<Object> get props => [favoriteDescriptions];
}

final class SetOweRecordDescriptionStepSendingDescriptionToTextField
    extends SetOweRecordDescriptionStepState {
  final String description;

  const SetOweRecordDescriptionStepSendingDescriptionToTextField({
    required this.description,
  });

  @override
  List<Object> get props => [description];
}

final class SetOweRecordDescriptionStepLoading extends SetOweRecordDescriptionStepState {}

class SetOweRecordDescriptionStepNavigatingToNextPage
    extends SetOweRecordDescriptionStepState {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;

  const SetOweRecordDescriptionStepNavigatingToNextPage({
    required this.oweRecordDraft,
    required this.recordDebtor,
  });

  @override
  List<Object> get props => [oweRecordDraft, recordDebtor];
}
