import 'client_exception.dart';

/// Indicates that the account has insufficient funds to complete the request.
class InsufficientFunds extends ClientException {
  /// Constructor.
  InsufficientFunds(message) : super(message);
}
