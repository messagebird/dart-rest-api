import 'package:http/http.dart' show Response;

/// Verify service interface
abstract class VerifyService {
  /// Get verification code details
  Future<Response> readCode(String id);

  /// Send a verification code
  Future<Response> createCode(int recipient, Map<String, dynamic> parameters);

  /// Delete a verification code
  Future<Response> deleteCode(String id);

  /// Verify a verification code
  Future<Response> verifyCode(String id, String token);
}
