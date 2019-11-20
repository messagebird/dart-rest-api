import 'model/callflow.dart';
import 'model/callflows.dart';

/// Callflows service interface.
abstract class CallflowsService {
  /// Creates a new call flow, parameters are manditory.
  Future<Callflow> create(Map<String, dynamic> parameters);

  /// Lists existing call flows.
  Future<Callflows> list(int page, int perpage);

  /// Get a call flow.
  Future<Callflow> read(String flowId);

  /// Removes an existing call flow. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<void> remove(String flowId);

  /// Updates an existing call flow. Parameters are required.
  Future<Callflow> update(String flowId, Map<String, dynamic> parameters);
}
