import 'package:owe_me/src/domain/validation/failures/amount_failures.dart';
import 'package:owe_me/src/presentation/validation/mappers/validation_mapper.dart';

class AmountValidationMapper implements ValidationMapper<AmountValidationFailure> {
  const AmountValidationMapper();

  @override
  String? mapFailureToMessage(AmountValidationFailure? failure) {
    if (failure == null) return null;

    return switch (failure) {
      AmountZeroOrLessFailure() => 'Valor deve ser maior que zero',
      AmountExceedsLimitFailure() => 'Valor excede o limite máximo',
    };
  }
}
