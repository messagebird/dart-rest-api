import 'model/verify.dart';

/// Verify service interface.
abstract class VerifyService {
  /// Send a verification code.
  Future<Verify> create(Verify verify);

  /// Get verification code details.
  Future<Verify> read(String id);

  /// Removes a verification code.
  Future<void> remove(String id);

  /// Verify a verification code.
  Future<Verify> verify(String id, String token);
}
