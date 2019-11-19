import 'package:http/http.dart' show Response;

import '../base_service.dart';
import 'callflows_service.dart';

/// API implementation of callflows service.
class ApiCallflowService extends BaseService implements CallflowsService {
  /// Constructor.
  ApiCallflowService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Response> create(Map<String, dynamic> parameters) =>
      post('/call-flows',
          hostname: BaseService.voiceEndpoint, body: parameters);

  @override
  Future<Response> list(int page, int perpage) => get('/call-flows',
      hostname: BaseService.voiceEndpoint,
      body: {'page': page, 'perpage': perpage});

  @override
  Future<Response> read(String flowId) =>
      get('/call-flows/$flowId', hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> remove(String flowId) =>
      delete('/call-flows/$flowId', hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> update(String flowId, Map<String, dynamic> parameters) =>
      put('/call-flows', hostname: BaseService.voiceEndpoint, body: parameters);
}
