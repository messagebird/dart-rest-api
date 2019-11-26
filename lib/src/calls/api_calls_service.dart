import 'package:messagebird_dart/src/callflows/model/callflow.dart';
import 'package:messagebird_dart/src/general/model/base_service.dart';
import 'package:messagebird_dart/src/webhooks/model/webhook.dart';
import 'calls_service.dart';
import 'model/call.dart';

/// API implementation of [CallsService].
class ApiCallsService extends BaseService implements CallsService {
  /// Constructor.
  ApiCallsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Call> create(Call call, Callflow callflow, {Webhook webhook}) =>
      post('/calls',
              hostname: BaseService.voiceEndpoint,
              body: call.toMap()
                ..addAll({'callFlow': callflow.toMap()})
                ..addAll(webhook == null ? {} : {'webhook': webhook.toMap()}))
          .then((response) => Future.value(Call.fromJson(response.body)));

  @override
  Future<List<Call>> list() =>
      get('/calls', hostname: BaseService.voiceEndpoint)
          .then((response) => Future.value(Call.fromJsonList(response.body)));

  @override
  Future<Call> read(String id) =>
      get('/calls/$id', hostname: BaseService.voiceEndpoint)
          .then((response) => Future.value(Call.fromJson(response.body)));

  @override
  Future<void> remove(String id) =>
      delete('/calls/$id', hostname: BaseService.voiceEndpoint);
}
