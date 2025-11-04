import 'package:owe_me/src/domain/validation/failures/validation_failure.dart';
import 'package:owe_me/src/domain/validation/validators/validator.dart';
import 'package:owe_me/src/presentation/validation/mappers/validation_mapper.dart';

abstract class ValidationService<T, F extends ValidationFailure> {
  final Validator<T, F> validator;
  final ValidationMapper<F> mapper;

  const ValidationService({
    required this.validator,
    required this.mapper,
  });

  String? validateAndMapFailureToErrorMessage(T value) {
    final failure = validator.validate(value);
    return mapper.mapFailureToErrorMessage(failure);
  }
}
