import 'dart:convert';

import 'package:messagebird_dart/src/general/model/api_error.dart';

import '../base_service.dart';
import 'calls_service.dart';
import 'model/call.dart';
import 'model/calls.dart';

/// API implementation of callflows service.
class ApiCallsService extends BaseService implements CallsService {
  /// Constructor.
  ApiCallsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Call> create(Map<String, dynamic> parameters) async {
    final response = await post('/calls',
        hostname: BaseService.voiceEndpoint, body: parameters);
    if (response.statusCode == 201) {
      return Future.value(Call.fromJson(json.decode(response.body)));
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }

  @override
  Future<Calls> list() async {
    final response = await get('/calls', hostname: BaseService.voiceEndpoint);
    if (response.statusCode == 200) {
      return Future.value(Calls.fromJson(json.decode(response.body)));
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }

  @override
  Future<Call> read(int callId) async {
    final response =
        await get('/calls/$callId', hostname: BaseService.voiceEndpoint);
    if (response.statusCode == 200) {
      return Future.value(Call.fromJson(json.decode(response.body)));
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }

  @override
  Future<void> remove(int callId) async {
    final response =
        await delete('/calls/$callId', hostname: BaseService.voiceEndpoint);
    if (response.statusCode == 200) {
      return;
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }
}
