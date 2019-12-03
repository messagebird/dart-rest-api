import 'client_exception.dart';

/// Indicates that the request has missing parameters.
class MissingParams extends ClientException {
  /// Constructor.
  MissingParams(message) : super(message);
}
