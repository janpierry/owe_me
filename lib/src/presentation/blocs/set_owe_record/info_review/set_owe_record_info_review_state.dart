part of 'set_owe_record_info_review_bloc.dart';

sealed class SetOweRecordInfoReviewState extends Equatable {
  const SetOweRecordInfoReviewState();

  @override
  List<Object> get props => [];
}

final class SetOweRecordInfoReviewInitial extends SetOweRecordInfoReviewState {}

final class SetOweRecordInfoReviewSettingRecord extends SetOweRecordInfoReviewState {}

final class SetOweRecordInfoReviewRecordSetFinished extends SetOweRecordInfoReviewState {
  final Debtor updatedDebtor;

  const SetOweRecordInfoReviewRecordSetFinished({required this.updatedDebtor});

  @override
  List<Object> get props => [updatedDebtor];
}

final class SetOweRecordInfoReviewError extends SetOweRecordInfoReviewState {}
