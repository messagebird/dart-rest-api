import 'package:http/http.dart' show Response;

/// Calls service interface.
abstract class CallsService {
  /// Create a call.
  Future<Response> create(Map<String, dynamic> parameters);

  /// List calls.
  Future<Response> list();

  /// Read a call.
  Future<Response> read(int callId);

  /// Remove a call.
  Future<Response> remove(int callId);
}
