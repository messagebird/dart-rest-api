import '../general/model/base_service.dart';
import 'balance_service.dart';
import 'model/balance.dart';

/// API implementation of [BalanceService].
class ApiBalanceService extends BaseService implements BalanceService {
  /// Constructor.
  ApiBalanceService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Balance> read() => get('/balance').then((response) =>
      Future.value(response == null ? null : Balance.fromJson(response.body)));
}
