import 'package:owe_me/data/models/model.dart';

abstract class MonetaryRecordModel extends Model {
  final int debtorId;
  final int amountInCents;
  final String date;

  const MonetaryRecordModel({
    required super.id,
    required this.debtorId,
    required this.amountInCents,
    required this.date,
  });

  @override
  List<Object?> get props => super.props + [debtorId, amountInCents, date];
}
