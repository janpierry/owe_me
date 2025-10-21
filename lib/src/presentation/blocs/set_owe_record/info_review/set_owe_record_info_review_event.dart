part of 'set_owe_record_info_review_bloc.dart';

sealed class SetOweRecordInfoReviewEvent extends Equatable {
  const SetOweRecordInfoReviewEvent();

  @override
  List<Object> get props => [];
}

class SetOweRecordInfoReviewPageInitialized extends SetOweRecordInfoReviewEvent {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;
  final OweRecord? oweRecordToEdit;

  const SetOweRecordInfoReviewPageInitialized({
    required this.oweRecordDraft,
    required this.recordDebtor,
    required this.oweRecordToEdit,
  });

  @override
  List<Object> get props => [oweRecordDraft, recordDebtor];
}

class SetOweRecordInfoReviewSetRecordRequested extends SetOweRecordInfoReviewEvent {}
