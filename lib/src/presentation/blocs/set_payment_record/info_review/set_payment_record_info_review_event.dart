part of 'set_payment_record_info_review_bloc.dart';

sealed class SetPaymentRecordInfoReviewEvent extends Equatable {
  const SetPaymentRecordInfoReviewEvent();

  @override
  List<Object> get props => [];
}

class SetPaymentRecordInfoReviewPageInitialized extends SetPaymentRecordInfoReviewEvent {
  final PaymentRecordDraft paymentRecordDraft;
  final Debtor recordDebtor;

  const SetPaymentRecordInfoReviewPageInitialized({
    required this.paymentRecordDraft,
    required this.recordDebtor,
  });

  @override
  List<Object> get props => [paymentRecordDraft, recordDebtor];
}

class SetPaymentRecordInfoReviewSetRecordRequested
    extends SetPaymentRecordInfoReviewEvent {}
