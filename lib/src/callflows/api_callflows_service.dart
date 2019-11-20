import 'dart:convert';

import '../base_service.dart';
import '../general/model/api_error.dart';
import 'callflows_service.dart';
import 'model/callflow.dart';
import 'model/callflows.dart';

/// API implementation of callflows service.
class ApiCallflowsService extends BaseService implements CallflowsService {
  /// Constructor.
  ApiCallflowsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Callflow> create(Map<String, dynamic> parameters) async {
    final response = await post('/call-flows',
        hostname: BaseService.voiceEndpoint, body: parameters);
    if (response.statusCode == 201) {
      return Future.value(Callflow.fromJson(json.decode(response.body)));
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }

  @override
  Future<Callflows> list(int page, int perpage) async {
    final response = await get('/call-flows',
        hostname: BaseService.voiceEndpoint,
        body: {'page': page, 'perpage': perpage});
    if (response.statusCode == 200) {
      return Future.value(Callflows.fromJson(json.decode(response.body)));
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }

  @override
  Future<Callflow> read(String flowId) async {
    final response =
        await get('/call-flows/$flowId', hostname: BaseService.voiceEndpoint);
    if (response.statusCode == 200) {
      return Future.value(Callflow.fromJson(json.decode(response.body)));
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }

  @override
  Future<void> remove(String flowId) async {
    final response = await delete('/call-flows/$flowId',
        hostname: BaseService.voiceEndpoint);
    if (response.statusCode == 200) {
      return;
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }

  @override
  Future<Callflow> update(
      String flowId, Map<String, dynamic> parameters) async {
    final response = await put('/call-flows',
        hostname: BaseService.voiceEndpoint, body: parameters);
    if (response.statusCode == 200) {
      return Future.value(Callflow.fromJson(json.decode(response.body)));
    } else {
      final ApiError error = ApiError.fromJson(json.decode(response.body));
      throw Exception(error.code);
    }
  }
}
