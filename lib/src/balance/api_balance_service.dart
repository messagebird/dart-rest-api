import 'dart:convert';

import 'package:messagebird_dart/src/balance/model/balance.dart';

import '../../src/general/model/api_error.dart';
import '../base_service.dart';
import 'balance_service.dart';

/// API implementation of balance service.
class ApiBalanceService extends BaseService implements BalanceService {
  /// Constructor.
  ApiBalanceService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Balance> read() async {
    final response = await get('/balance');
    if (response.statusCode == 200) {
      return Future.value(Balance.fromJson(json.decode(response.body)));
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }
}
