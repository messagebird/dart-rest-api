import 'dart:convert';

import '../base_service.dart';
import 'callflows_service.dart';
import 'model/callflow.dart';

/// API implementation of [CallflowsService].
class ApiCallflowsService extends BaseService implements CallflowsService {
  /// Constructor.
  ApiCallflowsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Callflow> create(Callflow callflow) async {
    final response = await post('/call-flows',
        hostname: BaseService.voiceEndpoint, body: callflow.toJson());
    return Future.value(Callflow.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<List<Callflow>> list(int page, int perpage) async {
    final response = await get('/call-flows',
        hostname: BaseService.voiceEndpoint,
        body: {'page': page, 'perpage': perpage});
    return Future.value(
        Callflow.fromJsonList(json.decode(response.body)['data']));
  }

  @override
  Future<Callflow> read(String id) async {
    final response =
        await get('/call-flows/$id', hostname: BaseService.voiceEndpoint);
    return Future.value(Callflow.fromJson(json.decode(response.body)['data']));
  }

  @override
  Future<void> remove(String id) =>
      delete('/call-flows/$id', hostname: BaseService.voiceEndpoint);

  @override
  Future<Callflow> update(Callflow callflow) async {
    final response = await put('/call-flows/${callflow.id}',
        hostname: BaseService.voiceEndpoint, body: callflow.toJson());
    return Future.value(Callflow.fromJson(json.decode(response.body)['data']));
  }
}
