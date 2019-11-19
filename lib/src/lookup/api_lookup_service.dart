import 'package:http/http.dart' show Response;
import '../base_service.dart';
import 'lookup_service.dart';

/// API implementation of lookup service
class ApiLookupService extends BaseService implements LookupService {
  /// Constructor
  ApiLookupService(String accessKey) : super(accessKey);

  @override
  Future<Response> lookup(String phoneNumber, String countryCode) =>
      get('/lookup/$phoneNumber', body: {'countryCode': countryCode});
}
