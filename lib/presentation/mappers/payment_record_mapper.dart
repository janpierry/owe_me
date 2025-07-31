import 'package:owe_me/domain/entities/payment_record.dart';
import 'package:owe_me/presentation/drafts/payment_record_draft.dart';

class PaymentRecordMapper {
  const PaymentRecordMapper._();

  static PaymentRecord toEntity(PaymentRecordDraft draft) {
    if (draft.amount == null || draft.amount!.cents <= 0) {
      throw ArgumentError('Invalid amount: ${draft.amount}');
    }
    if (draft.paymentMethod == null) {
      throw ArgumentError('Invalid payment method: ${draft.paymentMethod}');
    }
    if (draft.date == null) {
      throw ArgumentError('Invalid date: ${draft.date}');
    }

    return PaymentRecord(
      id: null, // ID will be assigned when saved in database
      amount: draft.amount!,
      paymentMethod: draft.paymentMethod!,
      date: draft.date!,
    );
  }
}
