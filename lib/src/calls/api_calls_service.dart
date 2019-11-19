import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'calls_service.dart';

/// API implementation of callflows service.
class ApiCallsService extends BaseService implements CallsService {
  /// Constructor.
  ApiCallsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> create(Map<String, dynamic> parameters) =>
      post('/calls', hostname: BaseService.voiceEndpoint, body: parameters);

  @override
  Future<Response> list() => get('/calls', hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> read(int callId) =>
      get('/calls/$callId', hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> remove(int callId) =>
      delete('/calls/$callId', hostname: BaseService.voiceEndpoint);
}
