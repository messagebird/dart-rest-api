import 'model/call.dart';

/// Calls service interface.
abstract class CallsService {
  /// Create a [Call].
  Future<Call> create(Call call);

  /// List existing [Call] objects.
  Future<List<Call>> list();

  /// Read a [Call].
  Future<Call> read(int id);

  /// Remove a [Call].
  Future<void> remove(int id);
}
