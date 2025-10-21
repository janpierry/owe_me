part of 'set_payment_record_info_review_bloc.dart';

sealed class SetPaymentRecordInfoReviewEvent extends Equatable {
  const SetPaymentRecordInfoReviewEvent();

  @override
  List<Object?> get props => [];
}

class SetPaymentRecordInfoReviewPageInitialized extends SetPaymentRecordInfoReviewEvent {
  final PaymentRecordDraft paymentRecordDraft;
  final Debtor recordDebtor;
  final PaymentRecord? paymentRecordToEdit;

  const SetPaymentRecordInfoReviewPageInitialized({
    required this.paymentRecordDraft,
    required this.recordDebtor,
    required this.paymentRecordToEdit,
  });

  @override
  List<Object?> get props => [paymentRecordDraft, recordDebtor, paymentRecordToEdit];
}

class SetPaymentRecordInfoReviewSetRecordRequested
    extends SetPaymentRecordInfoReviewEvent {}
