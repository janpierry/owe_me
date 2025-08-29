sealed class Failure {
  final String message;
  const Failure(this.message);
}

class DefaultFailure extends Failure {
  const DefaultFailure([super.message = 'Unexpected error']);
}

//TODO Rename this to something more specific
class DebtorIdNotFoundFailure extends Failure {
  const DebtorIdNotFoundFailure([super.message = 'Debtor ID not found']);
}
