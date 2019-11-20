import 'package:messagebird_dart/src/balance/model/balance.dart';

/// Balance service interface.
// ignore: one_member_abstracts
abstract class BalanceService {
  /// Get account balance.
  Future<Balance> read();
}
