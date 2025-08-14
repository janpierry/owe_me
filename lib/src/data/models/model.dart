import 'package:equatable/equatable.dart';

abstract class Model extends Equatable {
  final int? id; // Null ID for new records

  const Model({this.id});

  String get tableName;

  Map<String, dynamic> toMap();

  @override
  List<Object?> get props => [id];
}
