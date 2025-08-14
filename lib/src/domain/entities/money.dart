import 'package:equatable/equatable.dart';

class Money extends Equatable {
  final int cents;

  const Money({required this.cents});

  const Money.zero() : cents = 0;

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
