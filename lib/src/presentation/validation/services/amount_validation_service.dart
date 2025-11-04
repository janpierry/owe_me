import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/validation/failures/amount_failures.dart';
import 'package:owe_me/src/domain/validation/validators/amount_validator.dart';
import 'package:owe_me/src/presentation/validation/mappers/amount_validation_mapper.dart';
import 'package:owe_me/src/presentation/validation/services/validation_service.dart';

class AmountValidationService extends ValidationService<Money, AmountValidationFailure> {
  const AmountValidationService({
    required AmountValidator validator,
    required AmountValidationMapper mapper,
  }) : super(validator: validator, mapper: mapper);
}
