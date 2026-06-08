import 'package:owe_me/src/core/error/failures/failures.dart';

/// Signals that an [OweRecord] would be in an invalid state. Carries the
/// underlying rule failure as [cause] (diagnostic, like an exception's cause
/// chain).
class OweRecordValidationFailure extends Failure {
  OweRecordValidationFailure(Failure cause) : super(cause.message, cause: cause);
}
