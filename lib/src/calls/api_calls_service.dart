import '../base_service.dart';
import 'calls_service.dart';
import 'model/call.dart';

/// API implementation of [CallsService].
class ApiCallsService extends BaseService implements CallsService {
  /// Constructor.
  ApiCallsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Call> create(Call call) =>
      post('/calls', hostname: BaseService.voiceEndpoint, body: call.toMap())
          .then((response) => Future.value(Call.fromJson(response.body)));

  @override
  Future<List<Call>> list() =>
      get('/calls', hostname: BaseService.voiceEndpoint)
          .then((response) => Future.value(Call.fromJsonList(response.body)));

  @override
  Future<Call> read(int id) =>
      get('/calls/$id', hostname: BaseService.voiceEndpoint)
          .then((response) => Future.value(Call.fromJson(response.body)));

  @override
  Future<void> remove(int id) =>
      delete('/calls/$id', hostname: BaseService.voiceEndpoint);
}
