import 'package:http/http.dart' show Response;

/// Verify service interface.
abstract class VerifyService {
  /// Send a verification code.
  Future<Response> create(int recipient, Map<String, dynamic> parameters);

  /// Get verification code details.
  Future<Response> read(String id);

  /// Removes a verification code.
  Future<Response> remove(String id);

  /// Verify a verification code.
  Future<Response> verify(String id, String token);
}
