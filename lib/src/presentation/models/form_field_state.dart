import 'package:equatable/equatable.dart';

class FormFieldState<T> extends Equatable {
  final T value;
  final String? errorMessage;
  final bool showError;

  const FormFieldState({
    required this.value,
    this.errorMessage,
    this.showError = false,
  });

  bool get isValid => errorMessage == null;

  FormFieldState<T> copyWith({
    T? value,
    String? errorMessage,
    bool removeErrorMessage = false,
    bool? showError,
  }) {
    return FormFieldState(
      value: value ?? this.value,
      errorMessage: removeErrorMessage ? null : (errorMessage ?? this.errorMessage),
      showError: showError ?? this.showError,
    );
  }

  @override
  List<Object?> get props => [value, errorMessage, showError];
}
