part of 'set_owe_record_info_review_bloc.dart';

sealed class SetOweRecordInfoReviewEvent extends Equatable {
  const SetOweRecordInfoReviewEvent();

  @override
  List<Object> get props => [];
}

class SetOweRecordInfoReviewPageInitialized extends SetOweRecordInfoReviewEvent {
  final OweRecordDraft oweRecordDraft;
  final Debtor recordDebtor;

  const SetOweRecordInfoReviewPageInitialized({
    required this.oweRecordDraft,
    required this.recordDebtor,
  });

  @override
  List<Object> get props => [oweRecordDraft, recordDebtor];
}

class SetOweRecordInfoReviewSetRecordRequested extends SetOweRecordInfoReviewEvent {}
