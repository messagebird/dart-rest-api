import 'client_exception.dart';

/// Indicates that the request has missing parameters.
class InvalidParams extends ClientException {
  /// Constructor.
  InvalidParams(message) : super(message);
}
