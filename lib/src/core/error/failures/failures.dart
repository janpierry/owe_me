abstract class Failure {
  final String message;
  final Failure? cause;
  const Failure(this.message, {this.cause});
}

class DefaultFailure extends Failure {
  const DefaultFailure([super.message = 'Unexpected error']);
}

//TODO Rename this to something more specific
class DebtorIdNotFoundFailure extends Failure {
  const DebtorIdNotFoundFailure([super.message = 'Debtor ID not found']);
}
