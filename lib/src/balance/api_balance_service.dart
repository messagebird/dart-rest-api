import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'balance_service.dart';

/// API implementation of balance service.
class ApiBalanceService extends BaseService implements BalanceService {
  /// Constructor.
  ApiBalanceService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> read() => get('/balance');
}
