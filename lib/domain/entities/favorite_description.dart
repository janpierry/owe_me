import 'package:equatable/equatable.dart';
import 'package:owe_me/domain/enums/owe_type.dart';

class FavoriteDescription extends Equatable {
  final int? id; // Null ID for new records
  final String description;
  final OweType favoriteType;

  const FavoriteDescription({
    this.id,
    required this.description,
    required this.favoriteType,
  });

  @override
  List<Object?> get props => [id, description, favoriteType];
}
