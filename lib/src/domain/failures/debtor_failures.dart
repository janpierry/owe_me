import 'package:owe_me/src/core/error/failures/failures.dart';

/// Signals that a [Debtor] would be in an invalid state. Carries the underlying
/// rule failure as [cause] (diagnostic, like an exception's cause chain).
class DebtorValidationFailure extends Failure {
  DebtorValidationFailure(Failure cause) : super(cause.message, cause: cause);
}
