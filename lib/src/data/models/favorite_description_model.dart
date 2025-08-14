import 'package:owe_me/src/data/models/model.dart';

class FavoriteDescriptionModel extends Model {
  final int debtorId;
  final String description;
  final String favoriteType;

  const FavoriteDescriptionModel({
    required super.id,
    required this.debtorId,
    required this.description,
    required this.favoriteType,
  });

  static const table = 'favorite_descriptions';

  @override
  String get tableName => table;

  factory FavoriteDescriptionModel.fromMap(Map<String, dynamic> map) {
    return FavoriteDescriptionModel(
      id: map['id'],
      debtorId: map['debtor_id'],
      description: map['description'],
      favoriteType: map['favorite_type'],
    );
  }

  @override
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'debtor_id': debtorId,
      'description': description,
      'favorite_type': favoriteType,
    };
  }

  @override
  List<Object?> get props => super.props + [debtorId, description, favoriteType];
}
