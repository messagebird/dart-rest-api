import 'model/call.dart';
import 'model/calls.dart';

/// Calls service interface.
abstract class CallsService {
  /// Create a [Call].
  Future<Call> create(Map<String, dynamic> parameters);

  /// List [Calls].
  Future<Calls> list();

  /// Read a [Call].
  Future<Call> read(int callId);

  /// Remove a [Call].
  Future<void> remove(int callId);
}
