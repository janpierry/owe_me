import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/validation/failures/amount_failures.dart';
import 'package:owe_me/src/presentation/validation/services/validation_service.dart';

typedef AmountValidationService = ValidationService<Money, AmountValidationFailure>;
