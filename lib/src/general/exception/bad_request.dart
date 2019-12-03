import 'client_exception.dart';

/// Indicates that there was a problem with the request caused by the client.
/// Resubmitting the exact same request will not help.
///
/// In the world of HTTP, this is the 400 response code.
class BadRequest extends ClientException {
  /// Constructor.
  BadRequest(message) : super(message);
}
