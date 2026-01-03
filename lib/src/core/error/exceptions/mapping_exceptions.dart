/// Thrown when the data exists but violates Domain Rules during conversion.
class DataIntegrityException implements Exception {
  final String message;

  DataIntegrityException(this.message);

  @override
  String toString() => 'DataIntegrityException: $message';
}
