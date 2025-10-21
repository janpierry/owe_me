import 'package:flutter_test/flutter_test.dart';
import 'package:owe_me/src/data/models/monetary_record_model.dart';

void main() {
  const id = 1;
  const debtorId = 2;
  const amountInCents = 1500;
  const date = '2024-05-01T12:30:00.000';
  const paymentType = 'pix';

  const model = PaymentRecordModel(
    id: id,
    debtorId: debtorId,
    amountInCents: amountInCents,
    date: date,
    paymentType: paymentType,
  );

  group('Equatable props tests', () {
    test('props should contain id', () {
      expect(model.props.contains(id), isTrue);
    });

    test('props should contain debtorId', () {
      expect(model.props.contains(debtorId), isTrue);
    });

    test('props should contain amountInCents', () {
      expect(model.props.contains(amountInCents), isTrue);
    });

    test('props should contain date', () {
      expect(model.props.contains(date), isTrue);
    });

    test('props should contain paymentType', () {
      expect(model.props.contains(paymentType), isTrue);
    });

    test('two identical models should be equal', () {
      const other = PaymentRecordModel(
        id: id,
        debtorId: debtorId,
        amountInCents: amountInCents,
        date: date,
        paymentType: paymentType,
      );
      expect(model, equals(other));
    });

    test('models with different ids should not be equal', () {
      const other = PaymentRecordModel(
        id: 3,
        debtorId: debtorId,
        amountInCents: amountInCents,
        date: date,
        paymentType: paymentType,
      );
      expect(model, isNot(equals(other)));
    });
  });

  group('fromMap tests', () {
    test('should create a valid model from map', () {
      final map = {
        'id': id,
        'debtor_id': debtorId,
        'amount_in_cents': amountInCents,
        'date': date,
        'payment_type': paymentType,
      };
      final result = PaymentRecordModel.fromMap(map);
      expect(result, equals(model));
    });
  });

  group('toMap tests', () {
    test('should return a valid map from model', () {
      final expectedMap = {
        'id': id,
        'debtor_id': debtorId,
        'amount_in_cents': amountInCents,
        'date': date,
        'payment_type': paymentType,
      };
      expect(model.toMap(), equals(expectedMap));
    });
  });
}
