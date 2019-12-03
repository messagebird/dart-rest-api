import 'model/balance.dart';

/// Balance service interface.
// ignore: one_member_abstracts
abstract class BalanceService {
  /// Retrieves your MessageBird balance. Returns a balance object if the
  /// request was successful. If the request failed, an error object will
  /// be returned.
  Future<Balance> read();
}
