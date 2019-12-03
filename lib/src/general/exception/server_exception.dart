import 'request_unsuccessful.dart';

/// Indicates that there was a problem with the request caused by the server.
/// Resubmitting the exact same request MAY help.
///
/// In the world of HTTP, these are the 500-series response codes.
class ServerException extends RequestUnsuccessful {
  /// Constructor.
  ServerException(message) : super(message);
}
