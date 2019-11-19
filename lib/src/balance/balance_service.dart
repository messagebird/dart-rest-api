import 'package:http/http.dart' show Response;

/// Balance service interface.
// ignore: one_member_abstracts
abstract class BalanceService {
  /// Get account balance.
  Future<Response> read();
}
