import 'request_unsuccessful.dart';

/// Indicates that there was a problem with the request caused by the client.
/// Resubmitting the exact same request will not help.
///
/// In the world of HTTP, these are the 400-series response codes.
class ClientException extends RequestUnsuccessful {
  /// Constructor.
  ClientException(message) : super(message);
}
