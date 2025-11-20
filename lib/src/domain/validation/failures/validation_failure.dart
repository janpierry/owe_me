import 'package:owe_me/src/core/shared/error/failures.dart';

abstract class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
