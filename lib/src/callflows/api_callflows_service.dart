import '../general/model/base_service.dart';
import 'callflows_service.dart';
import 'model/callflow.dart';

/// API implementation of [CallflowsService].
class ApiCallflowsService extends BaseService implements CallflowsService {
  /// Constructor.
  ApiCallflowsService(String accessKey, {int timeout, List<String> features})
      : super(accessKey, timeout: timeout, features: features);

  @override
  Future<Callflow> create(Callflow callflow) => post('/call-flows',
          hostname: BaseService.voiceEndpoint, body: callflow.toMap())
      .then((response) => Future.value(
          response?.body == null ? null : Callflow.fromJson(response.body)));

  @override
  Future<List<Callflow>> list({int page, int perpage}) => get('/call-flows',
          hostname: BaseService.voiceEndpoint,
          body: {'page': page, 'perpage': perpage})
      .then((response) => Future.value(response?.body == null
          ? null
          : Callflow.fromJsonList(response.body)));

  @override
  Future<Callflow> read(String id) => get('/call-flows/$id',
          hostname: BaseService.voiceEndpoint)
      .then((response) => Future.value(
          response?.body == null ? null : Callflow.fromJson(response.body)));

  @override
  Future<void> remove(String id) =>
      delete('/call-flows/$id', hostname: BaseService.voiceEndpoint);

  @override
  Future<Callflow> update(Callflow callflow) => put(
          '/call-flows/${callflow.id}',
          hostname: BaseService.voiceEndpoint,
          body: callflow.toMap())
      .then((response) => Future.value(
          response?.body == null ? null : Callflow.fromJson(response.body)));
}
