part of 'set_payment_record_info_review_bloc.dart';

sealed class SetPaymentRecordInfoReviewState extends Equatable {
  const SetPaymentRecordInfoReviewState();

  @override
  List<Object> get props => [];
}

final class SetPaymentRecordInfoReviewInitial extends SetPaymentRecordInfoReviewState {}

final class SetPaymentRecordInfoReviewSettingRecord
    extends SetPaymentRecordInfoReviewState {}

final class SetPaymentRecordInfoReviewRecordSetFinished
    extends SetPaymentRecordInfoReviewState {
  final Debtor updatedDebtor;

  const SetPaymentRecordInfoReviewRecordSetFinished({required this.updatedDebtor});

  @override
  List<Object> get props => [updatedDebtor];
}

final class SetPaymentRecordInfoReviewError extends SetPaymentRecordInfoReviewState {}
