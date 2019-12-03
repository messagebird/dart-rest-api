import 'client_exception.dart';

/// Indicates that the account has insufficient funds to complete the request.
class ApiNotFound extends ClientException {
  /// Constructor.
  ApiNotFound(message) : super(message);
}
