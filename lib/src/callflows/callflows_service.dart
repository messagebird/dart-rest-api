import 'package:http/http.dart' show Response;

/// Callflows service interface.
abstract class CallflowsService {
  /// Creates a new call flow, parameters are manditory.
  Future<Response> create(Map<String, dynamic> parameters);

  /// Lists existing call flows.
  Future<Response> list(int page, int perpage);

  /// Get a call flow.
  Future<Response> read(String flowId);

  /// Removes an existing call flow. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<Response> remove(String flowId);

  /// Updates an existing call flow. Parameters are required.
  Future<Response> update(String flowId, Map<String, dynamic> parameters);
}
