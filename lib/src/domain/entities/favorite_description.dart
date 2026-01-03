import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:owe_me/src/domain/enums/owe_type.dart';
import 'package:owe_me/src/domain/failures/favorite_description_failures.dart';

class FavoriteDescription extends Equatable {
  final int? id; // Null ID for new records
  final String description;
  final OweType favoriteType;

  const FavoriteDescription._({
    required this.id,
    required this.description,
    required this.favoriteType,
  });

  static Either<FavoriteDescriptionFailure, FavoriteDescription> create({
    int? id,
    required String description,
    required OweType favoriteType,
  }) {
    if (description.trim().isEmpty) {
      return Left(
        FavoriteDescriptionEmptyFailure(),
      );
    }
    return Right(
      FavoriteDescription._(
        id: id,
        description: description,
        favoriteType: favoriteType,
      ),
    );
  }

  @override
  List<Object?> get props => [id, description, favoriteType];
}
