/// Provides the base class and catch-all exception for issues with service
/// method calls. A consumer of any of the services would have to check for
/// this exception, or more specific subclasses of this exception.
///
/// Each service should ideally implement subclasses for specific error
/// conditions, and reserve this one for unexpected, but still intelligible
/// conditions.
class ServiceException implements Exception {
  /// The exception messsage.
  String message;

  /// Constructor.
  ServiceException(this.message);
}
