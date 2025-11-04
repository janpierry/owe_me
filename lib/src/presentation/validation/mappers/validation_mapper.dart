import 'package:owe_me/src/domain/validation/failures/validation_failure.dart';

abstract interface class ValidationMapper<T extends ValidationFailure> {
  String? mapFailureToErrorMessage(T? failure);
}
