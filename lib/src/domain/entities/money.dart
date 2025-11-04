import 'package:equatable/equatable.dart';

class Money extends Equatable {
  final int cents;

  const Money({required this.cents});

  static const Money zero = Money(cents: 0);

  // Limit of 999,999,999,999.99
  static const Money max = Money(cents: 99999999999999);

  double get inReal => cents / 100;

  Money operator +(Money other) => Money(cents: cents + other.cents);

  Money operator -(Money other) => Money(cents: cents - other.cents);

  bool operator <(Money other) => cents < other.cents;

  bool operator <=(Money other) => cents <= other.cents;

  bool operator >(Money other) => cents > other.cents;

  bool operator >=(Money other) => cents >= other.cents;

  @override
  List<Object?> get props => [cents];
}
