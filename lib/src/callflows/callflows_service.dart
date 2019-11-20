import 'model/callflow.dart';
import 'model/callflows.dart';

/// Callflows service interface.
abstract class CallflowsService {
  /// Creates a new [Callflow], parameters are manditory.
  Future<Callflow> create(Map<String, dynamic> parameters);

  /// Lists existing [Callflows].
  Future<Callflows> list(int page, int perpage);

  /// Get a [Callflow].
  Future<Callflow> read(String flowId);

  /// Removes an existing [Callflow]. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<void> remove(String flowId);

  /// Updates an existing [Callflow]. Parameters are required.
  Future<Callflow> update(String flowId, Map<String, dynamic> parameters);
}
