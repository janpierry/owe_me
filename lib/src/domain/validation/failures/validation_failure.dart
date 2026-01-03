import 'package:owe_me/src/core/error/failures/failures.dart';

abstract class ValidationFailure extends Failure {
  const ValidationFailure(super.message);
}
