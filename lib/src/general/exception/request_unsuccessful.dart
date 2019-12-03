import 'service_exception.dart';

/// Indicates that the request was understood by the backend, but did not
/// succeed. This could be due to a problem at the server or at the client.
///
/// Individual services should provide subclasses of this exception
/// to allow for recognition of specific problems.
class RequestUnsuccessful extends ServiceException {
  /// Constructor.
  RequestUnsuccessful(message) : super(message);
}
