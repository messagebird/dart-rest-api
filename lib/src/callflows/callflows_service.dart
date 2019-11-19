import 'package:http/http.dart' show Response;

/// Callflows service interface
abstract class CallflowsService {
  /// Lists existing call flows
  Future<Response> listCallflows(int page, int perpage);

  /// Creates a new call flow, parameters are manditory
  Future<Response> createCallflow(Map<String, dynamic> parameters);

  /// Get a call flow
  Future<Response> readCallflow(String flowId);

  /// Deletes an existing call flow. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<Response> deleteCallflow(String flowId);

  /// Updates an existing call flow. Parameters are required.
  Future<Response> updateCallflow(
      String flowId, Map<String, dynamic> parameters);
}
