import 'package:equatable/equatable.dart';
import 'package:owe_me/src/domain/validation/failures/validation_failure.dart';

class ValidatableFieldState<T, F extends ValidationFailure> extends Equatable {
  final T value;
  final F? failure;
  final bool showError;

  const ValidatableFieldState({
    required this.value,
    this.failure,
    this.showError = false,
  });

  bool get isValid => failure == null;

  ValidatableFieldState<T, F> copyWith({
    T? value,
    F? failure,
    bool removeFailure = false,
    bool? showError,
  }) {
    return ValidatableFieldState(
      value: value ?? this.value,
      failure: removeFailure ? null : (failure ?? this.failure),
      showError: showError ?? this.showError,
    );
  }

  @override
  List<Object?> get props => [value, failure, showError];
}
