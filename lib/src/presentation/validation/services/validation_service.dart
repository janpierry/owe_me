import 'package:owe_me/src/domain/validation/failures/validation_failure.dart';
import 'package:owe_me/src/domain/validation/validators/validator.dart';
import 'package:owe_me/src/presentation/validation/mappers/validation_mapper.dart';

class ValidationService<T, F extends ValidationFailure> {
  final Validator<T, F> _validator;
  final ValidationMapper<F> _mapper;

  const ValidationService({
    required Validator<T, F> validator,
    required ValidationMapper<F> mapper,
  })  : _validator = validator,
        _mapper = mapper;

  String? validateAndMapFailureToErrorMessage(T value) {
    final failure = _validator.validate(value);
    return _mapper.mapFailureToMessage(failure);
  }
}
