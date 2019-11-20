import 'dart:convert';

import '../base_service.dart';
import 'calls_service.dart';
import 'model/call.dart';
import 'model/calls.dart';

/// API implementation of [CallsService].
class ApiCallsService extends BaseService implements CallsService {
  /// Constructor.
  ApiCallsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Call> create(Map<String, dynamic> parameters) async {
    final response = await post('/calls',
        hostname: BaseService.voiceEndpoint, body: parameters);
    return Future.value(Call.fromJson(json.decode(response.body)));
  }

  @override
  Future<Calls> list() async {
    final response = await get('/calls', hostname: BaseService.voiceEndpoint);
    return Future.value(Calls.fromJson(json.decode(response.body)));
  }

  @override
  Future<Call> read(int callId) async {
    final response =
        await get('/calls/$callId', hostname: BaseService.voiceEndpoint);
    return Future.value(Call.fromJson(json.decode(response.body)));
  }

  @override
  Future<void> remove(int callId) =>
      delete('/calls/$callId', hostname: BaseService.voiceEndpoint);
}
