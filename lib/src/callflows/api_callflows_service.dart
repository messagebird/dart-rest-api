import 'package:http/http.dart' show Response;
import '../base_service.dart';
import 'callflows_service.dart';

/// API implementation of callflows service
class ApiCallflowService extends BaseService implements CallflowsService {
  /// Constructor
  ApiCallflowService(String accessKey) : super(accessKey);

  @override
  Future<Response> createCallflow(Map<String, dynamic> parameters) =>
      post('/call-flows',
          hostname: BaseService.voiceEndpoint, body: parameters);

  @override
  Future<Response> deleteCallflow(String flowId) =>
      delete('/call-flows/$flowId', hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> listCallflows(int page, int perpage) => get('/call-flows',
      hostname: BaseService.voiceEndpoint,
      body: {'page': page, 'perpage': perpage});

  @override
  Future<Response> readCallflow(String flowId) =>
      get('/call-flows/$flowId', hostname: BaseService.voiceEndpoint);

  @override
  Future<Response> updateCallflow(
          String flowId, Map<String, dynamic> parameters) =>
      put('/call-flows', hostname: BaseService.voiceEndpoint, body: parameters);
}
