class Failure {

  Failure(this.message, {this.errorCode});
  final String message;
  final String? errorCode;

  @override
  String toString() => 'Failure(message: $message, statusCode: $errorCode)';
}
