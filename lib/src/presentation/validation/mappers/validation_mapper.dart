import 'package:owe_me/src/domain/validation/failures/validation_failure.dart';

abstract class ValidationMapper<F extends ValidationFailure> {
  String? mapFailureToMessage(F? failure);
}
