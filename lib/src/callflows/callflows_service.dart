import 'model/callflow.dart';

/// Callflows service interface.
abstract class CallflowsService {
  /// Create a new [Callflow], parameters are manditory.
  Future<Callflow> create(Callflow callflow);

  /// List all existing [Callflow] objects.
  Future<List<Callflow>> list({int page, int perpage});

  /// Get a [Callflow].
  Future<Callflow> read(String id);

  /// Removes an existing [Callflow]. The Future completes with an error if
  /// applicable, but the data will never contain anything meaningful as the
  /// API returns an empty response for successful deletes.
  Future<void> remove(String id);

  /// Updates an existing [Callflow]. [callflow].id is required.
  Future<Callflow> update(Callflow callflow);
}
