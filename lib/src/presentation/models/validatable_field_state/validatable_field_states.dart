import 'package:owe_me/src/domain/entities/money.dart';
import 'package:owe_me/src/domain/validation/failures/amount_failures.dart';
import 'package:owe_me/src/presentation/models/validatable_field_state/validatable_field_state.dart';

typedef ValidatableAmountState = ValidatableFieldState<Money, AmountValidationFailure>;
