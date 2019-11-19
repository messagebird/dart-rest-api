import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'lookup_service.dart';

/// API implementation of lookup service.
class ApiLookupService extends BaseService implements LookupService {
  /// Constructor.
  ApiLookupService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> read(String phoneNumber, String countryCode) =>
      get('/lookup/$phoneNumber', body: {'countryCode': countryCode});
}
