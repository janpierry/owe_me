import '../failures/validation_failure.dart';

abstract class Validator<T, F extends ValidationFailure> {
  F? validate(T value);
}
