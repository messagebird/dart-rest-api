import 'dart:convert';

import '../base_service.dart';
import 'callflows_service.dart';
import 'model/callflow.dart';
import 'model/callflows.dart';

/// API implementation of [CallflowsService].
class ApiCallflowsService extends BaseService implements CallflowsService {
  /// Constructor.
  ApiCallflowsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Callflow> create(Map<String, dynamic> parameters) async {
    final response = await post('/call-flows',
        hostname: BaseService.voiceEndpoint, body: parameters);
    return Future.value(Callflow.fromJson(json.decode(response.body)));
  }

  @override
  Future<Callflows> list(int page, int perpage) async {
    final response = await get('/call-flows',
        hostname: BaseService.voiceEndpoint,
        body: {'page': page, 'perpage': perpage});
    return Future.value(Callflows.fromJson(json.decode(response.body)));
  }

  @override
  Future<Callflow> read(String flowId) async {
    final response =
        await get('/call-flows/$flowId', hostname: BaseService.voiceEndpoint);
    return Future.value(Callflow.fromJson(json.decode(response.body)));
  }

  @override
  Future<void> remove(String flowId) =>
      delete('/call-flows/$flowId', hostname: BaseService.voiceEndpoint);

  @override
  Future<Callflow> update(
      String flowId, Map<String, dynamic> parameters) async {
    final response = await put('/call-flows',
        hostname: BaseService.voiceEndpoint, body: parameters);
    return Future.value(Callflow.fromJson(json.decode(response.body)));
  }
}
