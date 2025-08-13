import 'package:owe_me/data/models/model.dart';

class DebtorModel extends Model {
  final String nickname;
  final int totalDebtInCents;

  const DebtorModel({
    required super.id,
    required this.nickname,
    required this.totalDebtInCents,
  });

  static const table = 'debtors';

  @override
  String get tableName => table;

  factory DebtorModel.fromMap(Map<String, dynamic> map) {
    return DebtorModel(
      id: map['id'],
      nickname: map['nickname'],
      totalDebtInCents: map['total_debt_in_cents'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'nickname': nickname,
      'total_debt_in_cents': totalDebtInCents,
    };
  }

  @override
  List<Object?> get props => super.props + [nickname, totalDebtInCents];
}
