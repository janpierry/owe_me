import 'package:dartz/dartz.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/core/presentation/failures.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';

class PaymentRecordDraft {
  final Money? amount;
  final DateTime? date;
  final PaymentMethod? paymentMethod;

  PaymentRecordDraft({this.amount, this.date, this.paymentMethod});

  /// The draft of an existing record, so editing starts on the review with
  /// every field filled in. The inverse of [toEntity], except for the id: the
  /// review keeps it from the record being edited.
  PaymentRecordDraft.fromEntity(PaymentRecord record)
    : this(
        amount: record.amount.value,
        date: record.date,
        paymentMethod: record.paymentMethod,
      );

  PaymentRecordDraft copyWith({
    Money? amount,
    bool removeAmount = false,
    DateTime? date,
    bool removeDate = false,
    PaymentMethod? paymentMethod,
    bool removePaymentMethod = false,
  }) {
    return PaymentRecordDraft(
      amount: removeAmount ? null : (amount ?? this.amount),
      date: removeDate ? null : (date ?? this.date),
      paymentMethod: removePaymentMethod
          ? null
          : (paymentMethod ?? this.paymentMethod),
    );
  }

  Either<InvalidDraftFailure, PaymentRecord> toEntity() {
    final amount = RecordAmount.create(this.amount ?? Money(cents: 0));
    if (amount.isLeft()) {
      return Left(InvalidDraftFailure('Valor inválido: ${this.amount}'));
    }
    if (paymentMethod == null) {
      return Left(InvalidDraftFailure('Método de pagamento é obrigatório'));
    }
    if (date == null) {
      return Left(InvalidDraftFailure('Data é obrigatória'));
    }

    return Right(
      PaymentRecord(
        id: null, // ID will be assigned when saved in database
        amount: amount.asRight(),
        paymentMethod: paymentMethod!,
        date: date!,
      ),
    );
  }
}
