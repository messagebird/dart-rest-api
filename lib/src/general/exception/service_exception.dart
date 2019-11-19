/// Provides the base class and catch-all exception for issues with service
/// method calls. A consumer of any of the services would have to check for
/// this exception, or more specific subclasses of this exception.
///
/// Each service should ideally implement subclasses for specific error
/// conditions, and reserve this one for unexpected, but still intelligible
/// conditions.
///
/// ServiceException
///  |__ RequestUnsuccessful
///  |    |__ ClientException (400-series)
///  |    |    |__ BadRequest (400)
///  |    |    |    |__ PlayableNotReleased
///  |    |    |    |__ ...
///  |    |    |__ Unauthorized (401)
///  |    |    |    |__ ...
///  |    |    |__ Forbidden (403)
///  |    |    |    |__ PlayableNotAccessible
///  |    |    |__ NotFound (404)
///  |    |         |__ PlayableNotFound
///  |    |__ ServerException (500-series)
///  |         |__ ...
///  |__ UnexpectedResponse
///  |__ CommunicationProblem
///
class ServiceException implements Exception {
  /// The exception messsage
  String message;

  /// Constructor
  ServiceException(this.message);
}
