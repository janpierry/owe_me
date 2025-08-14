import 'package:owe_me/src/data/models/monetary_record_model.dart';

class OweRecordModel extends MonetaryRecordModel {
  final String? description;
  final String oweType;

  const OweRecordModel({
    required super.id,
    required super.debtorId,
    required super.amountInCents,
    required super.date,
    required this.description,
    required this.oweType,
  });

  static const table = 'owe_records';

  @override
  String get tableName => table;

  factory OweRecordModel.fromMap(Map<String, dynamic> map) {
    return OweRecordModel(
      id: map['id'],
      debtorId: map['debtor_id'],
      amountInCents: map['amount_in_cents'],
      description: map['description'],
      date: map['date'],
      oweType: map['owe_type'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'debtor_id': debtorId,
      'amount_in_cents': amountInCents,
      'description': description,
      'date': date,
      'owe_type': oweType,
    };
  }

  @override
  List<Object?> get props => super.props + [description, oweType];
}
