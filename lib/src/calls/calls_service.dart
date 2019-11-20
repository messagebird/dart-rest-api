import 'model/call.dart';
import 'model/calls.dart';

/// Calls service interface.
abstract class CallsService {
  /// Create a call.
  Future<Call> create(Map<String, dynamic> parameters);

  /// List calls.
  Future<Calls> list();

  /// Read a call.
  Future<Call> read(int callId);

  /// Remove a call.
  Future<void> remove(int callId);
}
