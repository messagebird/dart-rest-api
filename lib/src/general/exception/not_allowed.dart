import 'client_exception.dart';

/// Indicates that the request is not allowed.
class NotAllowed extends ClientException {
  /// Constructor.
  NotAllowed(message) : super(message);
}
