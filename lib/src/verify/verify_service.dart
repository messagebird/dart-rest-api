import 'model/verify.dart';
import 'model/verify_response.dart';

/// Verify service interface.
abstract class VerifyService {
  /// Send a verification code.
  Future<VerifyResponse> create(Verify verify);

  /// Get verification code details.
  Future<VerifyResponse> read(String id);

  /// Removes a verification code.
  Future<void> remove(String id);

  /// Verify a verification code.
  Future<VerifyResponse> verify(String id, String token);
}
