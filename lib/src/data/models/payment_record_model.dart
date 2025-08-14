import 'package:owe_me/src/data/models/monetary_record_model.dart';

class PaymentRecordModel extends MonetaryRecordModel {
  final String paymentType;

  const PaymentRecordModel({
    required super.id,
    required super.debtorId,
    required super.amountInCents,
    required super.date,
    required this.paymentType,
  });

  static const table = 'payment_records';

  @override
  String get tableName => table;

  factory PaymentRecordModel.fromMap(Map<String, dynamic> map) {
    return PaymentRecordModel(
      id: map['id'],
      debtorId: map['debtor_id'],
      amountInCents: map['amount_in_cents'],
      date: map['date'],
      paymentType: map['payment_type'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'debtor_id': debtorId,
      'amount_in_cents': amountInCents,
      'date': date,
      'payment_type': paymentType,
    };
  }

  @override
  List<Object?> get props => super.props + [paymentType];
}
