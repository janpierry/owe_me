import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/core/presentation/extensions/dartz_extensions.dart';
import 'package:owe_me/src/domain/entities/monetary_record.dart';
import 'package:owe_me/src/domain/value_objects/money.dart';
import 'package:owe_me/src/domain/enums/payment_method.dart';
import 'package:owe_me/src/domain/value_objects/record_amount.dart';

void main() {
  group('Equatable props:', () {
    const id = 1;
    final date = DateTime(2023);
    final amount = RecordAmount.create(Money(cents: 1000)).asRight();
    const paymentType = PaymentMethod.cash;

    final entity = PaymentRecord(
      id: id,
      amount: amount,
      date: date,
      paymentMethod: paymentType,
    );

    test('When two entities have the same props, they should be equal', () {
      PaymentRecord second = PaymentRecord(
        id: id,
        date: date,
        amount: amount,
        paymentMethod: paymentType,
      );

      assert(entity == second);
    });

    test('When two entities have different [id], they should not be equal', () {
      PaymentRecord second = PaymentRecord(
        id: 2,
        date: date,
        amount: amount,
        paymentMethod: paymentType,
      );

      assert(entity != second);
    });

    test('When two entities have different [date], they should not be equal', () {
      PaymentRecord second = PaymentRecord(
        id: id,
        date: DateTime(2024),
        amount: amount,
        paymentMethod: paymentType,
      );

      assert(entity != second);
    });

    test('When two entities have different [amount], they should not be equal', () {
      PaymentRecord second = PaymentRecord(
        id: id,
        date: date,
        amount: RecordAmount.create(Money(cents: 2000)).asRight(),
        paymentMethod: paymentType,
      );

      assert(entity != second);
    });

    test('When two entities have different [paymentMethod], they should not be equal',
        () {
      PaymentRecord second = PaymentRecord(
        id: id,
        date: date,
        amount: amount,
        paymentMethod: PaymentMethod.pix,
      );

      assert(entity != second);
    });
  });
}
