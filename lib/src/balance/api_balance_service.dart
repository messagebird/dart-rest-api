import 'package:messagebird_dart/src/balance/model/balance.dart';

import '../base_service.dart';
import 'balance_service.dart';

/// API implementation of [BalanceService].
class ApiBalanceService extends BaseService implements BalanceService {
  /// Constructor.
  ApiBalanceService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Balance> read() async {
    final response = await get('/balance');
    return Future.value(Balance.fromJson(response.body));
  }
}
