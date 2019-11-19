import 'service_exception.dart';

/// Indicates that there was a communication problem in trying to execute the
/// service call. This usually means that there was some sort of networking
/// problem.
class CommunicationProblem extends ServiceException {
  /// Constructor.
  CommunicationProblem(message) : super(message);
}
